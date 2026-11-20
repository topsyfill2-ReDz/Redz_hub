@echo off
chcp 65001 >nul
title ReDZ_HuB [Beta_0.3]
mode con: cols=82 lines=27

:: Папка и файл для сохранения статистики времени
set "DATA_DIR=%APPDATA%\ReDZ_HuB"
set "STATS_FILE=%DATA_DIR%\stats.ini"
if not exist "%DATA_DIR%" mkdir "%DATA_DIR%"

:: Инициализация нулевых значений
set "T_OBS=0"
set "T_DRG=0"
set "T_GMOD=0"
set "T_CS2=0"
set "T_TML=0"
set "T_FORTS=0"
set "T_TER=0"
set "T_SCPSL=0"

:: Загружаем сохранённое время (в секундах), если файл уже есть
if exist "%STATS_FILE%" (
    for /f "usebackq tokens=1,2 delims==" %%A in ("%STATS_FILE%") do set "%%A=%%B"
)

:: Получаем символ ESC для оттенков красного
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "RED_B=%ESC%[91m"
set "RED_D=%ESC%[31m"
set "WHT=%ESC%[97m"
set "GRY=%ESC%[90m"
set "RST=%ESC%[0m"

:menu
cls
echo %RED_D%================================================================================%RST%
echo %RED_B%  ____       ____  _____        _   _       ____  %RST%
echo %RED_B% ^|  _ \ ___ ^|  _ \^|__  /       ^| ^| ^| ^|_   _^| __ ) %RST%
echo %RED_B% ^| ^|_) / _ \^| ^| ^| ^| / /   _____^| ^|_^| ^| ^| ^| ^|  _ \ %RST%
echo %RED_B% ^|  _ ^<  __/^| ^|_^| ^|/ /_  ^|_____^|  _  ^| ^|_^| ^| ^|_) ^|%RST%
echo %RED_B% ^|_^| \_\___^|^|____//____^|       ^|_^| ^|_^|\__,_^|____/ %RST%
echo.
echo %RED_D%================================================================================%RST%
echo.
echo  %RED_B%1)%RST%   %WHT%Запустить OBS Studio%RST%            %RED_D%^|%RST%  %RED_B%USER:%RST% %WHT%%USERNAME%%RST%
echo  %RED_B%2)%RST%   %WHT%Запустить Deep Rock Galactic%RST%    %RED_D%^|%RST%  %RED_B%DATE:%RST% %WHT%%DATE%%RST%
echo  %RED_B%3)%RST%   %WHT%Запуск Garry's Mod%RST%              %RED_D%^|%RST%  %RED_B%SUB :%RST% %WHT%sub-version_beta_v0.0.3%RST%
echo  %RED_B%4)%RST%   %WHT%Запуск Counter-Strike 2%RST%         %RED_D%^|%RST%  %RED_B%DEV :%RST% %RED_B%ReD_EviL%RST%
echo  %RED_B%5)%RST%   %WHT%Запуск tModLoader%RST%               %RED_D%^|%RST%  %RED_B%VER :%RST% %RED_B%Beta_0.3%RST%
echo  %RED_B%6)%RST%   %WHT%Запуск Forts%RST%                    %RED_D%^|%RST%
echo  %RED_B%7)%RST%   %WHT%Запуск Terraria%RST%                 %RED_D%^|%RST%
echo  %RED_B%8)%RST%   %WHT%Запуск Noclipped%RST%                %RED_D%^|%RST%
echo  %RED_B%9)%RST%   %WHT%Запуск SCP: Secret Laboratory%RST%   %RED_D%^|%RST%
echo  %RED_D%10)%RST%  %GRY%Coming soon...%RST%                  %RED_D%^|%RST%
echo  %RED_B%101)%RST% %WHT%Время%RST%                           %RED_D%^|%RST%
echo  %RED_D%0)%RST%   %GRY%Выход%RST%                           %RED_D%^|%RST%
echo.
echo %RED_D%================================================================================%RST%
set /p choice="%RED_B%ReDZ_HuB%RST% %RED_D%>%RST% Выберите пункт (0-10 / 101): "

if "%choice%"=="1" call :track_game "OBS Studio" "1905180" "obs64.exe" T_OBS
if "%choice%"=="2" call :track_game "Deep Rock Galactic" "548430" "FSD-Win64-Shipping.exe" T_DRG
if "%choice%"=="3" call :track_game "Garry's Mod" "4000" "gmod.exe" T_GMOD
if "%choice%"=="4" call :track_game "Counter-Strike 2" "730" "cs2.exe" T_CS2
if "%choice%"=="5" call :track_game "tModLoader" "1281930" "dotnet.exe" T_TML
if "%choice%"=="6" call :track_game "Forts" "410900" "Forts.exe" T_FORTS
if "%choice%"=="7" call :track_game "Terraria" "105600" "Terraria.exe" T_TER
if "%choice%"=="8" goto start_noclipped
if "%choice%"=="9" call :track_game "SCP: Secret Laboratory" "700330" "SCPSL.exe" T_SCPSL
if "%choice%"=="10" goto coming_soon
if "%choice%"=="101" goto show_stats
if "%choice%"=="0" exit
goto menu

:: ================= ПРЯМОЙ ЗАПУСК NOCLIPPED (БЕЗ УЧЁТА ВРЕМЕНИ) =================
:start_noclipped
cls
echo %RED_B%[INFO]%RST% %WHT%Запуск Noclipped через Steam...%RST%
start "" "steam://rungameid/2093380"
timeout /t 3 >nul
goto menu

:: ================= ОКНО СТАТИСТИКИ ВРЕМЕНИ (101) =================
:show_stats
call :format_full %T_OBS% F_OBS
call :format_full %T_DRG% F_DRG
call :format_full %T_GMOD% F_GMOD
call :format_full %T_CS2% F_CS2
call :format_full %T_TML% F_TML
call :format_full %T_FORTS% F_FORTS
call :format_full %T_TER% F_TER
call :format_full %T_SCPSL% F_SCPSL

set /a T_ALL=%T_OBS% + %T_DRG% + %T_GMOD% + %T_CS2% + %T_TML% + %T_FORTS% + %T_TER% + %T_SCPSL%
call :format_full %T_ALL% F_ALL

cls
echo %RED_D%================================================================================%RST%
echo %RED_B%                     СТАТИСТИКА ВРЕМЕНИ В ИГРАХ (ReDZ_HuB)                      %RST%
echo %RED_D%================================================================================%RST%
echo.
echo   %WHT%OBS Studio:%RST%              %RED_B%%F_OBS%%RST%
echo   %WHT%Deep Rock Galactic:%RST%      %RED_B%%F_DRG%%RST%
echo   %WHT%Garry's Mod:%RST%             %RED_B%%F_GMOD%%RST%
echo   %WHT%Counter-Strike 2:%RST%        %RED_B%%F_CS2%%RST%
echo   %WHT%tModLoader:%RST%              %RED_B%%F_TML%%RST%
echo   %WHT%Forts:%RST%                   %RED_B%%F_FORTS%%RST%
echo   %WHT%Terraria:%RST%                %RED_B%%F_TER%%RST%
echo   %WHT%SCP: Secret Laboratory:%RST%  %RED_B%%F_SCPSL%%RST%
echo.
echo %RED_D%--------------------------------------------------------------------------------%RST%
echo   %RED_B%ОБЩЕЕ ВРЕМЯ:%RST%             %WHT%%F_ALL%%RST%
echo %RED_D%================================================================================%RST%
echo.
set /p back="%GRY%Нажмите Enter, чтобы вернуться в меню...%RST%"
goto menu

:: ================= ФУНКЦИЯ ОТСЛЕЖИВАНИЯ ВРЕМЕНИ =================
:track_game
set "G_NAME=%~1"
set "APP_ID=%~2"
set "PROC_NAME=%~3"
set "VAR_NAME=%~4"

cls
echo %RED_B%[LAUNCH]%RST% %WHT%Запуск %G_NAME% через Steam...%RST%
start "" "steam://rungameid/%APP_ID%"
echo %GRY%Ожидание запуска процесса (%PROC_NAME%)... (Нажмите Ctrl+C для отмены)%RST%

set /a WAIT_COUNT=0
:wait_start
timeout /t 2 >nul
tasklist /FI "IMAGENAME eq %PROC_NAME%*" 2>NUL | find /I "%PROC_NAME%" >NUL
if "%ERRORLEVEL%"=="0" goto game_running
set /a WAIT_COUNT+=1
if %WAIT_COUNT% LSS 30 goto wait_start

echo %RED_B%[WARN]%RST% %WHT%Не удалось поймать процесс игры. Возврат в меню...%RST%
timeout /t 3 >nul
goto :eof

:game_running
for /f %%i in ('powershell -NoProfile -Command "[int][double]::Parse((Get-Date -UFormat %%s))"') do set "START_SEC=%%i"
cls
echo %RED_B%[TRACKING]%RST% %WHT%Идёт учёт времени в игре: %RED_B%%G_NAME%%RST%
echo %GRY%Не закрывайте это окно, пока играете — статистика сохранится после выхода.%RST%

:wait_exit
timeout /t 5 >nul
tasklist /FI "IMAGENAME eq %PROC_NAME%*" 2>NUL | find /I "%PROC_NAME%" >NUL
if "%ERRORLEVEL%"=="0" goto wait_exit

for /f %%i in ('powershell -NoProfile -Command "[int][double]::Parse((Get-Date -UFormat %%s))"') do set "END_SEC=%%i"
set /a SESSION_SEC=%END_SEC% - %START_SEC%
call set /a "%VAR_NAME%=%%%VAR_NAME%%% + %SESSION_SEC%"

(
    echo T_OBS=%T_OBS%
    echo T_DRG=%T_DRG%
    echo T_GMOD=%T_GMOD%
    echo T_CS2=%T_CS2%
    echo T_TML=%T_TML%
    echo T_FORTS=%T_FORTS%
    echo T_TER=%T_TER%
    echo T_SCPSL=%T_SCPSL%
) > "%STATS_FILE%"

echo.
echo %RED_B%[SAVED]%RST% %WHT%Сессия завершена (+%SESSION_SEC% сек). Статистика обновлена!%RST%
timeout /t 3 >nul
goto :eof

:: ================= ФОРМАТИРОВАНИЕ ВРЕМЕНИ (ЧАСЫ, МИНУТЫ, СЕКУНДЫ) =================
:format_full
set /a TOT_S=%~1
set /a HRS=TOT_S / 3600
set /a MINS=(TOT_S %% 3600) / 60
set /a SECS=TOT_S %% 60
if %HRS% LSS 10 set "HRS=0%HRS%"
if %MINS% LSS 10 set "MINS=0%MINS%"
if %SECS% LSS 10 set "SECS=0%SECS%"
set "%~2=%HRS% ч. %MINS% мин. %SECS% сек."
goto :eof

:coming_soon
cls
echo %RED_B%[INFO]%RST% %WHT%Этот раздел находится в разработке (Coming soon)...%RST%
timeout /t 2 >nul
goto menu
