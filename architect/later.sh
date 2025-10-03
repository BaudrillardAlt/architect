bat cache --build
ya pkg install
rustup default nightly
cargo install nirius
./install_packages.py --later
nvim --headless "+Lazy! sync" +qa
