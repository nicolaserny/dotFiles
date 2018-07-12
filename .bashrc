# bash in vi mode
set -o vi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# fzf configuration
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--extended"

alias ls='ls -G'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_git_branch_for_push() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# customize prompt with git branch name
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# git aliases
alias gitg='git log --graph --decorate --oneline --all'
alias gitp="git push origin $(parse_git_branch_for_push)"
alias gitpf="git push -f origin $(parse_git_branch_for_push)"

# vim aliases
alias nvimu='vim +PlugInstall +UpdateRemotePlugins +PlugUpgrade +PlugUpdate +qa!'
