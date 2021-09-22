@echo off
set dir=%~dp0

tasklist /fo csv /nh /fi "IMAGENAME eq Code.exe" | find "Code.exe" > NUL

if NOT ERRORLEVEL 1 (

	rem メッセージ表示
	echo MsgBox "VSCode が起動中です。",vbInformation,"VSCodeInstaller" > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs

	rem ファイル削除
	del /Q %TEMP%\msgbox.vbs

) ELSE (
	"../Ruby/bin/ruby.exe" ./setting/vscodeInstaller.rb %dir:~0,-1%
	cd ./vscode

	start Code.exe ../../Src
	echo -----------------
	echo 再起動処理中
	echo -----------------
	waitfor dummy /t 10>nul 2>&1 & verify>nul
	taskkill /im Code.exe
	
	echo MsgBox "セットアップが完了しました。",vbInformation,"VSCodeInstaller" > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs
	del /Q %TEMP%\msgbox.vbs
)

exit
