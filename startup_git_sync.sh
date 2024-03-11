#!/bin/bash

# List of file paths and folder paths to copy
paths=(


    # Add more file and folder paths as needed
)

# Copy files and folders to archsetup folder
for path in "${paths[@]}"; do
    if [ -f "$path" ]; then
        # If it's a file, copy it directly
        filename=$(basename "$path")
        cp "$path" ~/.hidden/hyprconf/"$filename" 2>/dev/null
    elif [ -d "$path" ]; then
        # If it's a folder, copy its contents recursively
        dirname=$(basename "$path")
        cp -r "$path" ~/.hidden/hyprconf/"$dirname" 2>/dev/null
    fi
done

