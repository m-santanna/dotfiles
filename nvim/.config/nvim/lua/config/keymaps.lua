-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ============================================================================
-- Tmux/Nvim Navigation with Window Support at Edges
-- ============================================================================
-- Ctrl-h/j/k/l navigate between:
-- 1. Neovim splits (within nvim)
-- 2. Tmux panes (when at nvim edge)
-- 3. Tmux windows (when at both nvim AND tmux pane edge, for h/l only)

-- Helper: check if we're in tmux
local function in_tmux()
  return vim.env.TMUX ~= nil
end

-- Helper: execute tmux command
local function tmux(cmd)
  vim.fn.system("tmux " .. cmd)
end

-- Helper: get tmux format value
local function tmux_get(fmt)
  local result = vim.fn.system("tmux display-message -p '#{" .. fmt .. "}'")
  return vim.trim(result)
end

-- Helper: check if tmux pane is at edge
local function tmux_pane_at_edge(direction)
  if not in_tmux() then
    return false
  end
  local edge_map = {
    h = "pane_at_left",
    l = "pane_at_right",
    j = "pane_at_bottom",
    k = "pane_at_top",
  }
  return tmux_get(edge_map[direction]) == "1"
end

-- Smart navigation function
local function navigate(direction)
  local current_win = vim.fn.winnr()
  vim.cmd("wincmd " .. direction)

  -- If we didn't move (at nvim edge)
  if vim.fn.winnr() == current_win then
    if in_tmux() then
      if tmux_pane_at_edge(direction) then
        -- At both nvim AND tmux edge: navigate windows (only for h/l)
        if direction == "h" then
          tmux("previous-window")
        elseif direction == "l" then
          tmux("next-window")
        end
        -- For j/k at edge, do nothing (stop)
      else
        -- At nvim edge but not tmux edge: navigate tmux panes
        local pane_map = { h = "L", l = "R", j = "D", k = "U" }
        tmux("select-pane -" .. pane_map[direction])
      end
    end
  end
end

-- Override LazyVim's default C-h/j/k/l keymaps
vim.keymap.set("n", "<C-h>", function()
  navigate("h")
end, { desc = "Navigate Left", silent = true })
vim.keymap.set("n", "<C-j>", function()
  navigate("j")
end, { desc = "Navigate Down", silent = true })
vim.keymap.set("n", "<C-k>", function()
  navigate("k")
end, { desc = "Navigate Up", silent = true })
vim.keymap.set("n", "<C-l>", function()
  navigate("l")
end, { desc = "Navigate Right", silent = true })
