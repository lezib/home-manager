# Function to seach in all directory and open it in neovim
function nvimfzf {
	#FZF_DEFAULT_COMMAND="fd --no-ignore --hidden --exclude .git"
	EXA_OPTIONS="--icons -la --color=always"
	BAT_OPTIONS="--number -f --force-colorization"

	NVIM_FZF_PREVIEW="if [[ -d {} ]]; then eza $EXA_OPTIONS {}; else bat $BAT_OPTIONS {}; fi"
	#dest=$( $FZF_DEFAULT_COMMAND | fzf --scheme=path  --preview "$NVIM_FZF_PREVIEW" | tr -d '\n')

	dest=$(fd --no-ignore --hidden --exclude .git | fzf --scheme=path  --preview "$NVIM_FZF_PREVIEW" | tr -d '\n')

	#echo "DEBUG : dest= '$dest' end"
	if [[ -d "$dest" ]]; then
		cd "$dest" && nvim .
	elif [[ -f "$dest" ]]; then
		nvim "$dest"
	else
		echo "Path unknown or inacessible"
	fi
}

bindkey -s ^f "nvimfzf\n"

