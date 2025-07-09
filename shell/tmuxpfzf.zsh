# Function to seach in all directory and open the target in neovim
function tmuxpfzf {
	BAT_OPTIONS="--number -f --force-colorization"

	NVIM_FZF_PREVIEW="bat $BAT_OPTIONS {};" # what is displayed on the right

	dest=$( ls ~/.tmuxp | grep ".yaml") # get list of sessions
	dest=${dest//.yaml/} # trim all extention
	dest=$(echo ${dest} | fzf ) # ask user

	# echo "DEBUG : dest= '$dest' end"
	if [[ -z "$dest" ]]; then
		return 1
	fi
	tmuxp load ${dest}
}

bindkey -s ^k "tmuxpfzf\n" # binding to ctrl+k

