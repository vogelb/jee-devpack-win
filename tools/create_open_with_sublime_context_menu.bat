@echo off

call %~dp0..\conf\devpack.bat
SET st2Path=%DEVPACK_BASE%\bin\sublime.bat

rem add it for all file types
reg add "HKEY_CLASSES_ROOT\*\shell\Open with Sublime Text 2"         /t REG_SZ /v "" /d "Open with Sublime Text 2"   /f
reg add "HKEY_CLASSES_ROOT\*\shell\Open with Sublime Text 2"         /t REG_EXPAND_SZ /v "Icon" /d "%st2Path%,0" /f
reg add "HKEY_CLASSES_ROOT\*\shell\Open with Sublime Text 2\command" /t REG_SZ /v "" /d "%st2Path% \"%%1\"" /f

rem add it for folders
reg add "HKEY_CLASSES_ROOT\Folder\shell\Open with Sublime Text 2"         /t REG_SZ /v "" /d "Open with Sublime Text 2"   /f
reg add "HKEY_CLASSES_ROOT\Folder\shell\Open with Sublime Text 2"         /t REG_EXPAND_SZ /v "Icon" /d "%st2Path%,0" /f
reg add "HKEY_CLASSES_ROOT\Folder\shell\Open with Sublime Text 2\command" /t REG_SZ /v "" /d "%st2Path% \"%%1\"" /f
pause
