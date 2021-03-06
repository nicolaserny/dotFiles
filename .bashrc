# bash in vi mode
set -o vi
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

unset _fzf_completion_loaded
source ~/Developer/my-configs/git-completion.bash
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
alias gits='git status'
alias gitp="parse_git_branch_for_push | xargs -o git push origin HEAD:" 
alias gitpf="parse_git_branch_for_push | xargs -o git push -f origin HEAD:" 

# vim aliases
alias nvimu='nvim +PlugUpgrade +PlugUpdate +qa!'

# kubernetes aliases
alias kc='kubectl'
