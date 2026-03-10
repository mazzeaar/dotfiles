autoload -Uz compinit
compinit

bindkey -v
bindkey '^?' backward-delete-char
export KEYTIMEOUT=1

alias ls='ls -G'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

ethvpn() {
  sudo -E openconnect \
    --protocol=anyconnect \
    --authgroup=student-net \
    --user='amazzetta@student-net.ethz.ch' \
    sslvpn.ethz.ch
}
