alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias cdg='cd `git rev-parse --show-toplevel`'

alias q=exit
alias clr=clear
alias sudo='sudo '
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'
alias ports='netstat -tulanp'

alias mk=make
alias gurl='curl --compressed'

alias shutdown='sudo shutdown'
alias reboot='sudo reboot'

# A rsync that respects gitignore
rcp() {
  rsync -azP --delete --delete-after \
    --include=.git/ \
    --filter=':- .gitignore' \
    --filter=":- $XDG_CONFIG_HOME/git/ignore" \
    "$@"
}; compdef rcp=rsync
rcpd() { rcp "$1/" "$2" }

alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -out'

alias jc='journalctl -xe'
alias sc=systemctl
alias ssc='sudo systemctl'

if command -v exa >/dev/null; then
  alias exa="exa --group-directories-first --git";
  alias l="exa -1";
  alias ll="exa -lg";
  alias la="LC_COLLATE=C exa -la";
fi

autoload -U zmv

take() {
  mkdir "$1" && cd "$1";
}; compdef take=mkdir

zman() {
  PAGER="less -g -I -s '+/^       "$1"'" man zshall;
}

# Create a reminder with human-readable durations, e.g. 15m, 1h, 40s, etc
r() {
  local time=$1; shift
  sched "$time" "notify-send --urgency=critical 'Reminder' '$@'; ding";
}; compdef r=sched
