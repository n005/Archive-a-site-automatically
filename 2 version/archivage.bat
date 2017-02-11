@echo off

lynx -listonly -dump "epcminecraft.fr.gd" > ntexte.txt

setlocal enabledelayedexpansion

for /F "tokens=*" %%A in (ntexte.txt) do (
	set line=%%A
	echo !line:~3! >> newfile.txt
)

setlocal enabledelayedexpansion
set Counter=1
for /f %%x in (newfile.txt) do (
  set "Line_!Counter!=%%x"
  set /a Counter+=1
)
set /a NumLines=Counter - 1

for /l %%x in (1,1,%NumLines%) do lynx -listonly -dump !Line_%%x! > texte_%%x.txt  & for /F "tokens=*" %%A in (texte_%%x.txt) do (set line=%%A & echo http://web.archive.org/save/!line:~3! >> newfile_%%x.txt) & type "newfile_%%x.txt"|repl " " "" >"2newfile_%%x.txt"


for /l %%n in (1,1,%NumLines%) do del texte_%%n.txt & del newfile_%%n.txt

rem for /l %%h in (1,1,%NumLines%) do wget -i 2newfile_%%h.txt -P file/

for /F "tokens=*" %%A in (ntexte.txt) do (
	set line=%%A
	echo http://web.archive.org/save/!line:~3! >> wgetfile.txt
)

type "wgetfile.txt"|repl " " "" >"wgetfile2.txt"

wget -i wgetfile2.txt -P file/

del wgetfile2.txt & del wgetfile.txt & del ntexte.txt

for /l %%k in (1,1,%NumLines%) do del 2newfile_%%k.txt

del newfile.txt

del file

pause

