Dim args, psPath, extraArgs
Set args = WScript.Arguments
If args.Count = 0 Then WScript.Quit 1

psPath = args(0)
extraArgs = ""
If args.Count > 1 Then extraArgs = " " & args(1)

Dim shell
Set shell = CreateObject("WScript.Shell")
shell.Run "powershell.exe -ExecutionPolicy Bypass" & extraArgs & " -File """ & psPath & """", 0, False
Set shell = Nothing