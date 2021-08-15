@echo off

SetLocal EnableDelayedExpansion

REM Don't try to change anything below


:SIGNATURE
echo ################################################
echo ###### Mocks Keyboard and Mouse randomly #######
echo ################################################
echo ################################################
echo ########## Created by Alauddin Ansari ##########
echo ############# Windows Mouse Control ############
echo ############# alauddinx27@gmail.com ############
echo ################ Mar, 2020 #####################
echo ################################################
echo.
echo.

color B
echo Taking control...
echo.

set SendKeys=CScript //nologo //E:JScript keyboard.vbs
set KeyList=ENTER A B C D E " " F G H I J " " K L M N O " " P Q R S T U V W X Y Z ENTER 1 2 3 4 5 6 7 8 9 0 ENTER BACKSPACE

echo Starting...

REM keyboard settings
set i=-1
for %%f in (%KeyList%) do (
	set /a i=!i!+1
	set keys[!i!]=%%f
)
set maxKeys=!i!


REM Variables defination
Set /a minX=50
Set /a maxX=1200

Set /a minY=100
Set /a maxY=800

Set /a minT=2
Set /a maxT=10

Set /a cnt=0

set /a maxCnt=0
for %%a in (%CommList%) do (
   set com[!maxCnt!]=%%a
   set /A maxCnt+=1
)


:CheckScript
If Exist mouse.cmd Goto :CheckExe

echo mouse.cmd file not exists.
Goto :End


:CheckExe
If Not Exist mouse.exe (
	echo generating mouse.exe
	call mouse.cmd position >nul
	
	If Exist mouse.exe (
		echo generated successfully
		GOTO :Start
	)
	
	echo error in generating mouse.exe
	echo check mouse.cmd

	GOTO :End
)

:Start
echo.

:Action
echo.

Set /a cnt=%cnt% + 1
If %cnt% GTR %maxCnt% Set /a cnt=1
Set /a curComm=%cnt% - 1


If !com[%curComm%]!==Key (
	Set t=1
) else (
	Set /a "t=!RANDOM! * (!maxT! - !minT! + 1) / 32768 + !minT!"
)

echo waiting for %t% seconds...

timeout /T %t% >nul


echo calling !com[%curComm%]!

Goto :Com_!com[%curComm%]!

Goto :End


:Com_Key

set /a keyIndex=!random! %%!maxKeys! + 1

echo pressing: !keys[%keyIndex%]!

%SendKeys% {!keys[%keyIndex%]!}

GOTO :Action


:Com_Move
Set /a x=%RANDOM% * (%maxX% - %minX% + 1) / 32768 + %minX%
Set /a y=%RANDOM% * (%maxY% - %minY% + 1) / 32768 + %minY%

mouse.exe moveTo %x%x%y%
echo cursor moved to %x%x%y%

GOTO :Action

:Com_LeftClick
mouse.exe click
echo mouse left clicked

GOTO :Action

:Com_RightClick
mouse.exe rightClick
echo mouse right clicked

GOTO :Action


:Com_ScrollUp
Set /a sy=%RANDOM% * 200 / 32768 + 10

mouse.exe scrollUp %sy%
echo scrolled up by %sy%

GOTO :Action


:Com_ScrollDown
Set /a sy=%RANDOM% * 200 / 32768 + 10

mouse.exe scrollDown %sy%
echo scrolled down by %sy%

GOTO :Action



:End

echo Over to you!

timeout /T 5 >nul

exit
