autoload -Uz compinit vcs_info
compinit

bindkey -v
bindkey '^?' backward-delete-char
export KEYTIMEOUT=1

setopt prompt_subst

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '*'

precmd() { vcs_info; }

PROMPT='%F{cyan}%~%f %F{yellow}${vcs_info_msg_0_}%f %(?.%F{green}.%F{red})❯%f '

alias ls='ls -G'

ethvpn() {
  sudo -E openconnect \
    --protocol=anyconnect \
    --authgroup=student-net \
    --user='amazzetta@student-net.ethz.ch' \
    sslvpn.ethz.ch
}
