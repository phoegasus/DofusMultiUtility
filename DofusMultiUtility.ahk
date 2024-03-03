#Requires AutoHotkey v2.0
#SingleInstance
#Include "script\exit.ahk"

Run("script\overworld.ahk")
Run("script\fightAutoSwitcher.ahk")

HotIfWinActive "ahk_exe Dofus.exe"
F5::Reload