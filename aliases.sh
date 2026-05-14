#!/bin/sh

alias i='sudo pacman -S --needed'           # Installing without reinstalling or updating metadata
alias u='sudo pacman -Syu ; flatpak update' # Update
alias s='pacman -Ss'                        # Search
alias q='pacman -Qs'                        # Search installed
alias qe='pacman -Qe'                       # List explicitly installed packages
alias qm='pacman -Qm'                       # List AUR

# Safe remove functions with confirmation
confirm() {
    # $1 = prompt message (optional)
    local prompt="${1:-Are you sure?}"
    
    read -p "${prompt} [y/N] " -n 1 -r
    echo    # new line
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        return 0    # success (yes)
    else
        return 1    # failure (no)
    fi
}

rem() {
    if confirm "Remove package(s) and unused dependencies?"; then 
        sudo pacman -Rns "$@"
    fi
}

orphans() {
    if confirm "Remove unused orphan dependencies?"; then 
        pacman -Qdtq | sudo pacman -Rns -
    fi
}

phelp() {
	printf '%s\n' "`i`  = Install without reinstall or update metadata"
	printf '%s\n' "`u`  = Update system"
	printf '%s\n' "`rem`  = Careful, removes packages and unused dependencies"
	printf '%s\n' "`s`  = Search packages"
	printf '%s\n' "`q` = Search installed"
	printf '%s\n' "`qe` = List explicit"
	printf '%s\n' "`qm` = List AUR"
	printf '%s\n' "`orphans` = Remove unused orphan dependencies (with confirmation)"
}
