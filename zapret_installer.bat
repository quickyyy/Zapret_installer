@echo off
chcp 65001 >nul
cls
set "downloadUrl=https://github.com/quickyyy/Zapret_installer/releases/download/ZipFile/zapret.zip"
set "zipPath=%TEMP%\rbf.zip"
set "extractPath=C:\RBF_furry_lovers"              
set "targetFile=%extractPath%\preset_general.cmd"          
set "servicefile=%extractPath%\create_service_general.cmd"
set "shortcutName=%USERPROFILE%\Desktop\RKNsosat.lnk"
echo [#] Zapret_installer
echo [#] github - https://github.com/quickyyy/Zapret_installer

echo [*] Скачивание zapret из %downloadUrl%...
powershell -NoProfile -NoLogo -Command "Start-Process powershell -ArgumentList '-NoProfile -NoLogo -Command \"Invoke-WebRequest -Uri %downloadUrl% -OutFile %zipPath%\"' -WindowStyle Minimized -Wait"
if %errorlevel% neq 0 (
    echo [-] Ошибка при скачивании архива.
    pause
    exit /b 1
)
echo [+] Успешно.


echo [*] Извлечение в %extractPath%...
powershell -NoProfile -NoLogo -Command "Start-Process powershell -ArgumentList '-NoProfile -NoLogo -Command \"Expand-Archive -Path %zipPath% -DestinationPath %extractPath% -Force\"' -WindowStyle Minimized -Wait"
if %errorlevel% neq 0 (
    echo [-] Ошибка при извлечении архива.
    pause
    exit /b 1
)
echo [+] Успешно.


set /p userInput=[*] Создать службу? (Автоматический запуск при включении ПК) (Y/N)? 

if /i "%userInput%"=="Y" (
    echo [*] Выполнение файла...
    "%servicefile%"
    if %errorlevel% neq 0 (
        echo [-] Ошибка при выполнении файла.
        pause
        exit /b 1
    )
    echo [+] Успешно.
) else (
    echo [*] Создание ярлыка на рабочем столе...
    powershell -Command "$WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut('%shortcutName%'); $Shortcut.TargetPath = '%targetFile%'; $Shortcut.Save()"
    if %errorlevel% neq 0 (
        echo [-] Ошибка при создании ярлыка.
        pause
        exit /b 1
    )
    echo [+] Успешно.
)
cls
echo [#] Zapret_installer
echo [#] github - https://github.com/quickyyy/Zapret_installer
echo [+] Готово!
echo [#] Спасибо за использование Zapret_installer!
pause
