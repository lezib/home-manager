# function to tp to a searched directory

function cdfzf {
	export FZF_DEFAULT_COMMAND='fdfind --no-ignore --type d --hidden --exclude .git'
	DIRECTORY_PRINT=$(echo -e "[DIRECTORY]\n")
	EXA_OPTIONS="--icons -la --color=always"
	BAT_OPTIONS="--number -f --force-colorization"

	CD_FZF_PREVIEW="if [[ -d {} ]]; then echo -e \"[DIRECTORY]\n\"; exa $EXA_OPTIONS {}; else batcat $BAT_OPTIONS {}; fi"

	dest_file=$(fzf --scheme=path --preview "$CD_FZF_PREVIEW")

	if [[ ! -z "$dest_file" ]]; then
		cd "$dest_file"
	fi
}

bindkey -s ^g "cdfzf\n"

