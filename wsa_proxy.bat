@echo off
setlocal ENABLEDELAYEDEXPANSION
title Android Proxy Tool

:: Configuration
set DEVICE=127.0.0.1:58526
set PROXY=10808

:menu
cls
echo ==========================================
echo         Android Emulator Proxy Tool
echo ==========================================
echo.
echo    1. Set proxy to %PROXY%
echo    2. Clear proxy
echo    3. Exit
echo.
set /p choice=Enter your choice (1-3): 

if "%choice%"=="1" goto set_proxy
if "%choice%"=="2" goto clear_proxy
if "%choice%"=="3" goto exit
echo.
echo [ERROR] Invalid choice. Please try again.
pause >nul
goto menu

:set_proxy
echo.
echo [INFO] Connecting to device %DEVICE%...
adb connect %DEVICE%
if errorlevel 1 (
    echo [ERROR] Failed to connect to device.
    pause
    goto menu
)

echo [INFO] Setting HTTP proxy to %PROXY%...
adb shell "settings put global http_proxy `ip route list match 0 table all scope global | cut -F3`:%PROXY%"
echo [DONE] Proxy set to %PROXY%
pause
goto menu

:clear_proxy
echo.
echo [INFO] Connecting to device %DEVICE%...
adb connect %DEVICE%
if errorlevel 1 (
    echo [ERROR] Failed to connect to device.
    pause
    goto menu
)

echo [INFO] Clearing HTTP proxy...
adb shell "settings put global http_proxy :0"
echo [DONE] Proxy cleared.
pause
goto menu

:exit
echo.
timeout /t 1 >nul
exit
