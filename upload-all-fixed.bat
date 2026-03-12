@echo off
echo ==========================================
echo Uploading All Files to Gnanajyothi Server
echo ==========================================
echo.
echo Files to upload: index.html, about.html, facilities.html,
echo                  programs.html, contact.html, whatsapp.js
echo.

:: Set variables
set KEY_FILE=%USERPROFILE%\.ssh\gnanajyothi_key
set SERVER=gnanajyothi.in
set SSH_USER=u202368585
set REMOTE_PATH=/home/%SSH_USER%/public_html/

:: Check if private key exists
if not exist "%KEY_FILE%" (
    echo [ERROR] SSH private key not found at: %KEY_FILE%
    echo.
    echo Please ensure you have the private key file 'gnanajyothi_key'
    echo (not the .pub file) in your .ssh directory.
    echo.
    echo Alternative upload methods:
    echo 1. Use FileZilla with your hosting credentials
    echo 2. Use cPanel File Manager
    echo 3. Use the hosting provider's web-based file manager
    echo.
    echo FTP Settings (typical for cPanel):
    echo   Host: gnanajyothi.in or ftp.gnanajyothi.in
    echo   Username: u202368585
    echo   Password: [your cPanel password]
    echo   Port: 21 (FTP) or 22 (SFTP)
    goto :error
)

echo [1/6] Uploading index.html...
scp -i "%KEY_FILE%" index.html %SSH_USER%@%SERVER%:%REMOTE_PATH%
if %ERRORLEVEL% neq 0 goto :upload_failed

echo [2/6] Uploading about.html...
scp -i "%KEY_FILE%" about.html %SSH_USER%@%SERVER%:%REMOTE_PATH%
if %ERRORLEVEL% neq 0 goto :upload_failed

echo [3/6] Uploading facilities.html...
scp -i "%KEY_FILE%" facilities.html %SSH_USER%@%SERVER%:%REMOTE_PATH%
if %ERRORLEVEL% neq 0 goto :upload_failed

echo [4/6] Uploading programs.html...
scp -i "%KEY_FILE%" programs.html %SSH_USER%@%SERVER%:%REMOTE_PATH%
if %ERRORLEVEL% neq 0 goto :upload_failed

echo [5/6] Uploading contact.html...
scp -i "%KEY_FILE%" contact.html %SSH_USER%@%SERVER%:%REMOTE_PATH%
if %ERRORLEVEL% neq 0 goto :upload_failed

echo [6/6] Uploading whatsapp.js...
scp -i "%KEY_FILE%" whatsapp.js %SSH_USER%@%SERVER%:%REMOTE_PATH%
if %ERRORLEVEL% neq 0 goto :upload_failed

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
echo Please check:
echo 1. SSH key permissions (should be 600 on Linux/Mac)
echo 2. Server connectivity
echo 3. Your internet connection
echo.
:error
pause
exit /b 1