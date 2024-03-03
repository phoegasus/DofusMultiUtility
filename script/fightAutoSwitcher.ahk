#Requires AutoHotkey v2.0
#SingleInstance
#Include "exit.ahk"
#Include "core.ahk"

characterImageFound(window) {
    global config
    ImageSearch(&foundX, &foundY, config.fightCharacterNameMinX, config.fightCharacterNameMinY, config.fightCharacterNameMaxX, config.fightCharacterNameMaxY, "*" config.imageVariance " ..\images\" window.character ".png")
    return foundX && foundY
}

run() {
    global windows, config
    Loop {
        for (window in windows) {
            if(characterImageFound(window)) {
                WinActivate(window.windowId)
                break
            }
        }
        Sleep(config.scanDelay)
    }
}

run()