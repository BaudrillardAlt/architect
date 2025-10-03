bat cache --build
ya pkg install
rustup default nightly
cargo install nirius
./install_packages.py --later
NVIM_LISTEN_ADDRESS= paru -S neovim-git
nvim --headless "+Lazy! sync" +qa
