#!/bin/bash
#
# Clear the shell
clear
echo "##################################################"
# Sets the value directory
echo "1. SETTING DIRECTORY"
echo ""
read -p "Enter the directory where you want the backups to be stored in: " directory
echo ""
echo "##################################################"
#
# Create cache for every backup found
echo "2. GENERATING CACHE FOR OLD BACKUPS"
ls -l $directory | grep -vi total | grep -vi dvbkp_old | grep "dvbkp" | awk '{print $9}' | while read prev_bkp
do
	mv "$directory"/"$prev_bkp" "$directory"/"$prev_bkp"_old
done
echo ""
echo "Generated cache:"
ls -l $directory | grep dvbkp | awk '{print $9}'
echo ""
echo "##################################################"
#
# Creates new backup
echo "3. CREATING NEW BACKUPS"
echo ""
echo "This can take a while. Please wait until the shell clears itself"
docker volume ls --format "{{.Name}}" | while read v_name
do
    docker run --rm -v "$v_name":/data -v "$directory":/backup busybox tar czf /backup/"$v_name".dvbkp -C /data .
    rm -f "$directory"/"$v_name".dvbkp_old
done
echo ""
echo "##################################################"
