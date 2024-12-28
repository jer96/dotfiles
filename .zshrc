export EDITOR='nvim'
export VISUAL='nvim'
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"
alias ssh_start='eval "$(ssh-agent -s)"; ssh-add ~/.ssh/id_ed25519'

git_ignoreadd() {
    if [ -z "$1" ]; then
        echo "usage: git_ignoreadd <path>"
        return 1
    fi
    echo "!$1" >> .gitignore
    echo "added !$1 to .gitignore whitelist"
}

. "$HOME/.local/bin/env"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

export PATH="/Applications/quarto/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"