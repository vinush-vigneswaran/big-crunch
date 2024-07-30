#!/bin/bash

echo "--->>> Running Big Crunch..."

# Define the target directory and repository URL
TARGET_DIR="/home/big-crunch"
REPO_URL="https://github.com/vinush-vigneswaran/big-crunch.git"

# Check if the directory does not exist or is empty
if [ ! -d "$TARGET_DIR" ] || [ -z "$(ls -A $TARGET_DIR)" ]; then
    echo "--->>> Setting up the directory and cloning the repository..."
    rm -rf "$TARGET_DIR"  # Safely remove if something exists, be careful with this command
    mkdir -p "$TARGET_DIR"
    git clone "$REPO_URL" "$TARGET_DIR"
else
    echo "--->>> Directory exists, pulling latest changes..."
    git -C "$TARGET_DIR" fetch 
    git -C "$TARGET_DIR" pull 
fi

# Assuming Python virtual environment directory is directly under the cloned repo
ENV_PATH="/home/envs/bigcrunch/bin/activate"
REQUIREMENTS_PATH="$TARGET_DIR/requirements.txt"
MANAGE_PY="$TARGET_DIR/manage.py"

echo "--->>> Looking for environment... "$ENV_PATH""

if [ -f "$ENV_PATH" ]; then
    echo "Setting up environment... "
    source "$ENV_PATH"
    pip install -r "$REQUIREMENTS_PATH"
else
    echo "Virtual environment not found, please check the setup."
    exit 1
fi

echo "--->>> Creating symbollic link..."
MEDIA_DIR="$TARGET_DIR/peek/media"
MOTION_DIR="/mnt/sandisk32usb/minishare/motion/"

# Check if a directory or link already exists at the destination
if [ -e "${MEDIA_DIR}" ]; then
    echo "--->>> The directory or a link ${MEDIA_DIR} already exists. Removing..."
    rm -r "${MEDIA_DIR}"
fi

# Create a symbolic link
echo "--->>> Linking media and motion files..."
ln -s "${MOTION_DIR}" "${MEDIA_DIR}"


echo "--->>> Starting server..."
if [ -f "$MANAGE_PY" ]; then
    python "$MANAGE_PY" migrate
    python "$MANAGE_PY" runserver 0.0.0.0:5000
else
    echo "--->>> manage.py not found, cannot start server."
    exit 1
fi




