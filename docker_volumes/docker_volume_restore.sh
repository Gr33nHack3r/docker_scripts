#!/bin/bash
#
# Clear the shell
clear
# Create new docker volume
echo "1. CREATING NEW DOCKER VOLUME"
echo ""
read -p "Enter the name you want to assign to the new docker volume: " new_volume
docker volume create $new_volume
echo ""
echo "##################################################"
#
# Sets the value directory
echo "2. SETTING DIRECTORY"
echo ""
read -p "Enter the directory where the backups are stored in: " directory
echo ""
echo "##################################################"
#
# Sets the value backup_file
echo "3. SELECTING BACKUP TO RESTORE"
echo ""
echo "Backups found in the directory:"
ls -l $directory | grep -i "dvbkp" | awk '{print $9}'
echo ""
read -p "Enter the name of the backup file you want to restore (with the extension .dvbkp): " backup_file
echo ""
echo "##################################################"
#
# Start restore
echo "4. STARTING RESTORE"
echo "This can take a while. Please wait"
# mv "$directory"/"$backup_file" "$directory"/"$backup_file".tar.gz
docker run --rm -v "$new_volume":/data -v "$directory":/backup busybox tar xzf /backup/"$backup_file" -C /data
echo ""
echo "Restore completed"
echo ""
echo "##################################################"
