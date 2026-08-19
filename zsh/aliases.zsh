#!/bin/zsh

#===============================#
#                               #
#           ALIASES             #
#                               #
#===============================#

alias ffs='eval "sudo $(fc -ln -1)"'

# CD
alias ..="cs .."
alias ...="cs ../.."
alias ....="cs ../../.."
alias .....="cs ../../../.."
alias ......="cs ../../../../.."

# ls
alias ls="lsd --group-dirs first"
alias lh="lsd -hl"
alias la="lsd -la"
alias lah="lsd -Alh"


# mkdir
alias mk='mkdir_plus_ls'

# cp
alias cp="cp -i"
alias cps="cp && cs"

# mv
alias mv="mv -i"
alias mvs="mv && cs"

# Use less fuck
alias sl=ls

# CAREFUL
alias rm="trash"
alias Rm="sudo trash"
alias RM="sudo trash"

alias paste='~/scripts/pb'
alias backup-system='sudo /home/jack/scripts/backup-system'
alias ffmpeg-recursive='/home/jack/scripts/helpers/plex/ffmpeg-recursive.py'
alias music-reload='~/scripts/audio/music-reload.sh'
alias installfont='sudo fc-cache -f -v'
alias pdf='masterpdfeditor5'
alias TERM.kitty='export TERM=xterm-kitty'
alias TERM.xterm='export TERM=xterm-256color'
alias reload='source ~/.zshrc && exec zsh'
# alias git=hub
alias py="python"
alias py2="python2"
alias bpy="bpython"
alias ppy="ptpython"
alias ptpy="ptpython"
alias SS=ag
alias music=ncmpcpp
alias email=neomutt
alias newsbeuter=newsboat
alias mutt=neomutt
alias ls-fonts=xlsfonts
alias nvidiatop=nvtop
alias P='yaourt'
alias copy=cp
alias notes="ranger ~/Documents/notes"
alias printenv='printenv | grep --invert-match "LS_COLORS"'

alias zshrc="subl ~/.zshrc"
alias pip=pip3
alias python=python3
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias restart="exec zsh -l"
alias k="kubectl"
alias cmdd="cat ~/cmddescribe.txt | fzf"

alias help=run-help

alias ags='fzf_ag_search'

alias vs='open -a "Visual Studio Code"'
alias zed="open -a /Applications/Zed.app -n"
alias talisman=/Users/anderneo/.talisman/bin/talisman_darwin_arm64\n\n

# # Most used git command should be short.
# alias s='git status -sb'

# alias ga='git add -A'
# alias gap='ga -p'

# alias gbr='git branch -v'

# alias gch='git cherry-pick'

# alias gcm='git commit -v --amend'

# alias gco='git checkout'

# alias gd='git diff -M'
# alias gd.='git diff -M --color-words="."'
# alias gdc='git diff --cached -M'
# alias gdc.='git diff --cached -M --color-words="."'

# alias gf='git fetch'

# # Helper function.
# git_current_branch() {
#   cat "$(git rev-parse --git-dir 2>/dev/null)/HEAD" | sed -e 's/^.*refs\/heads\///'
# }

# alias glog='git log --date-order --pretty="format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset"'
# alias gl='glog --graph'
# alias gla='gl --all'

# alias gm='git merge --no-ff'
# alias gmf='git merge --ff-only'

# alias gp='git push'
# alias gpthis='gp origin $(git_current_branch)'
# alias gpthis!='gp --set-upstream origin $(git_current_branch)'

# alias grb='git rebase -p'
# alias grba='git rebase --abort'
# alias grbc='git rebase --continue'
# alias grbi='git rebase -i'

# alias gr='git reset'
# alias grh='git reset --hard'
# alias grsh='git reset --soft HEAD~'

# alias grv='git remote -v'

# alias gs='git show'
# alias gs.='git show --color-words="."'

# alias gst='git stash'
# alias gstp='git stash pop'
# alias gsp='git stash && git pull && git stash pop'
