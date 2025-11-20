#!/bin/bash
set -e

MOUNT_POINT="/mnt/usb"
USB="/dev/disk/by-label/linux-usb"

SSH_SOURCE="$MOUNT_POINT/.ssh"
SSH_DEST="$HOME/.ssh"

# mount USB
sudo mkdir -p "$MOUNT_POINT"
if [ -e "$USB" ]; then
  if ! mount | grep -q "$USB"; then
    sudo mount "$USB" "$MOUNT_POINT"
  else
    echo "$USB is already mounted."
  fi
else
  echo "$USB does not exist."
  exit 1
fi

if [ -d "$SSH_SOURCE" ]; then
  rsync -avz --delete "$SSH_SOURCE"/ "$SSH_DEST"/
  sudo chown -R "$USER:users" "$SSH_DEST"
  chmod 600 "$SSH_DEST/id_ed25519"
  chmod 644 "$SSH_DEST/id_ed25519.pub"
  chmod 600 "$SSH_DEST/config" "$SSH_DEST/known_hosts.old"
fi

# misc files
MISC_DEST="$HOME/misc"
mkdir -p "$MISC_DEST"

if [ ! -d "$MISC_DEST/books" ]; then
  cp -r "$MOUNT_POINT/books" "$MISC_DEST" || echo "books folder missing"
fi

mkdir -p "$HOME/semester" "$HOME/dev/embedded"

if [ ! -d "$MISC_DEST/dev-templates" ]; then
  git clone git@github.com:BaudrillardAlt/dev-templates.git "$MISC_DEST/dev-templates"
fi
if [ ! -d "$HOME/architect" ]; then
  git clone git@github.com:BaudrillardAlt/architect.git "$HOME/architect"
fi
if [ ! -d "$HOME/notes" ]; then
  git clone git@github.com:BaudrillardAlt/notes.git "$HOME/notes"
fi

if [ ! -d "$HOME/.config/nvim" ]; then
  git clone git@github.com:BaudrillardAlt/nvim-config.git ~/.config/nvim
fi
