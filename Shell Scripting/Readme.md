# Shell Program
```bash
#!/bin/bash

CURRENT_DATE=$(date)
HOST_NAME=$(hostname)
USER_NAME=$(whoami)

echo "Current Date : $CURRENT_DATE"
echo "Hostname     : $HOST_NAME"
echo "Username     : $USER_NAME"
echo ""
echo "--- Disk Usage ---"
df -h
echo ""

read -p "Enter a name for the new directory to store process logs: " DIR_NAME

echo "Creating directory '$DIR_NAME'..."
mkdir -p "$DIR_NAME"

FILE_PATH="$DIR_NAME/running_processes.txt"
echo "Creating file '$FILE_PATH'..."
touch "$FILE_PATH"

echo "Fetching running processes and saving to $FILE_PATH..."
ps -aux > "$FILE_PATH"

echo "Success! Process list has been saved."
echo "You can view it using: cat $FILE_PATH"
```

# Output
```bash
Current Date : Thu Sep  3 13:15:14 UTC 2026
Hostname     : DESKTOP-QPP3AOS
Username     : vivaan

--- Disk Usage ---
Filesystem      Size  Used Avail Use% Mounted on
none            3.8G     0  3.8G   0% /usr/lib/modules/6.6.87.2-microsoft-standard-WSL2
none            3.8G  4.0K  3.8G   1% /mnt/wsl
drivers         396G  349G   48G  88% /usr/lib/wsl/drivers
/dev/sdd       1007G   11G  946G   2% /
none            3.8G   76K  3.8G   1% /mnt/wslg
none            3.8G     0  3.8G   0% /usr/lib/wsl/lib
rootfs          3.8G  2.7M  3.8G   1% /init
none            3.8G  564K  3.8G   1% /run
none            3.8G     0  3.8G   0% /run/lock
none            3.8G     0  3.8G   0% /run/shm
none            3.8G   76K  3.8G   1% /mnt/wslg/versions.txt
none            3.8G   76K  3.8G   1% /mnt/wslg/doc
C:\             396G  349G   48G  88% /mnt/c
tmpfs           766M   20K  766M   1% /run/user/1000

Enter a name for the new directory to store process logs: process_logs
Creating directory 'process_logs'...
Creating file 'process_logs/running_processes.txt'...
Fetching running processes and saving to process_logs/running_processes.txt...
Success! Process list has been saved.
You can view it using: cat process_logs/running_processes.txt
```