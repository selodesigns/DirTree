@echo off
setlocal enabledelayedexpansion

:: Create the script file in a permanent location
set "SCRIPT_DIR=%USERPROFILE%\Scripts"
set "SCRIPT_PATH=%SCRIPT_DIR%\dirtree.bat"

:: Create the Scripts directory if it doesn't exist
if not exist "%SCRIPT_DIR%" mkdir "%SCRIPT_DIR%"

:: Create the dirtree.bat script
echo @echo off > "%SCRIPT_PATH%"
echo setlocal enabledelayedexpansion >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Set variables >> "%SCRIPT_PATH%"
echo set "OUTPUT_FILE=%%CD%%\directory_structure.txt" >> "%SCRIPT_PATH%"
echo set "START_DIR=%%CD%%" >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Allow user to specify a different directory >> "%SCRIPT_PATH%"
echo if not "%%~1"=="" ( >> "%SCRIPT_PATH%"
echo     set "START_DIR=%%~1" >> "%SCRIPT_PATH%"
echo     set "OUTPUT_FILE=%%START_DIR%%\directory_structure.txt" >> "%SCRIPT_PATH%"
echo ) >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Ensure directory path ends with a backslash >> "%SCRIPT_PATH%"
echo if not "^!START_DIR:~-1^!"=="\" set "START_DIR=^!START_DIR^!\" >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo echo Directory Structure Capture Tool >> "%SCRIPT_PATH%"
echo echo ============================== >> "%SCRIPT_PATH%"
echo echo. >> "%SCRIPT_PATH%"
echo echo Capturing directory structure from: ^!START_DIR^! >> "%SCRIPT_PATH%"
echo echo Output will be saved to: ^!OUTPUT_FILE^! >> "%SCRIPT_PATH%"
echo echo. >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Create the output file with a header >> "%SCRIPT_PATH%"
echo echo Directory Structure captured on %%date%% at %%time%% ^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo echo Starting directory: ^!START_DIR^! ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo echo ======================================================== ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo echo. ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Use the tree command to capture the directory structure >> "%SCRIPT_PATH%"
echo echo Generating directory tree... >> "%SCRIPT_PATH%"
echo tree "^!START_DIR^!" /F /A ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo echo. >> "%SCRIPT_PATH%"
echo echo Directory structure has been saved to: >> "%SCRIPT_PATH%"
echo echo ^!OUTPUT_FILE^! >> "%SCRIPT_PATH%"

:: Add the script directory to the user's PATH environment variable if not already there
for /f "tokens=3*" %%p in ('reg query HKCU\Environment /v PATH ^| findstr /i path') do set "CURRENT_PATH=%%p %%q"

:: Check if Scripts directory is already in PATH
echo %CURRENT_PATH% | findstr /C:"%SCRIPT_DIR%" > nul
if errorlevel 1 (
    :: Add Scripts directory to PATH
    setx PATH "%CURRENT_PATH%;%SCRIPT_DIR%"
    echo Added %SCRIPT_DIR% to your PATH environment variable.
    echo You will need to restart any open command prompts for the changes to take effect.
) else (
    echo Your Scripts directory is already in your PATH.
)

echo.
echo The 'dirtree' command has been installed!
echo.
echo Usage:
echo   dirtree          - Capture the directory structure of the current directory
echo   dirtree C:\path  - Capture the directory structure of the specified directory
echo.
echo The command will create a 'directory_structure.txt' file in the target directory.
echo.
echo Press any key to exit...
pause > nul