@echo off
setlocal enabledelayedexpansion

echo ===================================================
echo DirTree Command - Installer
echo ===================================================
echo.

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please right-click and select "Run as administrator".
    echo.
    pause
    exit /b
)

:: Create the Scripts directory in user profile
set "SCRIPT_DIR=%USERPROFILE%\Scripts"
if not exist "%SCRIPT_DIR%" (
    echo Creating Scripts directory...
    mkdir "%SCRIPT_DIR%"
)

:: Create the dirtree.bat file
set "SCRIPT_PATH=%SCRIPT_DIR%\dirtree.bat"
echo Creating dirtree command...

(
echo @echo off
echo setlocal enabledelayedexpansion
echo.
echo :: Set variables
echo set "OUTPUT_FILE=%%CD%%\directory_structure.txt"
echo set "START_DIR=%%CD%%"
echo.
echo :: Allow user to specify a different directory
echo if not "%%~1"=="" ^(
echo     set "START_DIR=%%~1"
echo     set "OUTPUT_FILE=%%START_DIR%%\directory_structure.txt"
echo ^)
echo.
echo :: Ensure directory path ends with a backslash
echo if not "%%START_DIR:~-1%%"=="\" set "START_DIR=%%START_DIR%%\"
echo.
echo :: Allow user to specify output file
echo if not "%%~2"=="" ^(
echo     set "OUTPUT_FILE=%%~2"
echo ^)
echo.
echo echo Directory Structure Capture Tool
echo echo ==============================
echo echo.
echo echo Capturing directory structure from: %%START_DIR%%
echo echo Output will be saved to: %%OUTPUT_FILE%%
echo echo.
echo.
echo :: Create the output file with a header
echo echo Directory Structure captured on %%date%% at %%time%% ^> "%%OUTPUT_FILE%%"
echo echo Starting directory: %%START_DIR%% ^>^> "%%OUTPUT_FILE%%"
echo echo ======================================================== ^>^> "%%OUTPUT_FILE%%"
echo echo. ^>^> "%%OUTPUT_FILE%%"
echo.
echo :: Use the tree command to capture the directory structure
echo echo Generating directory tree...
echo tree "%%START_DIR%%" /F /A ^>^> "%%OUTPUT_FILE%%"
echo.
echo echo.
echo echo Directory structure has been saved to:
echo echo %%OUTPUT_FILE%%
) > "%SCRIPT_PATH%"

:: Add the Scripts directory to PATH if not already there
echo Checking PATH environment variable...
set "PATH_UPDATED=0"

:: Get current user PATH
for /f "tokens=2*" %%A in ('reg query HKCU\Environment /v PATH 2^>nul ^| find "PATH"') do set "USER_PATH=%%B"

:: Check if Scripts directory is already in PATH
if defined USER_PATH (
    echo %USER_PATH% | findstr /C:"%SCRIPT_DIR%" >nul
    if errorlevel 1 (
        :: Not found in user PATH, add it
        setx PATH "%USER_PATH%;%SCRIPT_DIR%"
        set "PATH_UPDATED=1"
    ) else (
        echo Scripts directory already in PATH.
    )
) else (
    :: No user PATH exists, create it
    setx PATH "%SCRIPT_DIR%"
    set "PATH_UPDATED=1"
)

echo.
echo ===================================================
echo Installation Complete!
echo ===================================================
echo.
echo The dirtree command has been installed!
echo.

if "%PATH_UPDATED%"=="1" (
    echo Your PATH has been updated. You need to restart any open 
    echo command prompts for the changes to take effect.
    echo.
)

echo Usage examples:
echo.
echo   dirtree                  - Capture structure of current directory
echo   dirtree C:\path          - Capture structure of specified directory
echo   dirtree C:\path output.txt - Specify output filename
echo.
echo Press any key to exit...
pause > nul