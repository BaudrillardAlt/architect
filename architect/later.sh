bat cache --build
ya pkg install

./install_packages.py --later
NVIM_LISTEN_ADDRESS= paru -S neovim-git
nvim --headless "+Lazy! sync" +qa

sudo pacman -Rns linux-firmware linux-zen
sudo pacman -S linux-firmware-amdgpu linux-firmware-radeon linux-firmware-whence linux-firmware-realtek linux-firmware-other --needed
