require("luau-lsp").config {
	sourcemap = {
		enabled = true,
		autogenerate = true,
		rojo_project_file = "./dev.project.json",
		sourcemap_file = "./sourcemap.json",
	},
}
