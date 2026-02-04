#!/bin/bash
set -euxo pipefail

dnf -y update
dnf -y install nginx
systemctl enable nginx
systemctl start nginx
echo "<h1>Hello from NGINX on AL2023</h1>" > /usr/share/nginx/html/index.html