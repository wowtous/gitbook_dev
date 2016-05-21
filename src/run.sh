#! /bin/bash

set -e

echo "[x] sshd and nginx service starting ..."
/usr/sbin/sshd -D && /usr/sbin/nginx &
echo "[v] sshd and nginx service started."
