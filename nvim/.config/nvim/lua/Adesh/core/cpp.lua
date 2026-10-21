local M = {}

local function cmake_root(buf)
	local found = vim.fs.find("CMakeLists.txt", {
		upward = true,
		limit = math.huge,
		path = vim.fs.dirname(vim.api.nvim_buf_get_name(buf)),
	})
	return found[#found] and vim.fs.dirname(found[#found]) or nil
end

local function build_dir(root)
	return root .. "/build"
end

local function configure_cmd(root)
	return { "cmake", "-S", root, "-B", build_dir(root), "-DCMAKE_BUILD_TYPE=Debug", "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" }
end

local function on_configured(res)
	if res.code ~= 0 then
		vim.notify(res.stderr ~= "" and res.stderr or res.stdout, vim.log.levels.ERROR)
		return false
	end
	-- clangd only looks for compile_commands.json when it starts
	pcall(vim.cmd, "lsp restart clangd")
	return true
end

function M.configure()
	local root = cmake_root(0)
	if not root then
		vim.notify("No CMakeLists.txt found", vim.log.levels.WARN)
		return
	end
	vim.notify("cmake: configuring " .. root)
	vim.system(configure_cmd(root), { text = true }, vim.schedule_wrap(function(res)
		if on_configured(res) then
			vim.notify("cmake: configured")
		end
	end))
end

function M.build()
	local root = cmake_root(0)
	if root and not vim.uv.fs_stat(build_dir(root) .. "/CMakeCache.txt") then
		vim.notify("cmake: configuring " .. root)
		if not on_configured(vim.system(configure_cmd(root), { text = true }):wait()) then
			return false
		end
	end
	vim.cmd("silent! wall")
	vim.cmd("silent make")
	vim.cmd("cwindow")
	return vim.v.shell_error == 0
end

local function executables(root)
	local dir = build_dir(root)
	local out = {}
	local skip = function(name)
		return name ~= "CMakeFiles"
	end
	for name, type in vim.fs.dir(dir, { depth = 3, skip = skip }) do
		local path = dir .. "/" .. name
		if type == "file" and not vim.fs.basename(name):find("%.%w+$") and vim.fn.executable(path) == 1 then
			table.insert(out, path)
		end
	end
	return out
end

function M.pick_executable(cb)
	local root = cmake_root(0)
	if not root then
		cb(vim.fn.expand("%:p:r"))
		return
	end
	local exes = executables(root)
	if #exes <= 1 then
		cb(exes[1])
		return
	end
	vim.ui.select(exes, {
		prompt = "Executable",
		format_item = function(path)
			return vim.fs.relpath(build_dir(root), path)
		end,
	}, cb)
end

function M.run()
	if not M.build() then
		return
	end
	M.pick_executable(function(exe)
		if not exe then
			vim.notify("No executable found", vim.log.levels.WARN)
			return
		end
		vim.cmd("botright 15new")
		vim.fn.jobstart({ exe }, { term = true, cwd = vim.fs.dirname(exe) })
		vim.cmd.startinsert()
	end)
end

local compilers = {
	c = "clang -std=c17",
	cpp = "clang++ -std=c++20",
}

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("cpp-build", { clear = true }),
	pattern = { "c", "cpp" },
	callback = function(ev)
		local root = cmake_root(ev.buf)
		if root then
			vim.bo[ev.buf].makeprg = "cmake --build " .. vim.fn.shellescape(build_dir(root)) .. " -j"
		else
			vim.bo[ev.buf].makeprg = compilers[ev.match]
				.. " -g -O0 -Wall -Wextra -fsanitize=address,undefined -o %:p:r:S %:p:S"
		end

		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "<leader>cb", M.build, vim.tbl_extend("force", opts, { desc = "Build" }))
		vim.keymap.set("n", "<leader>cr", M.run, vim.tbl_extend("force", opts, { desc = "Build and run" }))
		vim.keymap.set("n", "<leader>cg", M.configure, vim.tbl_extend("force", opts, { desc = "CMake configure" }))
	end,
})

return M
