#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

!f1::  
    ;doesn't find wsl if windows has a different bit version than autohotkey
    Run %comspec% /k wsl ./youtubecut/main.sh %clipboard%
    Run bin\file2clip.exe youtubecut\output.mp4
return

!f3::
    Run bin\file2clip.exe youtubecut\output.mp4
return

!f2::
    reload
return
