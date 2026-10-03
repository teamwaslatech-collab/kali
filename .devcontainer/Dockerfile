FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=kali

# تحديث الحزم وتثبيت واجهة XFCE و VNC و noVNC والأدوات الأساسية
RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-terminal \
    xfce4-goodies \
    tigervnc-standalone-server \
    novnc \
    websockify \
    dbus-x11 \
    sudo \
    curl \
    git \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# إنشاء مستخدم kali بصلاحيات sudo
RUN useradd -m -s /bin/bash -G sudo kali && \
    echo "kali:kali" | chpasswd && \
    echo "kali ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER kali
WORKDIR /home/kali

# إنشاء إعدادات VNC الافتراضية
RUN mkdir -p /home/kali/.vnc && \
    echo '#!/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &' > /home/kali/.vnc/xstartup && \
    chmod +x /home/kali/.vnc/xstartup
