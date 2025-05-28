# function to tp to a searched directory

function cdfzf {
	EXA_OPTIONS="--icons -la --color=always"

	CD_FZF_PREVIEW="eza $EXA_OPTIONS {};"

	dest=$(fd --no-ignore --type d --hidden --exclude .git | fzf --scheme=path --preview "$CD_FZF_PREVIEW" | tr -d '\n')

	if [[ ! -z "$dest" ]]; then
		cd "$dest"
	fi
}

bindkey -s ^g "cdfzf\n"

