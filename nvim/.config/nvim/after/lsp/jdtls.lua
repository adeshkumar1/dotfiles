local function jdk_home(version)
	local res = vim.system({ "/usr/libexec/java_home", "-F", "-v", version }, { text = true }):wait()
	return res.code == 0 and vim.trim(res.stdout) or nil
end

-- jdtls itself needs Java 21+, but jenv pins JAVA_HOME to whatever the shell defaults to
local launcher_jdk = jdk_home("21")
local lombok = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"

local cmd = { "jdtls" }
if launcher_jdk then
	table.insert(cmd, "--java-executable=" .. launcher_jdk .. "/bin/java")
end
if vim.uv.fs_stat(lombok) then
	table.insert(cmd, "--jvm-arg=-javaagent:" .. lombok)
end

-- java_home resolves 1.8 to the browser-plugin JRE, so point at the JDK directly
local runtimes = {
	{ name = "JavaSE-1.8", path = "/Library/Java/JavaVirtualMachines/jdk1.8.0_331.jdk/Contents/Home", default = true },
}
for _, v in ipairs({ "11", "17", "21" }) do
	local home = jdk_home(v)
	if home then
		table.insert(runtimes, { name = "JavaSE-" .. v, path = home })
	end
end

return {
	cmd = cmd,
	filetypes = { "java" },
	root_markers = { "settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts", "pom.xml", ".git" },
	init_options = {
		extendedClientCapabilities = { classFileContentsSupport = true },
	},
	settings = {
		java = {
			configuration = { runtimes = runtimes },
			maven = { downloadSources = true },
			inlayHints = { parameterNames = { enabled = "all" } },
		},
	},
}
