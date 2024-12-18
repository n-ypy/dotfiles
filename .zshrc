# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 30

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tldr deno)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# aliases
alias vi="nvim"
alias vim="nvim"
alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


export PNPM_HOME="/home/okroshka_dclxvi/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export DENO_HOME="/home/okroshka_dclxvi/.deno/bin/"
case ":$PATH:" in
  *":$DENO_HOME:"*) ;;
  *) export PATH="$DENO_HOME:$PATH" ;;
esac

export NVIM="/opt/nvim/"
case ":$PATH:" in
  *":$NVIM:"*) ;;
  *) export PATH="$NVIM:$PATH" ;;
esac

export LIBRARY_PATH=/usr/lib/gcc/x86_64-linux-gnu/11
export CPLUS_INCLUDE_PATH=/usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11
export XDG_STATE_HOME="$HOME/.local/state"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Enable core dumps
ulimit -c unlimited

# This will check core_pattern value and send a warning
EXPECTED_PATTERN="/tmp/core.%e.%p"
CORE_PATTERN_PATH="/proc/sys/kernel/core_pattern"
CURRENT_PATTERN=$(cat $CORE_PATTERN_PATH)
ORANGE='\033[38;5;214m'
RESET='\033[0m'
if [[ "$CURRENT_PATTERN" != "$EXPECTED_PATTERN" ]]; then
  echo "${ORANGE}Warning: Core pattern current value: '$CURRENT_PATTERN'${RESET} (run fixcorepattern)"
fi

# Command to fix core_pattern (sudo needed)
fixcorepattern(){
  echo $EXPECTED_PATTERN | sudo tee $CORE_PATTERN_PATH && echo "Core pattern current value: '$(cat /proc/sys/kernel/core_pattern)'"
}

# Regexp cheat sheet
regexp() {
  printf "\n\e[1;34mRegular Expression Basics\e[0m\n"
  printf "%-30s %-50s\n" "Character" "Explanation"
  printf "%-30s %-50s\n" "---------" "-----------"
  printf "%-30s %-50s\n" "." "Anything. Any character except newline"
  printf "%-30s %-50s\n" "a" "The character a"
  printf "%-30s %-50s\n" "ab" "The string ab"
  printf "%-30s %-50s\n" "a|b" "a or b"
  printf "%-30s %-50s\n" "a*" "0 or more a's"
  printf "%-30s %-50s\n" "\\" "Escapes a special character"

  printf "\n\e[1;34mRegular Expression Quantifiers\e[0m\n"
  printf "%-30s %-50s\n" "Character" "Explanation"
  printf "%-30s %-50s\n" "---------" "-----------"
  printf "%-30s %-50s\n" "*" "0 or more"
  printf "%-30s %-50s\n" "+" "1 or more"
  printf "%-30s %-50s\n" "?" "0 or 1"
  printf "%-30s %-50s\n" "{2}" "Exactly 2"
  printf "%-30s %-50s\n" "{2, 5}" "Between 2 and 5"
  printf "%-30s %-50s\n" "{2,}" "2 or more"

  printf "\n\e[1;34mRegular Expression Groups\e[0m\n"
  printf "%-30s %-50s\n" "Character" "Explanation"
  printf "%-30s %-50s\n" "---------" "-----------"
  printf "%-30s %-50s\n" "(...)" "Capturing group"
  printf "%-30s %-50s\n" "(?P<Y>...)" "Capturing group named Y"
  printf "%-30s %-50s\n" "(?:...)" "Non-capturing group"
  printf "%-30s %-50s\n" "(?>...)" "Atomic group"
  printf "%-30s %-50s\n" "(?|...)" "Duplicate group numbers"
  printf "%-30s %-50s\n" "\\Y" "Match the Y'th captured group"
  printf "%-30s %-50s\n" "(?P=Y)" "Match the named group Y"
  printf "%-30s %-50s\n" "(?R)" "Recurse into entire pattern"
  printf "%-30s %-50s\n" "(?Y)" "Recurse into numbered group Y"
  printf "%-30s %-50s\n" "(?&Y)" "Recurse into named group Y"
  printf "%-30s %-50s\n" "\\g{Y}" "Match the named or numbered group Y"
  printf "%-30s %-50s\n" "\\g<Y>" "Recurse into named or numbered group Y"
  printf "%-30s %-50s\n" "(?#...)" "Comment"

  printf "\n\e[1;34mRegular Expression Character Classes\e[0m\n"
  printf "%-30s %-50s\n" "Character" "Explanation"
  printf "%-30s %-50s\n" "---------" "-----------"
  printf "%-30s %-50s\n" "[ab-d]" "One character of: a, b, c, d"
  printf "%-30s %-50s\n" "[^ab-d]" "One character except: a, b, c, d"
  printf "%-30s %-50s\n" "[\\b]" "Backspace character"
  printf "%-30s %-50s\n" "\\d" "One digit"
  printf "%-30s %-50s\n" "\\D" "One non-digit"
  printf "%-30s %-50s\n" "\\s" "One whitespace"
  printf "%-30s %-50s\n" "\\S" "One non-whitespace"
  printf "%-30s %-50s\n" "\\w" "One word character"
  printf "%-30s %-50s\n" "\\W" "One non-word character"

  printf "\n\e[1;34mRegular Expression Assertions\e[0m\n"
  printf "%-30s %-50s\n" "Character" "Explanation"
  printf "%-30s %-50s\n" "---------" "-----------"
  printf "%-30s %-50s\n" "^" "Start of string"
  printf "%-30s %-50s\n" "\\A" "Start of string, ignores m flag"
  printf "%-30s %-50s\n" "$" "End of string"
  printf "%-30s %-50s\n" "\\Z" "End of string, ignores m flag"
  printf "%-30s %-50s\n" "\\b" "Word boundary"
  printf "%-30s %-50s\n" "\\B" "Non-word boundary"
  printf "%-30s %-50s\n" "\\G" "Start of match"
  printf "%-30s %-50s\n" "(?=...)" "Positive lookahead"
  printf "%-30s %-50s\n" "(?!...)" "Negative lookahead"
  printf "%-30s %-50s\n" "(?<=...)" "Positive lookbehind"
  printf "%-30s %-50s\n" "(?<!...)" "Negative lookbehind"
  printf "%-30s %-50s\n" "(?()|)" "Conditional"

printf "\n\e[1;34mRegular Expression Flags\e[0m\n"
printf "%-30s %-50s\n" "Character" "Explanation"
printf "%-30s %-50s\n" "---------" "-----------"
printf "%-30s %-50s\n" "i" "Ignore case"
printf "%-30s %-50s\n" "m" "^ and $ match start and end of line"
printf "%-30s %-50s\n" "s" ". matches newline as well"
printf "%-30s %-50s\n" "x" "Allow spaces and comments"
printf "%-30s %-50s\n" "J" "Duplicate group names allowed"
printf "%-30s %-50s\n" "U" "Ungreedy quantifiers"
printf "%-30s %-50s\n" "(?iLmsux)" "Set flags within regex"

printf "\n\e[1;34mRegular Expression Special Characters\e[0m\n"
printf "%-30s %-50s\n" "Character" "Explanation"
printf "%-30s %-50s\n" "---------" "-----------"
printf "%-30s %-50s\n" "\\n" "Newline"
printf "%-30s %-50s\n" "\\r" "Carriage return"
printf "%-30s %-50s\n" "\\t" "Tab"
printf "%-30s %-50s\n" "\\0" "Null character"
printf "%-30s %-50s\n" "\\YYY" "Octal character YYY"
printf "%-30s %-50s\n" "\\xYY" "Hexadecimal character YY"
printf "%-30s %-50s\n" "\\x{YY}" "Hexadecimal character YY"
printf "%-30s %-50s\n" "\\cY" "Control character Y"

printf "\n\e[1;34mRegular Expression Posix Classes\e[0m\n"
printf "%-30s %-50s\n" "Character" "Explanation"
printf "%-30s %-50s\n" "---------" "-----------"
printf "%-30s %-50s\n" "[:alnum:]" "Letters and digits"
printf "%-30s %-50s\n" "[:alpha:]" "Letters"
printf "%-30s %-50s\n" "[:ascii:]" "Ascii codes 0 - 127"
printf "%-30s %-50s\n" "[:blank:]" "Space or tab only"
printf "%-30s %-50s\n" "[:cntrl:]" "Control characters"
printf "%-30s %-50s\n" "[:digit:]" "Decimal digits"
printf "%-30s %-50s\n" "[:graph:]" "Visible characters, except space"
printf "%-30s %-50s\n" "[:lower:]" "Lowercase letters"
printf "%-30s %-50s\n" "[:print:]" "Visible characters"
printf "%-30s %-50s\n" "[:punct:]" "Visible punctuation characters"
printf "%-30s %-50s\n" "[:space:]" "Whitespace"
printf "%-30s %-50s\n" "[:upper:]" "Uppercase letters"
printf "%-30s %-50s\n" "[:word:]" "Word characters"
printf "%-30s %-50s\n" "[:xdigit:]" "Hexadecimal digits"
}

