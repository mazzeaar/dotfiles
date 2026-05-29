local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
    cmd = {
        "julia",
        "--project=" .. vim.fn.expand("~/.julia/environments/lsp"),
        "--startup-file=no",
        "--history-file=no",
        "-e", [[
            using LanguageServer

            project_path = something(
                Base.current_project(),
                Base.load_path_expand("@v#.#"),
            )

            depot_path = get(ENV, "JULIA_DEPOT_PATH", "")

            symserver_store_path = joinpath(
                homedir(),
                ".cache",
                "nvim",
                "julials",
                "symbolstore"
            )

            mkpath(symserver_store_path)

            server = LanguageServer.LanguageServerInstance(
                stdin,
                stdout,
                project_path,
                depot_path,
                nothing,
                symserver_store_path,
            )

            server.runlinter = true
            run(server)
        ]],
    },

    filetypes = { "julia" },
    root_markers = { "Project.toml", "JuliaProject.toml", ".git" },
    capabilities = capabilities,
}
