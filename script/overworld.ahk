#Requires AutoHotkey v2.0
#SingleInstance
#Include "exit.ahk"
#Include "core.ahk"

ahkId(id) {
    return "ahk_id " id
}

coords(x, y) {
    return "x" . x . " y" . y
}

clickAll(_) {
    global windows, config
    MouseGetPos(&mouseX, &mouseY)
    for (window in windows) {
        ControlClick(coords(mouseX, mouseY), ahkId(window.windowId), , , , "NA")
        randomSleep(config.clickAllMinDelay, config.clickAllMaxDelay)
    }
}

group(_) {
    global windows, config
    for (window in windows) {
        if(A_Index == 1) {
            mainCharacterWindow := window.windowId
            ControlClick(coords(config.chatX, config.chatY), ahkId(mainCharacterWindow), , , , "NA")
        } else {
            A_Clipboard := "/invite " . window.character
            ControlSend("^v", , mainCharacterWindow)
            Sleep(config.groupPasteEnterDelay)
            ControlSend("{Enter}", , mainCharacterWindow)
            randomSleep(config.groupMinDelay, config.groupMaxDelay)
        }
    }
    Sleep(config.acceptGroupDelay)
    for (window in windows) {
        if(A_Index > 1) {
            ControlClick(coords(config.joinGroupX, config.joinGroupY), ahkId(window.windowId), , , , "NA")
            randomSleep(config.groupMinDelay, config.groupMaxDelay)
        }
    }
}

joinFight(_) {
    global windows, config
    for (window in windows) {
        ControlClick(coords(config.joinFightX, config.joinFightY), ahkId(window.windowId), , , , "NA")
        randomSleep(config.joinFightMinDelay, config.joinFightMaxDelay)
    }
}

randomSleep(minDuration, maxDuration) {
    Sleep(Random(minDuration, maxDuration))
}

nextCharacter(_) {
    for (window in windows) {
        if(WinActive(window.windowId)) {
            if(A_Index == windows.Length) {
                WinActivate(windows[1].windowId)
            } else {
                WinActivate(windows[A_Index + 1].windowId)
            }
            break
        }
    }
}

prevCharacter(_) {
    for (window in windows) {
        if(WinActive(window.windowId)) {
            if(A_Index == 1) {
                WinActivate(windows[windows.Length].windowId)
            } else {
                WinActivate(windows[A_Index - 1].windowId)
            }
            break
        }
    }
}

HotIfWinActive "ahk_exe Dofus.exe"
Hotkey config.clickAll, clickAll
Hotkey config.group, group
Hotkey config.joinFight, joinFight
Hotkey config.nextCharacter, nextCharacter
Hotkey config.prevCharacter, prevCharacter