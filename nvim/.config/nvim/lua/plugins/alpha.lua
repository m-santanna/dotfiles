return {
  'goolord/alpha-nvim',
  -- dependencies = { 'echasnovski/mini.icons' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local theme = require 'alpha.themes.startify'
    -- available: devicons, mini, default is mini
    -- if provider not loaded and enabled is true, it will try to use another provider
    theme.file_icons.provider = 'devicons'
    theme.section.header.val = {
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
    }
    require('alpha').setup(theme.config)
  end,
}
