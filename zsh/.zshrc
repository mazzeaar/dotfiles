#initialize brew autocompletions
autoload -Uz compinit
compinit

bindkey -v
bindkey -v '^?' backward-delete-char

export KEYTIMEOUT=1

#initialize starship
eval "$(starship init zsh)"

#alias for parallel make
alias makep="make -j8"

#enable colors for ls
alias ls="ls -G"

#enable lowercase insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# catpucching theme for fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

