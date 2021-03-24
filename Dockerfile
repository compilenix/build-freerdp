FROM fedora:33

RUN set -ex \
    && dnf update --refresh --assumeyes \
    && dnf install --assumeyes https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    && dnf install --assumeyes dnf-plugins-core util-linux-user findutils which python3 python git zsh redhat-lsb-core neovim tmux python3-pip langpacks-de langpacks-en glibc-langpack-en glibc-langpack-de make gcc-c++ gcc cmake alsa-lib-devel cmake cups-devel dbus-devel dbus-glib-devel faac faac-devel faad2-devel ffmpeg-devel gcc gcc-c++ glib2-devel gsm-devel libjpeg-devel libusb-devel libuuid-devel libX11-devel libXcursor-devel libXdamage-devel libXext-devel libXi-devel libXinerama-devel libxkbfile-devel libXrandr-devel libXv-devel ninja-build openssl-devel pulseaudio-libs-devel systemd-devel wayland-devel wayland-protocols-devel \
    && dnf builddep --assumeyes freerdp sway \
    && curl https://git.compilenix.org/CompileNix/server-dotfiles/-/raw/master/install.sh | bash \
    && dnf autoremove \
    && dnf clean all
COPY build.sh /bin/
CMD ["/bin/build.sh"]
