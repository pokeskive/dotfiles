return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { 'lua', 'vim' },
            sync_install = false,
            auto_install = true,
            additional_vim_regex_highlighting = false,
        })
    end,
}
