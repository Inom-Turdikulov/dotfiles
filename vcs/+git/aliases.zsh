is-callable hub && alias git='hub'

# g = git status
# g ... = git $@
g() { [[ $# = 0 ]] && git status --short . || git $*; }
compdef g=hub

alias gbr='git browse'
alias gi='git init'
alias gf='git fetch'
alias gs='git status'
alias gst='git stash'
alias gstp='git stash pop'
alias gsu='git submodule'
alias grb='git rebase --autostash -i'
alias gco='git checkout'
alias gcoo='git checkout --'
alias gc='git commit -S'
alias gcm='noglob git commit -S -m'
alias gcma='noglob git commit --amend -S -m'
alias gcf='noglob git commit -S --fixup'
alias gC='git commit'
alias gCm='noglob git commit -m'
alias gCma='noglob git commit --amend -m'
alias gCf='noglob git commit --fixup'
alias gcl='git clone'
alias gcp='git cherry-pick -S'
alias gd='git diff'
alias gp='git push'
alias gpb='git push origin'
alias gpt='git push --follow-tags'
alias gpl='git pull --rebase --autostash'
alias ga='git add'
alias gau='git add -u'
alias gb='git branch'
alias gbo'git orphan'
alias gbd='git branch -D'
alias gbl='git blame'
alias gap='git add --patch'
alias gr='git reset HEAD'
alias gt='git tag'
alias gtd='git tag -d'
alias gta='git tag -a'
alias gl='git log --oneline --decorate --graph'
alias gls='git log --oneline --decorate --graph --stat'

