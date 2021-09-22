@echo off
chcp 932
set dir=%~dp0

tasklist /fo csv /nh /fi "IMAGENAME eq Code.exe" | find "Code.exe" > NUL

if NOT ERRORLEVEL 1 (

	rem ���b�Z�[�W�\��
	echo MsgBox "VSCode ���N�����ł��B",vbInformation,"VSCodeInstaller" > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs

	rem �t�@�C���폜
	del /Q %TEMP%\msgbox.vbs

) ELSE (

	"../Ruby/bin/ruby.exe" ./setting/vscodeInstaller.rb %dir:~0,-1%
	cd ./vscode

	start Code.exe ../../Src
	echo -----------------
	echo �ċN��������
	echo -----------------
	waitfor dummy /t 10>nul 2>&1 & verify>nul
	taskkill /im Code.exe

	echo MsgBox "�Z�b�g�A�b�v���������܂����B",vbInformation,"VSCodeInstaller" > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs
	del /Q %TEMP%\msgbox.vbs

)

exit