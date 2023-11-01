#!/bin/bash

# Check syntax
if [ $# -ne 3 ]; then
    echo "Usage: $0 <source_directory> <destination_directory> <backup_name>"
    exit 1
fi

# Variables needed
if [[ "$1" != */ ]]; then
    source_directory="${1}/"
else
    source_directory="$1"
fi

if [[ "$2" != */ ]]; then
    destination_directory="${2}/"
else
    destination_directory="$2"
fi

mmddyyyy=$(date +'%Y%m%d')

if [[ $3 != *.tar.gz ]]; then
    backup_name="${3}-${mmddyyyy}.tar.gz"
else
    backup_name="${3}-${mmddyyyy}"
fi

# Check whether user have acces to directories
ls ${source_directory} && ls ${destination_directory}
if [ $? -ne 0 ]; then
    echo "You do not have access permission to the directory. Run again with sudo or root account."
    exit 2
fi

# Check for existing backup name
if [ -f ${destination_directory}${backup_name} ]; then
    echo "There is already backup on ${destination_directory} named ${backup_name}, renaming the old one to old_${backup_name}"
    mv ${destination_directory}${backup_name} ${destination_directory} old_${backup_name}
fi

# Start backup
echo "${source_directory} is being backed up ..."
tar -czvf ${destination_directory}${backup_name} ${source_directory} >> /dev/null
