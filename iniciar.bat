@echo off
title Espejo animal - servidor local
cd /d "%~dp0"
set PORT=8080
netstat -ano | findstr ":%PORT%" | findstr "LISTENING" >nul
if not errorlevel 1 goto OPEN
where python >nul 2>nul
if %errorlevel%==0 goto PY
where py >nul 2>nul
if %errorlevel%==0 goto PY2
goto NPM
:PY
start "espejo-animal-servidor" /min python -m http.server %PORT%
goto OK
:PY2
start "espejo-animal-servidor" /min py -m http.server %PORT%
goto OK
:NPM
start "espejo-animal-servidor" /min cmd /c "npx --yes serve -l %PORT% ."
:OK
ping -n 3 127.0.0.1 >nul
:OPEN
start "" http://localhost:%PORT%/espejo-animal.html
echo Listo: http://localhost:%PORT%/espejo-animal.html
echo (la pestana del servidor debe seguir abierta mientras presentas)
