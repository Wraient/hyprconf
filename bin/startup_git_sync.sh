#!/bin/bash

# Get the list of files from the first argument (assuming space-separated)
source_files=(
  "/usr/bin/brave"
  "/home/wraient/.config/hypr"
  "/home/wraient/.bashrc"
  "/home/wraient/.zshrc"
  "/home/wraient/.local/bin"
  "/home/wraient/.config/spicetify"
  "/home/wraient/.config/swaylock/"
  # nvimChad
  "/home/wraient/.config/nvim"
)

# Check if any source files were provided
if [[ -z "$source_files" ]]; then
  echo "Error: No source files provided."
  exit 1
fi

# Set the destination folder
destination_folder="/home/wraient/.hidden/hyprconf"

# Ensure destination folder exists
if [ ! -d "$destination_folder" ]; then
  mkdir "$destination_folder"
fi

# Loop through each source file
for source_path in "${source_files[@]}"; do
  # Check if source path exists
  if [ ! -e "$source_path" ]; then
    echo "Warning: Skipping non-existent file: $source_path"
    continue
  fi

  # Determine if the source is a file or folder
  if [ -f "$source_path" ]; then
    # If it's a file, create parent folder and copy
    parent_folder=$(dirname "$source_path")
    parent_folder_name=$(basename "$parent_folder")
    mkdir -p "$destination_folder/$parent_folder_name"  # Create parent folder if needed (-p flag)
    filename=$(basename "$source_path")
    cp "$source_path" "$destination_folder/$parent_folder_name/$filename"  # Copy with full path
  else
    # If it's a folder, skip processing (handled elsewhere, or comment out if not needed)
    source_folder_name=$(basename "$source_path")
    destination_subfolder="$destination_folder/$source_folder_name"

    # Create the subfolder within destination folder (if needed)
    mkdir -p "$destination_subfolder"

    # Use cp -r to copy folder content recursively
    cp -r "$source_path/"* "$destination_subfolder"
    echo "Successfully copied folder: $source_path"
  fi
done

echo "Contents copied successfully."
notify-send "Copied Files"
