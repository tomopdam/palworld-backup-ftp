# Palworld Dedicated Server Backup via FTP on Windows

How to set up a Scheduled Task to automatically copy your [Palworld](https://store.steampowered.com/app/1623730/Palworld/) dedicated server saves to your local machine via FTP (on Windows). 

**Important!** Do not share `set-config.bat` with anybody else! It contains sensitive information.

### Requirements

- WinSCP
- SFTP access to your Palworld dedicated server

## Description

A simple script with instructions for setting up a Scheduled Task that copies your [Palworld](https://store.steampowered.com/app/1623730/Palworld/) dedicated server saves to your local machine via SFTP. 

This might be useful if you don't trust your server host, if they have zero or limited backups, if you want to speed up transitioning from one dedicated server host to another, or just want to take a look at how the world saved data changes over time.

The file list is cribbed from [this Palworld tutorial](https://www.gamenguides.com/how-to-backup-and-transfer-palworld-dedicated-server-to-a-new-server) so I hope it works!

## Instructions

1. Download WinSCP from [here](https://winscp.net/download/)
2. Install it with default settings, then open it
3. Manually connect to your dedicated host's FTP server, then accept & **SAVE the host key to your cache!**
4. Navigate through the FTP server and find where the `Pal/` folder is located relative to root, then check the `DedicatedServerName` value in `.../Pal/Saved/Config/WindowsServer/GameUserSettings.ini`.
5. Create a new folder on your local system where you'll store the script. I'm going to save mine to `C:\PalworldBackups`
6. Clone this repository into it, then rename `set-config.bat.example` to `set-config.bat`, then edit the values as instructed. `REM` is a way of setting comment lines, so they're just explanatory notes for you - you want to edit the lines starting with `SET`
7. Test that it's working: open your cmd prompt (Windows key + r -> type `cmd` and hit enter), then run these two commands in order (you might have to change the script directory):

```
cd C:\PalworldBackup
run-palworld-backup.bat
```

you should see it create the backups folder and copy the files across. Check that they're all ok.

8. Now set up a regular scheduled task on your computer. Open Task Scheduler (Windows key + r -> type `taskschd.msc` and hit enter)
9. Click 'create basic task' and fill in the details as prompted. Under "action" leave it as "start a program", then under "program/script" browse to find the `run-palworld-backup.bat` file and select that, then under "start in (optional)" set it to the folder the script is in. For me it's `C:\PalworldBackup`
10. Tick the 'open the properties dialog' checkbox then hit Finish
11. (optional) If you want to avoid the command prompt popping up every time it runs, tick "Run whether user is logged in or not" and "Do not store password" under the "General" tab, as well as "Hidden" (configure for: Windows 10)
12. Hit OK, then find your new task in Task Scheduler Library, select it, then on the right hit 'run'. After a few seconds it should have created a new backup folder with the current timestamp.

You're done!