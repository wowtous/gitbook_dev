#! /bin/bash

set -e

echo "[v] Starting nginx service"
/usr/sbin/nginx &
echo "[v] Starting sshd service persistent"
/usr/sbin/sshd -D
