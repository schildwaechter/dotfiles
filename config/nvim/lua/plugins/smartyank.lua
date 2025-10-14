return {
	'ibhagwan/smartyank.nvim',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        highlight = {
            timeout = 300,
        },
        tmux = {
            enabled = false,
        }
    },
}
