# Local development setup

- [Tools](#tools)
  - [For macOS](#for-macos)
    - [iTerm](#iterm)
  - [For Unix-based OS](#for-unix-based-os)
    - [oh-my-zsh](#oh-my-zsh)
    - [starship](#starship)
    - [eza](#eza)
    - [bat](#bat)
    - [fzf](#fzf)
    - [fd](#fd)
    - [nano](#nano)

## Tools
### [iTerm](https://github.com/gnachman/iTerm2) (macOS)
- Description: A very good terminal emulator for macOS

Snazzy color preset

NerdFonts

```
brew install font-fira-code-nerd-font
```

### [nano](https://github.com/madnight/nano)
- Description: GNU nano text editor

#### Configuration

Install nano depending on your OS and then add this [.nanorc](terminal/.nanorc) to your `$HOME` path

### [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- Description: Community driven framework for managing zsh environments

#### Configuration

Follow the install guide depending on your OS.

Install the following plugins:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) zsh-syntax-highlighting
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Configurations for `oh-my-zsh`

```
# zsh configurations

export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
```

### [starship](https://github.com/starship/starship)
- Description: Minimal, fast, customisable cross-shell prompt

Follow the install guide depending on your OS and add your respective source command to the `.zshrc` file

```
eval "$(starship init zsh)" # macOS
```

Configurations for starship [`~/.config/starship.toml`](terminal/starship.toml)

#### Configuration

### [eza](https://github.com/eza-community/eza)
- Description: A modern, maintained replacement for ls

Follow the install guide depending on your OS and add the following alias `.zshrc` file

```
alias ls="eza --color=always --git --icons=always --time-style relative --group-directories-first"
```

#### Configuration

### [bat](https://github.com/sharkdp/bat)
- Description: A cat clone with syntax highlighting and Git integration

Follow the install guide depending on your OS and add the following alias `.zshrc` file

```
alias cat='bat --plain --theme OneHalfDark'
```

### [fd](https://github.com/sharkdp/fd)
- Description: A simple, fast and user-friendly alternative to find

#### Configuration

Follow the install guide depending on your OS and add the following configurations to your `.zshrc` file


### [fzf](https://github.com/junegunn/fzf)
- Description: A command-line fuzzy finder

#### Configuration
Follow the install guide depending on your OS and add the following configurations to your `.zshrc` file

```
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

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
```