# Function to seach in all directory and open the target in neovim
function nvimfzf {
	EXA_OPTIONS="--icons -la --color=always"
	BAT_OPTIONS="--number -f --force-colorization"

	NVIM_FZF_PREVIEW="if [[ -d {} ]]; then eza $EXA_OPTIONS {}; else bat $BAT_OPTIONS {}; fi" # what is displayed on the right
	#dest=$( $FZF_DEFAULT_COMMAND | fzf --scheme=path  --preview "$NVIM_FZF_PREVIEW" | tr -d '\n') # old command

	dest=$(fd --no-ignore --hidden --exclude .git | fzf --scheme=path  --preview "$NVIM_FZF_PREVIEW" | tr -d '\n')

	#echo "DEBUG : dest= '$dest' end"
	if [[ -d "$dest" ]]; then # if it's directory
		cd "$dest" && nvim .
	elif [[ -f "$dest" ]]; then # if it's a file
		nvim "$dest"
	else
		echo "Path unknown or inacessible"
	fi
}

bindkey -s ^f "nvimfzf\n" # binding to ctrl+f

