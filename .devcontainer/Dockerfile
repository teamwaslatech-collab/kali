FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:1 \
    VNC_PORT=5901 \
    NOVNC_PORT=6080 \
    VNC_RESOLUTION=1920x1080 \
    VNC_DEPTH=24 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
        kali-desktop-xfce \
        xfce4-terminal \
        dbus-x11 \
        tigervnc-standalone-server \
        tigervnc-common \
        novnc \
        websockify \
        sudo \
        git \
        curl \
        wget \
        nano \
        procps \
        net-tools \
        locales \
        ca-certificates \
    && sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# رابط رمزي: يفتح المنفذ الرئيسي مباشرة على واجهة noVNC
RUN ln -sf /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# إنشاء مستخدم عادي بصلاحيات sudo
RUN useradd -m -s /bin/bash -G sudo kali \
    && echo "kali ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/kali \
    && chmod 0440 /etc/sudoers.d/kali

USER kali
WORKDIR /home/kali
