#!/bin/bash

if [ $# -ne 3 ]
then
    echo "Usage: $0 <source_directory> <destination_directory> <backup_name>"
    exit 1
fi
