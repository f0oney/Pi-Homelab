#!/bin/bash

# ==== Configuration ====
REMOTE_NAME="ProtonDrive"
DESTINATION_BASE="Raspberry Pi Backups"
SOURCES=( "/home/fooney" "/etc/" )
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
DESTINATION="$REMOTE_NAME:$DESTINATION_BASE/$TIMESTAMP"
FILELIST="/tmp/rclone_files.txt"
# =======================

# Clear previous file list
> "$FILELIST"

echo "Starting backup to: $DESTINATION"

# Collect all files from each source folder
for SRC in "${SOURCES[@]}"; do
    if [ -d "$SRC" ]; then
        find "$SRC" -type f >> "$FILELIST"
        echo "Added files from: $SRC"
    else
        echo "Warning: $SRC is not a valid folder. Skipping."
    fi
done

# Run rclone to copy the files while preserving full paths
rclone copy / "$DESTINATION" \
    --files-from "$FILELIST" \
    --create-empty-src-dirs \
    --copy-links \
    --progress

echo "Backup finished!"
