#!/usr/bin/env bash
# LaTeX package install script
# Author: Xu Cheng

command_exists () {
    type "$1" &> /dev/null ;
}

if ! command_exists realpath ; then
    if command_exists grealpath ; then
        realpath() {
            grealpath "$1"
        }
    else
        realpath() {
            [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
        }
    fi
fi

SCRIPT_PATH=$(realpath $(cd $(dirname $0);pwd))
cd $SCRIPT_PATH/..

TEXMFLOCAL=`kpsewhich --var-value=TEXMFLOCAL | awk -v RS="" -v FS="[\r\n]" '{print $1}' `

install(){
echo "Install hustbeamer.cls template into local."
mkdir -p "${TEXMFLOCAL}/tex/latex/hustbeamer/"
cp -f ./hustbeamer/hustbeamer.cls "${TEXMFLOCAL}/tex/latex/hustbeamer/"
cp -f ./hustbeamer/hust-header.png "${TEXMFLOCAL}/tex/latex/hustbeamer/"
mkdir -p "${TEXMFLOCAL}/doc/latex/hustbeamer/"
cp -f ./hustbeamer/hustbeamer.pdf "${TEXMFLOCAL}/doc/latex/hustbeamer/"
mkdir -p "${TEXMFLOCAL}/doc/latex/hustbeamer/example/"
cp -f ./hustbeamer/hustbeamer-example.pdf "${TEXMFLOCAL}/doc/latex/hustbeamer/example/"
cp -f ./hustbeamer/hustbeamer-example.tex "${TEXMFLOCAL}/doc/latex/hustbeamer/example/"
hash
}

uninstall(){
echo "Uninstall hustbeamer.cls template."
rm -rf "${TEXMFLOCAL}/tex/latex/hustbeamer/"
rm -rf "${TEXMFLOCAL}/doc/latex/hustbeamer/"
hash
}

hash(){
echo "Refresh TeX hash database."
texhash
}

help(){
echo "Usage:"
echo " $(basename $0) install          - install hustbeamer.cls template into local."
echo " $(basename $0) uninstall        - uninstall hustbeamer.cls template."
echo ""
}

if [[ $1 = "install" ]]; then
    install
elif [[ $1 = "uninstall" ]]; then
    uninstall
else
    help
fi
