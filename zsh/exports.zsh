#!/bin/zsh

#===============================#
#                               #
#           Exports             #
#                               #
#===============================#

# Homebrew
export PATH=/opt/homebrew/bin/:$PATH

# Dircolors
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# Python
# export PATH="/usr/local/opt/homebrew/opt/python@3.10/libexec/bin:$PATH"


# asdf Laungage Version Manager
. ~/.asdf/plugins/java/set-java-home.zsh # Java Plugin

# C Programming & Go
export CC='clang'
export GOPATH=$HOME/go
export GOROOT="/opt/homebrew/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"


# Locale/Langs
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LC_TIME='pt_BR.UTF-8'
export LC_MONETARY='pt_BR.UTF-8'
export LC_CTYPE='en_US.UTF-8'

# Programs
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="qutebrowser"
export FILE_BROWSER="ranger"
export VID_PLAYER="vlc"
export AUDIO_PLAYER="mpd"

# Monitors
export MONITOR_MAIN="HDMI-0"
export MONITOR_LEFT="DVI-I-1"
export MONITOR_RIGHT="DVI-D-0"

# Fzf
export FZF_COMPLETION_TRIGGER=">>" # Trigger
export FZF_COMPLETION_OPTS="-x +c" # args/command line options
export FZF_DEFAULT_COMMAND='fd ""' # use ag instead of find
# export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'
export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout=reverse --border --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Help Alias
export HELPDIR="/opt/homebrew/share/zsh/help"

# Glances
export PATH="/opt/homebrew/bin:$PATH"
# S-tui
export PATH="$PATH:/Users/anderneo/.asdf/shims:/opt/homebrew/bin"

# Sbin
export PATH="/opt/homebrew/sbin:$PATH"

#===============================#
#                               #
#     Auto Inserted Exports     #
#                               #
#===============================#

# Talisman
export TALISMAN\_HOME=$HOME/.talisman/bin

# asdf java path
export PATH="${HOME}/.asdf/installs/java/graalvm-community-21.0.2/bin:$PATH"

# Created by `pipx` on 2024-07-24 17:25:21
export PATH="$PATH:/Users/anderneo/.local/bin"

