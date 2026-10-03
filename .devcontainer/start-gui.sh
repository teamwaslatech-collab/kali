#!/bin/bash
set -e

VNC_PORT="${VNC_PORT:-5901}"
NOVNC_PORT="${NOVNC_PORT:-6080}"
VNC_RESOLUTION="${VNC_RESOLUTION:-1920x1080}"
VNC_DEPTH="${VNC_DEPTH:-24}"
export DISPLAY=":1"

# تنظيف أي جلسة قديمة عالقة
vncserver -kill :1 >/dev/null 2>&1 || true
pkill -f websockify >/dev/null 2>&1 || true
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

# إعداد مجلد VNC
mkdir -p "$HOME/.vnc"

# xstartup: تشغيل XFCE
cat > "$HOME/.vnc/xstartup" <<'EOF'
#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec dbus-launch --exit-with-session startxfce4
EOF
chmod +x "$HOME/.vnc/xstartup"

# تشغيل خادم VNC بدون كلمة مرور (الوصول محمي عبر مصادقة Codespaces)
vncserver :1 \
    -geometry "$VNC_RESOLUTION" \
    -depth "$VNC_DEPTH" \
    -localhost yes \
    -SecurityTypes None \
    --I-KNOW-THIS-IS-INSECURE

# تشغيل noVNC في الخلفية
nohup websockify --web=/usr/share/novnc/ "$NOVNC_PORT" "localhost:$VNC_PORT" \
    > "$HOME/novnc.log" 2>&1 &

echo "Desktop is ready on port $NOVNC_PORT"
