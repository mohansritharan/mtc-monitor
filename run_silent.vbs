Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
strPath = fso.GetParentFolderName(WScript.ScriptFullName)
WshShell.CurrentDirectory = strPath

' Run Python without popping up any black console window (0 = hidden)
WshShell.Run "cmd /c py -3.12 monitor.py", 0, False
