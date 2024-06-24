# Disable .zsh_sessions
export SHELL_SESSIONS_DISABLE=1

# PROMPT
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
export PROMPT=$'%B%F{green}%1~${vcs_info_msg_0_}$(_git_info) \ue349  %b%f'
zstyle ':vcs_info:git:*' formats $'%f on %F{green}\ue0a0 %b'

# FUNCTIONS
# Displaying current git status
function _git_symbols() {

	local ahead='↑'
	local behind='↓'
	local diverged='↕'
	local up_to_date=''
	local staged='+'
	local untracked='?'
	local modified='!'
	local moved='>'
	local deleted='x'
	local stashed='$'
	local output_symbols=''

	local git_status
	local git_status_v
	local ahead_count behind_count
	
	git_status_v="$(git status --porcelain=v2 --branch --show-stash 2>/dev/null)"

	if echo $git_status_v | grep -q "^# branch.ab " ; then

		read -d "\n" -r ahead_count behind_count <<< $(echo "$git_status_v" | grep "^# branch.ab" | grep -o -E '[+-][0-9]+' | sed 's/[-+]//')
		[[ $ahead_count != 0 ]] && output_symbols+="$ahead"
		[[ $behind_count != 0 ]] && output_symbols+="$behind"
		output_symbols="${output_symbols//$ahead$behind/$diverged}"
		[[ $ahead_count == 0 && $behind_count == 0 ]] && output_symbols+="$up_to_date"
	fi

	echo $git_status_v | grep -q "^# stash " && output_symbols+="$stashed"

	[[ $(git diff --name-only --cached) ]] && output_symbols+="$staged"

	symbols="$(git status --porcelain=v1 | cut -c1-2 | sed 's/ //g')"

	while IFS= read -r symbol; do
		case $symbol in
			??) output_symbols+="$untracked";;
			M) output_symbols+="$modified";;
			R) output_symbols+="$moved";;
			D) output_symbols+="$deleted";;
		esac
	done <<< "$symbols"

	output_symbols="$(echo -n "$output_symbols" | tr -s "$untracked$modified$moved$deleted")"

	[[ -n $output_symbols ]] && echo -n " $output_symbols"
}

function _git_info() {

	local git_info=''

	if $(git rev-parse --is-inside-work-tree 2> /dev/null) ; then
		git_info+="$(_git_symbols)"
		echo "$git_info"
	fi
}

# ALIASES
alias ls="eza -hA --group-directories-first"
alias ll="ls -l"
alias bare="git --git-dir=$HOME/Developer/.dotfiles/ --work-tree=$HOME"

# PLUGINS
# Setup zsh-autocomplete
source "$(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
bindkey -M menuselect '\r' .accept-line
zstyle ':autocomplete:*' min-input 2

# Enable syntax highlighting
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
