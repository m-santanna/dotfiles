# ----------------- homebrew --------------------------------
eval "$(/opt/homebrew/bin/brew shellenv)"

# ----------- conda (python env) ----------------------------
__conda_setup="$('/Users/matheusss03/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/matheusss03/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/matheusss03/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/matheusss03/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# -------------- NVM (node env) ---------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# -------------------------- bun -----------------------------
# bun completions
[ -s "/Users/matheusss03/.bun/_bun" ] && source "/Users/matheusss03/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ----------------------------FZF-----------------------------

# setup fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# -- Use fd instead of the default find --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# ------------------- BAT ----------------------------
export BAT_THEME="catppuccin_mocha"


# ------------------- EZA ----------------------------
# EZA_CONFIG_DIR="/Users/matheusss03/.config/eza/"
alias ls="eza --color=always --icons=always"

# ----------------- zoxide ---------------------------
eval "$(zoxide init zsh)"
alias cd="z"

# ------------- starship (better prompt) -------------
eval "$(starship init zsh)"
