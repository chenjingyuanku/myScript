sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo apt update
sudo apt-get install libssl-dev u-boot-tools python3-distutils python3-dev swig build-essential flex bison openssh-server xz-utils python git make gcc g++ libncurses5-dev libncursesw5-dev lib32z1 lsb-core libc6-dev-i386 lib32z1 libuuid1:i386 cmake bc xz-utils automake libtool libevdev-dev pkg-config
