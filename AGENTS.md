# Agent Guidelines for dotFiles Repository

## Build/Test Commands
- No build system (shell scripts, config files only)
- Test configuration: `nvim --headless -c "q"` to verify Neovim config
- Lint tmux config: `tmux source ~/.tmux.conf` 
- Reload shell: `source ~/.zshrc`

## Technologies
- **Lua**: Neovim configuration (4 spaces, no semicolons)
- **Shell**: Bash scripts for tmux utilities
- **Zsh**: Shell configuration with oh-my-zsh
- **Tmux**: Terminal multiplexer configuration

## Code Style
- **Lua indentation**: 4 spaces, no tabs (`vim.opt.tabstop = 4`, `vim.opt.expandtab = true`)
- **Variable naming**: snake_case for lua locals, camelCase for vim options
- **Quotes**: Single quotes preferred in Lua, double quotes in shell
- **Functions**: Use `function()` syntax in Lua, avoid inline declarations
- **Imports**: Use `require()` at top of files, group by functionality

## File Structure
- Neovim config in `nvim/lua/` with modular plugin structure
- Shell configs in root: `.zshrc`, tmux in `tmux/`
- Scripts in `.local/scripts/` (executable, shebang required)
- Plugin configs in `nvim/lua/plugins/` as return tables