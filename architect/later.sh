bat cache --build
ya pkg install
./install_packages.py --later
nvim --headless "+Lazy! sync" +qa
