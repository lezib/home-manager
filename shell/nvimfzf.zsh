# Function to seach in all directory and open it in neovim
function nvimfzf {
	export FZF_DEFAULT_COMMAND='fdfind --no-ignore --hidden --exclude .git'
	DIRECTORY_PRINT=$(echo -e "[DIRECTORY]\n")
	EXA_OPTIONS="--icons -la --color=always"
	BAT_OPTIONS="--number -f --force-colorization"

	NVIM_FZF_PREVIEW="if [[ -d {} ]]; then echo -e \"[DIRECTORY]\n\"; exa $EXA_OPTIONS {}; else batcat $BAT_OPTIONS {}; fi"
	dest_find=$(fzf --scheme=path  --preview "$NVIM_FZF_PREVIEW")

	if [[ ! -z "$dest_file" ]]; then
		cd "$dest_file" && nvim .
	fi
}

bindkey -s ^f "nvimfzf\n"

