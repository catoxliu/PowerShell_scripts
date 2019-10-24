$TopDir = $env:USERPROFILE
schtasks.exe /Change /TN "fetch spotlight image" /TR "powershell.exe $TopDir\PowerShell_scripts\save_spotlight.ps1"