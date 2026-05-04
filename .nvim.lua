local projectFile = "./dev.project.json"

require("luau-lsp").config {
	sourcemap = {
		enabled = true,
		autogenerate = true,
		generator_cmd = { "rojo", "sourcemap", "--watch", "-o", "sourcemap.json", projectFile },
	},
}
