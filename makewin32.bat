@echo off
rem simulate Makefile for Windows
rem Author: Xu Cheng

cd /d "%~dp0"

if /i "%1" == "unpack"       goto :unpack
if /i "%1" == "example"      goto :example
if /i "%1" == "doc"          goto :doc
if /i "%1" == "clean"        goto :clean
if /i "%1" == "all"          goto :all
if /i "%1" == "install"      goto :install
if /i "%1" == "uninstall"    goto :uninstall
goto :help

:help
echo Usage:
echo. makewin32 unpack           - unpack package
echo. makewin32 example          - build example
echo. makewin32 doc              - build document
echo. makewin32 all              - build example and document
echo. makewin32 clean            - delete temporary file
echo. makewin32 install          - install into local
echo. makewin32 uninstall        - uninstall
echo.
echo Even this file behaves much like Makefile, 
echo I still recommend you install Make into your Windows.
echo You can download it from http://gnuwin32.sourceforge.net/packages/make.htm
echo.
goto :exit

:all
call :unpack
call :example
call :doc
goto :exit

:unpack
pushd hustbeamer
lualatex hustbeamer.ins
popd
goto :exit

example:
call :unpack
pushd hustbeamer
lualatex -shell-escape -8bit hustbeamer-example
bibtex hustbeamer-example
lualatex -shell-escape -8bit hustbeamer-example
lualatex -shell-escape -8bit hustbeamer-example
popd
goto :exit

:doc
pushd hustbeamer
lualatex -shell-escape -8bit hustbeamer.dtx
makeindex -q -s l3doc.ist hustbeamer
makeindex -s l3doc.ist  -o hustbeamer.ind hustbeamer.idx
lualatex -shell-escape -8bit hustbeamer.dtx
lualatex -shell-escape -8bit hustbeamer.dtx
popd
goto :exit

:install
call :unpack
if not exist .\hustbeamer\hustbeamer-example.pdf call :example
if not exist .\hustbeamer\hustbeamer.pdf call :doc
call .\install\win32.bat install
goto :exit

:uninstall
call .\install\win32.bat uninstall
goto :exit

:clean
pushd hustbeamer
del /f /q *.acn *.acr *.alg *.aux *.bbl *.blg *.dvi *.fdb_latexmk *.glg *.glo *.gls *.idx *.ilg *.ind *.ist *.lof *.log *.lot *.maf *.mtc *.mtc0 *.nav *.nlo *.out *.pdfsync *.pyg *.snm *.synctex.gz *.thm *.toc *.vrb *.xdy *.tdo *.hd
popd
goto :exit

:exit