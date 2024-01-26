@echo off

REM load vars from config
echo Loading config from set-config.bat...
CALL set-config.bat

REM set new folder name for this specific operation's backup files, in format: yyyy_mm_dd__hh_mm_ss
SET dt=%DATE:~6,4%_%DATE:~3,2%_%DATE:~0,2%__%TIME:~0,2%_%TIME:~3,2%_%TIME:~6,2%
SET dt=%dt: =0%

REM set remote folders
SET REMOTE_WINDOWS_SERVER_DIR=%REMOTE_BASE_DIR%/Pal/Saved/Config/WindowsServer
SET REMOTE_SAVEGAMES_DIR=%REMOTE_BASE_DIR%/Pal/Saved/SaveGames/0/%DEDICATED_SERVER_NAME%

REM set local folders
SET THIS_BACKUP_DIR=%LOCAL_BACKUPS_DIR%\%dt%
SET THIS_BACKUP_WINDOWS_SERVER_DIR=%THIS_BACKUP_DIR%\Pal\Saved\Config\WindowsServer
SET THIS_BACKUP_SAVEGAMES_DIR=%THIS_BACKUP_DIR%\Pal\Saved\SaveGames\0\%DEDICATED_SERVER_NAME%

REM start script

echo Creating local folders...

REM make sure LOCAL_BACKUPS_DIR folder exists
IF NOT EXIST "%LOCAL_BACKUPS_DIR%" (
    MKDIR "%LOCAL_BACKUPS_DIR%"
)

REM create the local backup subfolders
MKDIR "%THIS_BACKUP_WINDOWS_SERVER_DIR%"
MKDIR "%THIS_BACKUP_SAVEGAMES_DIR%"

echo Connecting to ftp and running backup...

REM run WinSCP with the FTP backup script to copy the files over
"%LOCAL_WINSCP_DIR%\Winscp.com" /script="%LOCAL_SCRIPT_DIR%\FTPBackupScript.txt"