return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
	},
	keys = {
		{ "<F5>", function() require("dap").continue() end, desc = "Debug: Continue" },
		{ "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
		{ "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
		{ "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Condition: "))
			end,
			desc = "Conditional Breakpoint",
		},
		{ "<leader>dc", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
		{ "<leader>dr", function() require("dap").restart() end, desc = "Restart" },
		{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
		{ "<leader>du", function() require("dapui").toggle() end, desc = "Toggle Debug UI" },
		{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "x" } },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()

		dap.listeners.after.event_initialized.dapui = dapui.open
		dap.listeners.before.event_terminated.dapui = dapui.close
		dap.listeners.before.event_exited.dapui = dapui.close

		local lldb_dap = vim.fn.exepath("lldb-dap")
		if lldb_dap == "" and vim.fn.has("mac") == 1 then
			lldb_dap = vim.trim(vim.fn.system({ "xcrun", "-f", "lldb-dap" }))
		end
		dap.adapters.lldb = { type = "executable", command = lldb_dap, name = "lldb" }

		dap.configurations.cpp = {
			{
				name = "Build and debug",
				type = "lldb",
				request = "launch",
				program = function()
					local cpp = require("Adesh.core.cpp")
					if not cpp.build() then
						return dap.ABORT
					end
					local co, result = coroutine.running(), nil
					cpp.pick_executable(function(exe)
						result = exe or dap.ABORT
						-- the picker may answer synchronously, before we yield
						if coroutine.status(co) == "suspended" then
							coroutine.resume(co, result)
						end
					end)
					return result or coroutine.yield()
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}
		dap.configurations.c = dap.configurations.cpp
	end,
}
