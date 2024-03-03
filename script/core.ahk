#Requires AutoHotkey v2.0

SetTitleMatchMode 1
SetKeyDelay 0, 20
CoordMode "Mouse", "Client"

loadConfig(configPath) {
    configDelimiter := "="
    config := {}
    
    Loop Read, configPath {
        if (InStr(A_LoopReadLine, configDelimiter) > 0) {
            configParts := StrSplit(A_LoopReadLine, configDelimiter)
            configKey := configParts[1]
            configValue := configParts[2]
            config.%configKey% := configValue
        }
    }

    return config
}

getCharacterNames() {
    global config
    characters := []
    Loop (config.characters) {
        characters.Push(config.character%A_Index%)
    }
    return characters
}

getWindows() {
    windows := []
    characters := getCharacterNames()
    for (character in characters) {
        windowId := WinExist(character)
        if (windowId) {
            windows.Push({character: character, windowId: windowId})
        }
    }
    return windows
}

config := loadConfig("..\config\config.ini")
windows := getWindows()