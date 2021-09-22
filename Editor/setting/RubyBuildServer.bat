@echo off
tasklist /fo csv /nh /fi "IMAGENAME eq AsahikawaProcon-Server.exe" | find "AsahikawaProcon-Server.exe" > NUL

echo %~dp1
if NOT ERRORLEVEL 1 (
	echo [AsahikawaProcon-Server.exe] is already running
	cd ../AsahikawaProcon-Server/logs/

	setlocal enabledelayedexpansion
	for /f %%i in ('dir *.txt /b /od') do set x=%%~fi

	for /f "delims=" %%i in (!x!) do (set /a LINE_NUMBER+=1)
	cd ../

	if not !LINE_NUMBER!==1 (
		start AsahikawaProcon-Server.exe
	)

	cd ../Ruby/bin/
	
	start cmd /k  ruby.exe -I  %~dp1 %1
	endlocal
) ELSE (
	echo Start [AsahikawaProcon-Server.exe]
	cd ../AsahikawaProcon-Server/
	start AsahikawaProcon-Server.exe
	cd ../Ruby/bin
	start cmd /k  ruby.exe -I  %~dp1 %1
)