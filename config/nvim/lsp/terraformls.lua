return {
    filetypes = { "terraform" },
    settings = {
        terraform = {
            experiments = {
                enabled = true,
            },
            trace = {
                server = "verbose",
            },
            format = {
                enabled = true,
            },
            lint = {
                enabled = true,
                checks = {
                    All = true,
                    DeprecatedResource = true,
                    DuplicateResource = true,
                    EmptyBlock = true,
                    InvalidAttributeValueType = true,
                    InvalidResourceType = true,
                    MissingRequiredArgument = true,
                    NoProviderConfigured = true,
                    UnusedBlockLabel = true,
                    UnusedResource = true,
                },
            },
        },
    },
    cmd = { "terraform-ls", "serve" },
    on_attach = function(client)
        client.server_capabilities.semanticTokensProvider = nil
    end,
    root_markers = { ".git" },
}
