firefox-developer-edition accounts.firefox.com
firefox-developer-edition gmail.com
firefox-developer-edition https://account.proton.me/mail
bat cache --build
ya pkg install
python ~/architect/architect/install_packages.py --later
NVIM_LISTEN_ADDRESS= paru -S neovim-git
git clone git@github.com:BaudrillardAlt/nvim-config.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
sudo pacman -Rns linux-firmware linux-zen
sudo pacman -S linux-firmware-amdgpu linux-firmware-radeon linux-firmware-whence linux-firmware-realtek linux-firmware-other linux-firmware-mediatek --needed
dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'

orphans=$(pacman -Qtdq)
[[ -n "$orphans" ]] && sudo pacman -Rns $orphans --noconfirm
