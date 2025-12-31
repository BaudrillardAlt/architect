#!/bin/bash
set -e
main() {

  sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key F3B607488DB35A47

  sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
  'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst' \
  'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-22-1-any.pkg.tar.zst' \
  'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-22-1-any.pkg.tar.zst' \
  'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-7.1.0.r7.gb9f7d4a-3-x86_64.pkg.tar.zst'

  bash ~/architect/architect/sync-etc.sh
  sudo pacman -Scc --noconfirm
  sudo pacman -Syyu --noconfirm

  sudo pacman -S paru-bin rustup git rsync python chezmoi sccache ccache libc++ clang dosfstools e2fsprogs mold --noconfirm --needed

  chezmoi init --apply --ssh git@github.com:BaudrillardAlt/dotfiles.git

  rustup default nightly
  python ~/architect/architect/install_packages.py

  sudo mount -a

  sudo usermod -aG video,audio,network,git,wheel,input wasd
  python ~/architect/architect/service_manager.py --enable
  sudo cp ./config/limine.conf /boot/EFI/arch-limine/limine.conf

  sudo udevadm control --reload
  sudo udevadm trigger

  sudo pacman -Sc --noconfirm
  paru -Sc --noconfirm
  chsh -s /usr/bin/fish

  sudo journalctl --vacuum-time 1s
}

main
