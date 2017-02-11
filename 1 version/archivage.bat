@echo off

lynx -listonly -dump "epcminecraft.fr.gd" > texte.txt

setlocal enabledelayedexpansion

for /F "tokens=*" %%A in (texte.txt) do (
	set line=%%A
	echo http://web.archive.org/save/!line:~3! >> newfile.txt
)

type "newfile.txt"|repl " " "" >"newfile2.txt"

del newfile.txt
del texte.txt

wget -i newfile2.txt -P file/

del file
del newfile2.txt

pause
