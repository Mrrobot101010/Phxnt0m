@echo off
setlocal

:: Check if Python is already installed
python --version >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Python is already installed.
    goto end
)

:: Determine if the system is 32-bit or 64-bit
if defined ProgramFiles(x86) (
    set "ARCH=64"
) else (
    set "ARCH=32"
)

:: Set the download URL based on the architecture
if %ARCH% equ 64 (
    set "PYTHON_URL=https://www.python.org/ftp/python/3.11.0/python-3.11.0-amd64.exe"
) else (
    set "PYTHON_URL=https://www.python.org/ftp/python/3.11.0/python-3.11.0.exe"
)

:: Download the installer
echo Downloading Python %ARCH%-bit installer...
bitsadmin /transfer "PythonDownloadJob" %PYTHON_URL% "%TEMP%\python-installer.exe"

:: Install Python with the "Add to PATH" option enabled
echo Installing Python...
"%TEMP%\python-installer.exe" /quiet InstallAllUsers=1 PrependPath=1

:: Clean up
del "%TEMP%\python-installer.exe"

:end
echo Done.
endlocal
