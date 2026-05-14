#!/bin/sh

alias i='sudo pacman -S --needed'           # Installing without reinstalling or updating metadata
alias u='sudo pacman -Syu ; flatpak update' # Update
alias rem='sudo pacman -Rns'                # Remove packages and unused dependencies
alias s='pacman -Ss'                        # Search
alias q='pacman -Qs'                        # Search installed
alias qe='pacman -Qe'                       # List explicitly installed packages
alias qm='pacman -Qm'                       # List AUR

alias orphans='pacman -Qdtq | sudo pacman -Rns -' # Remove unused dependencies

phelp() {
	printf '%s\n' "`i`  = Install without reinstall or update metadata"
	printf '%s\n' "`u`  = Update system"
	printf '%s\n' "`rem`  = Careful, removes packages and unused depeendencies"
	printf '%s\n' "`s`  = Search packages"
	printf '%s\n' "`q` = Search installed"
	printf '%s\n' "`qe` = List explicit"
	printf '%s\n' "`qm` = List AUR"
}
