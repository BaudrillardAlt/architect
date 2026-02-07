#!/bin/bash
set -euo pipefail

REPO_ROOT="/home/wasd/architect/config/etc"
CHANGED=()

sync_file() {
  local src="$REPO_ROOT/$1"
  local dst="/etc/$1"
  local mode="${2:-0644}"

  if ! cmp -s "$src" "$dst" 2>/dev/null; then
    if command -v difft >/dev/null 2>&1; then
      echo "Changes in $1:"
      difft "$dst" "$src" 2>/dev/null || true
      echo
    fi
    install -Dm"$mode" "$src" "$dst"
    CHANGED+=("$1")
  fi
}

[[ $EUID -ne 0 ]] && exec sudo "$(realpath "$0")" "$@"

sync_file "fstab" 0644
sync_file "makepkg.conf" 0644
sync_file "makepkg.conf.d/rust.conf" 0644
sync_file "pacman.conf" 0644
# sync_file "tlp.conf" 0644

sync_file "greetd/config.toml" 0644
sync_file "keyd/default.conf" 0644

sync_file "scx_loader.toml" 0644

sync_file "debuginfod/archlinux.urls" 0644
sync_file "debuginfod/cachyos.urls" 0644

sync_file "modprobe.d/blacklist.conf" 0644
sync_file "modprobe.d/bluetooth.conf" 0644
sync_file "modprobe.d/debian.conf" 0644
sync_file "modprobe.d/ubuntu.conf" 0644

sync_file "sysctl.d/99-custom.conf" 0644

sync_file "firefox/policies/policies.json" 0644
sync_file "systemd/journald.conf.d/00-journal-size.conf" 0644
sync_file "systemd/system/pci-latency.service" 0644
sync_file "systemd/system/rtkit-daemon.service.d/override.conf" 0644
sync_file "systemd/system/user@.service.d/delegate.conf" 0644
sync_file "systemd/system.conf.d/00-timeout.conf" 0644
sync_file "systemd/system.conf.d/10-limits.conf" 0644
sync_file "systemd/timesyncd.conf.d/10-timesyncd.conf" 0644
sync_file "systemd/user.conf.d/10-limits.conf" 0644
sync_file "systemd/zram-generator.conf" 0644

sync_file "tmpfiles.d/coredump.conf" 0644
sync_file "tmpfiles.d/thp-shrinker.conf" 0644
sync_file "tmpfiles.d/thp.conf" 0644

sync_file "udev/rules.d/40-hpet-permissions.rules" 0644
sync_file "udev/rules.d/60-ioschedulers.rules" 0644
sync_file "udev/rules.d/66-pico.rules" 0644
sync_file "udev/rules.d/69-probe-rs.rules" 0644
sync_file "udev/rules.d/99-cpu-dma-latency.rules" 0644
sync_file "udev/rules.d/96-quartus.rules" 0644

if [[ ${#CHANGED[@]} -eq 0 ]]; then
  echo "No changes"
  exit 0
fi

echo "Synced: ${CHANGED[*]}"

for file in "${CHANGED[@]}"; do
  case "$file" in
  systemd/system/* | systemd/*.conf.d/* | systemd/*.conf)
    systemctl daemon-reload
    break
    ;;
  esac
done

for file in "${CHANGED[@]}"; do
  case "$file" in
  udev/rules.d/*)
    udevadm control --reload-rules
    udevadm trigger
    break
    ;;
  esac
done

for file in "${CHANGED[@]}"; do
  case "$file" in
  sysctl.d/*)
    sysctl --system >/dev/null
    break
    ;;
  esac
done
