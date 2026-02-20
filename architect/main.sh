#!/bin/bash
set -e
main() {

  bash ~/architect/architect/sync-etc.sh
  sudo pacman -Scc --noconfirm
  sudo pacman -Syyu --noconfirm

  sudo pacman -S paru git rsync python chezmoi sccache ccache libc++ clang dosfstools e2fsprogs mold base-devel --noconfirm --needed

  chezmoi init --apply --ssh git@github.com:BaudrillardAlt/dotfiles.git

  python ~/architect/architect/install_packages.py

  sudo mount -a

  chsh -s /usr/bin/fish

  sudo usermod -aG video,audio,network,git,wheel,input wasd
  python ~/architect/architect/service_manager.py --enable
  sudo cp ./config/limine.conf /boot/limine/limine.conf

  sudo udevadm control --reload
  sudo udevadm trigger

  sudo pacman -Sc --noconfirm
  paru -Sc --noconfirm

  sudo journalctl --vacuum-time 1s
}

main
