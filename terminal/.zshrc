# zsh configurations
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# bat: cat alternative
# alias bat='batcat' # only necessary for ubuntu
alias cat='bat --plain --theme OneHalfDark'

# starship: prompt customisation
eval "$(starship init zsh)"

# eza: an alternative to ls
alias ls="eza --color=always --git --icons=always --time-style relative --group-directories-first"

# fd: an alternative to find
# alias fd='fdfind' # only on ubuntu

# fzf

source <(fzf --zsh) # on last version
# source /usr/share/doc/fzf/examples/key-bindings.zsh # previous versions
# source /usr/share/doc/fzf/examples/completion.zsh # previous versions

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; e
lse bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
