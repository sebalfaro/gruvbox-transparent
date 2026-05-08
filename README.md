# gruvbox-transparent

A custom Neovim colorscheme based on Gruvbox tones with full transparency support, Treesitter, LSP, Bufferline, GitSigns, Markview, and DevIcons integration.

## Installation (LazyVim)

Add a file like `~/.config/nvim/lua/plugins/colorscheme.lua`:

```lua
return {
  {
    "sebalfaro/gruvbox-transparent",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true, -- set to false for a solid background
      variant = "dark",   -- "dark" or "light"
    },
    config = function(_, opts)
      require("gruvbox-transparent").setup(opts)
      vim.cmd.colorscheme("gruvbox-transparent")
    end,
  },
}
```

## Options

| Option        | Default   | Description                          |
|---------------|-----------|--------------------------------------|
| `transparent` | `false`   | Enable transparent background        |
| `variant`     | `"dark"`  | Color variant: `"dark"` or `"light"` |

The variant can also be overridden at runtime via the `THEME_VARIANT=light` environment variable.

## Features

- Gruvbox-inspired palette
- Transparent background mode
- LSP diagnostics with Nerd Font icons
- Bufferline, GitSigns, Markview, and DevIcons highlights
- CursorLine toggled automatically on insert mode
