#!/bin/zsh

#===============================#
#                               #
#            Zinit				      #
#                               #
#===============================#

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

### Zinit's plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
# zinit light zdharma/fast-syntax-highlighting

### Zinit's config
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions



#========================#
#                        #
#         Inits          #
#                        #
#========================#

# asdf initialization

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/anderneo/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/anderneo/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/anderneo/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/anderneo/Downloads/google-cloud-sdk/completion.zsh.inc'; fi



#========================#
#                        #
#       Autoloads        #
#                        #
#========================#

autoload -U compinit && compinit
autoload -U zmv



#========================#
#                        #
#         Evals          #
#                        #
#========================#

eval "$(fzf --zsh)"

# Load DIR_COLORS
if type dircolors >/dev/null 2>&1; then
    test -r ~/.dir_colors && eval "$(dircolors -b ${HOME}/.dotfiles/dir_colors/dir_colors)"
fi



#===============================#
#                               #
#            Source				      #
#                               #
#===============================#

#Syntax Highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Zsh Substring Search
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Fzf
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
GITSTATUS_LOG_LEVEL=DEBUG

