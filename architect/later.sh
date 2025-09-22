bat cache --build
rustup default nightly
cargo install starship-jj --locked
curl -LsSf https://github.com/probe-rs/probe-rs/releases/latest/download/probe-rs-tools-installer.sh | sh
ya pkg install

nvim --headless "+Lazy! sync" +qa
