bat cache --build
ya pkg install

./install_packages.py --later
NVIM_LISTEN_ADDRESS= paru -S neovim-git
nvim --headless "+Lazy! sync" +qa
