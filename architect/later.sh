firefox-developer-edition gmail.com
firefox-developer-edition https://account.proton.me/mail
bat cache --build
ya pkg install
python ~/architect/architect/install_packages.py --later
nvim --headless "+Lazy! sync" +qa
sudo pacman -Rns linux-firmware linux-zen
sudo pacman -S linux-firmware-amdgpu linux-firmware-radeon linux-firmware-whence linux-firmware-realtek linux-firmware-other linux-firmware-mediatek --needed
dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'

mkdir -p ~/.local/share/gnupg
chmod 700 ~/.local/share/gnupg

orphans=$(pacman -Qtdq)
[[ -n "$orphans" ]] && sudo pacman -Rns $orphans --noconfirm
