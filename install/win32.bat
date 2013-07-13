@echo off
rem LaTeX package install script
rem Author: Xu Cheng

cd /d "%~dp0"
cd ..

if not defined TEXMFLOCAL (
    for /f "delims=" %%I in ('kpsewhich --var-value=TEXMFLOCAL') do @set TEXMFLOCAL=%%I
)

if /i "%1" == "install"      goto :install
if /i "%1" == "uninstall"    goto :uninstall
goto :help

:install
echo. Install hustbeamer.cls template into local.
mkdir "%TEXMFLOCAL%\tex\latex\hustbeamer\"
xcopy /q /y .\hustbeamer\hustbeamer.cls "%TEXMFLOCAL%\tex\latex\hustbeamer\" > nul
xcopy /q /y .\hustbeamer\hust-header.png "%TEXMFLOCAL%\tex\latex\hustbeamer\" > nul
mkdir "%TEXMFLOCAL%\doc\latex\hustbeamer\"
xcopy /q /y .\hustbeamer\hustbeamer.pdf "%TEXMFLOCAL%\doc\latex\hustbeamer\" > nul
mkdir "%TEXMFLOCAL%\doc\latex\hustbeamer\example\"
xcopy /q /y .\hustbeamer\hustbeamer-example.pdf "%TEXMFLOCAL%\doc\latex\hustbeamer\example\" > nul
xcopy /q /y .\hustbeamer\hustbeamer-example.tex "%TEXMFLOCAL%\doc\latex\hustbeamer\example\" > nul
goto :hash

:uninstall
echo. Uninstall hustbeamer.cls template.
rd /q /s "%TEXMFLOCAL%\tex\latex\hustbeamer\"
rd /q /s "%TEXMFLOCAL%\doc\latex\hustbeamer\"
goto :hash

:hash
echo. Refresh TeX hash database.
texhash
goto :exit

:help
echo Usage:
echo. %~nx0 install          - install hustbeamer.cls template into local.
echo. %~nx0 uninstall        - uninstall hustbeamer.cls template.
echo.
goto :exit

:exit