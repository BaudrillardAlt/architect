sudo pacman -S intel-undervolt tlp --needed
paru -S auto-cpufreq
sudo modprobe msr
echo 'msr' | sudo tee /etc/modules-load.d/msr.conf

sudo systemctl enable --now intel-undervolt.service
sudo systemctl enable --now auto-cpufreq

sudo intel-undervolt apply
sudo intel-undervolt read
