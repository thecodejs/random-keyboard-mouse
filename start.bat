@echo off

REM Add commands in Sequence with space as delim

REM Available commands: Key Move LeftClick RightClick ScrollUp ScrollDown

REM Ex. Set "CommList=Move RightClick LeftClick ScrollUp ScrollDown"

Set "CommList=Move LeftClick Key Key Key Key Key Key Key Key Key Key Move LeftClick Key Key Key Key Key Key Key Key"

start cmd.exe /k "cd .\scripts & call script.cmd"
