@echo off
echo ==========================================
echo Uploading All Files to Gnanajyothi Server
echo ==========================================
echo.

:: Set variables
set KEY_FILE=%USERPROFILE%\.ssh\id_rsa_gnanajothi
set SERVER=145.79.209.172
set SSH_USER=u202368585
set REMOTE_PATH=/home/%SSH_USER%/public_html/
set PORT=65002

:: Check if private key exists
if not exist "%KEY_FILE%" (
    echo [ERROR] SSH private key not found at: %KEY_FILE%
    pause
    exit /b 1
)

echo Uploading all HTML files...
scp -P %PORT% -i "%KEY_FILE%" *.html %SSH_USER%@%SERVER%:%REMOTE_PATH%
if %ERRORLEVEL% neq 0 goto :upload_failed

echo Uploading CSS and JS files...
scp -P %PORT% -i "%KEY_FILE%" style.css %SSH_USER%@%SERVER%:%REMOTE_PATH%
scp -P %PORT% -i "%KEY_FILE%" whatsapp.js %SSH_USER%@%SERVER%:%REMOTE_PATH%

echo Uploading images...
scp -P %PORT% -i "%KEY_FILE%" *.webp %SSH_USER%@%SERVER%:%REMOTE_PATH%

echo Uploading .htaccess...
scp -P %PORT% -i "%KEY_FILE%" .htaccess %SSH_USER%@%SERVER%:%REMOTE_PATH%

echo.
echo ==========================================
echo All files uploaded successfully!
echo ==========================================
echo.
echo Website should be live at: https://gnanajyothi.in/
echo.
pause
exit /b 0

:upload_failed
echo.
echo ==========================================
echo Upload failed!
echo ==========================================
echo.
pause
exit /b 1
