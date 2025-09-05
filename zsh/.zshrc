# =============================================================================
# Platform-Specific Configurations
# =============================================================================

# ----------------- homebrew (macOS) --------------------------------
# Only run this on macOS (Darwin kernel)
if [[ "$(uname)" == "Darwin" ]]; then
  # Check for Homebrew executable and initialize it
  if [ -x "/opt/homebrew/bin/brew" ]; then
    # Apple Silicon path
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x "/usr/local/bin/brew" ]; then
    # Intel Mac path
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# =============================================================================
# Environment & Tool Configurations
# =============================================================================

# ----------- conda (python env) ----------------------------
# Use $HOME to make the path portable
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup


# -------------- NVM (node env) ---------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# -------------------------- bun -----------------------------
# bun completions - use $HOME for portability
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun path
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# =============================================================================
# Shell Enhancements & Aliases
# =============================================================================

# ----------------------------FZF-----------------------------
# setup fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# -- Use fd instead of the default find for better performance --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd for path completion
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


# ------------------- BAT ----------------------------
# Set your preferred theme for bat
export BAT_THEME="catppuccin_mocha"


# ------------------- EZA ----------------------------
# Modern replacement for 'ls'
alias ls="eza --color=always --icons=always"


# ----------------- zoxide ---------------------------
# A smarter cd command
eval "$(zoxide init zsh)"
alias cd="z"


# ------------- starship (better prompt) -------------
# Cross-shell prompt
eval "$(starship init zsh)"
