# Enable Powerlevel10k instant prompt...
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 1. Load priority files first
source "${HOME}/.dotfiles/zsh/exports.zsh"
source "${HOME}/.dotfiles/zsh/oh-my-zsh.zsh"
source "${HOME}/.dotfiles/zsh/sources.zsh"

# 2. Blindly load everything else (functions, styles, new modules)
for f in ${HOME}/.dotfiles/zsh/*.zsh; do
  case $(basename "$f") in
    # Skip files we explicitly load to prevent running them twice
    aliases.zsh|exports.zsh|oh-my-zsh.zsh|sources.zsh) ;;
    *) source "$f" ;;
  esac
done
unset f

# 3. Load aliases last so they override everything else
source "${HOME}/.dotfiles/zsh/aliases.zsh"

# 4. Clean up PATH
if [[ -x /usr/bin/awk ]]; then 
  export PATH="$(echo "$PATH" | /usr/bin/awk 'BEGIN { RS=":"; } { sub(sprintf("%c$", 10), ""); if (A[$0]) {} else { A[$0]=1; printf(((NR==1) ?"" : ":") $0) }}')" ; 
fi