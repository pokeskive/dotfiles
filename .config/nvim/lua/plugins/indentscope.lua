return {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
        require('mini.indentscope').setup({
            draw = {
                animation = require('mini.indentscope').gen_animation.none(),
            },
        })
    end,
}
