#!/bin/bash
# تنظيف أي جلسات سابقة
vncserver -kill :1 >/dev/null 2>&1 || true

# تشغيل خادم VNC بدون طلب باسورد (لأنه محمي بحساب GitHub الخاص بالمستخدم)
vncserver :1 -geometry 1366x768 -depth 24 -SecurityTypes None

# تشغيل noVNC وربطه بالمنفذ 6080
websockify --web=/usr/share/novnc/ 6080 localhost:5901 >/dev/null 2>&1 &
