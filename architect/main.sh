#!/bin/bash
set -e
main() {

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
  sudo cp ./config/limine.conf /boot

  sudo udevadm control --reload
  sudo udevadm trigger

  sudo pacman -Sc --noconfirm
  paru -Sc --noconfirm
  chsh -s /usr/bin/fish

  sudo journalctl --vacuum-time 1s
  orphans=$(pacman -Qtdq)
  [[ -n "$orphans" ]] && sudo pacman -Rns $orphans
}

main
