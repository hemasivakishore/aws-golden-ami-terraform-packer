#!/bin/bash
set -euo pipefail

META="http://169.254.169.254/latest"
TOKEN=""

# Try to get IMDSv2 token
TOKEN=$(curl -s -X PUT "${META}/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" || true)

# helper to query metadata using token (fall back to v1 if needed)
meta_get() {
  local path="$1"
  local out
  if [ -n "$TOKEN" ]; then
    out=$(curl -sf -H "X-aws-ec2-metadata-token: ${TOKEN}" "${META}/meta-data/${path}" 2>/dev/null || true)
    if [ -n "$out" ]; then
      printf '%s' "$out"
      return 0
    fi
    # token failed, try v1 fallback
    out=$(curl -sf "${META}/meta-data/${path}" 2>/dev/null || true)
    printf '%s' "$out"
    return 0
  else
    # no token, try v1
    out=$(curl -sf "${META}/meta-data/${path}" 2>/dev/null || true)
    printf '%s' "$out"
    return 0
  fi
}

# Fetch metadata values
INSTANCE_ID=$(meta_get "instance-id")
INSTANCE_TYPE=$(meta_get "instance-type")
AMI_ID=$(meta_get "ami-id")
AZ=$(meta_get "placement/availability-zone")
REGION="${AZ%[a-z]}"            # drop trailing letter
PRIVATE_IP=$(meta_get "local-ipv4")
PUBLIC_IP=$(meta_get "public-ipv4")
HOSTNAME=$(meta_get "hostname")
LOCAL_HOSTNAME=$(meta_get "local-hostname")
LOCAL_IPV4=$(meta_get "local-ipv4")
MAC=$(meta_get "mac")
VPC_ID=$(meta_get "network/interfaces/macs/${MAC}/vpc-id")
SUBNET_ID=$(meta_get "network/interfaces/macs/${MAC}/subnet-id")
SECGROUPS=$(meta_get "security-groups")

# safe defaults
: "${INSTANCE_ID:=unknown}"
: "${INSTANCE_TYPE:=unknown}"
: "${AMI_ID:=unknown}"
: "${AZ:=unknown}"
: "${REGION:=unknown}"
: "${PRIVATE_IP:=unknown}"
: "${PUBLIC_IP:=N/A}"
: "${HOSTNAME:=unknown}"
: "${LOCAL_HOSTNAME:=unknown}"
: "${LOCAL_IPV4:=unknown}"
: "${MAC:=unknown}"
: "${VPC_ID:=unknown}"
: "${SUBNET_ID:=unknown}"
: "${SECGROUPS:=unknown}"

# Build HTML page
HTML="/var/www/html/index.html"
TMP="/tmp/ec2_index.html"

cat > "${TMP}" <<EOF
<!doctype html>
<html>
<head><meta charset="utf-8"><title>EC2 Instance System Info</title>
<style>
body{font-family: Arial;padding:20px}
table{border-collapse:collapse;width:90%}
th,td{border:1px solid #333;padding:8px}
th{background:#222;color:#fff}
tr:nth-child(even){background:#f2f2f2}
</style>
</head>
<body>
<h2>EC2 Instance System Information</h2>
<table>
<tr><th>Property</th><th>Value</th></tr>
<tr><td>Instance ID</td><td>${INSTANCE_ID}</td></tr>
<tr><td>Instance Type</td><td>${INSTANCE_TYPE}</td></tr>
<tr><td>AMI ID</td><td>${AMI_ID}</td></tr>
<tr><td>Availability Zone</td><td>${AZ}</td></tr>
<tr><td>Region</td><td>${REGION}</td></tr>
<tr><td>Private IP</td><td>${PRIVATE_IP}</td></tr>
<tr><td>Public IP</td><td>${PUBLIC_IP}</td></tr>
<tr><td>Hostname</td><td>${HOSTNAME}</td></tr>
<tr><td>Local Hostname</td><td>${LOCAL_HOSTNAME}</td></tr>
<tr><td>Local IPv4</td><td>${LOCAL_IPV4}</td></tr>
<tr><td>MAC</td><td>${MAC}</td></tr>
<tr><td>VPC ID</td><td>${VPC_ID}</td></tr>
<tr><td>Subnet ID</td><td>${SUBNET_ID}</td></tr>
<tr><td>Security Groups</td><td>${SECGROUPS}</td></tr>
</table>
</body></html>
EOF

# Ensure webroots exist and copy page
sudo mkdir -p /var/www/html /usr/share/nginx/html
sudo cp "${TMP}" "${HTML}" || true
sudo cp "${TMP}" /usr/share/nginx/html/index.html || true
sudo chmod 644 "${HTML}" /usr/share/nginx/html/index.html
sudo chown root:root "${HTML}" /usr/share/nginx/html/index.html

# Restart nginx
sudo systemctl daemon-reload || true
sudo systemctl enable --now nginx || sudo systemctl start nginx || true

# Print a short verification to stdout
echo "Wrote ${HTML}. Check http://<public-ip>/"
echo "Sample metadata:"
echo "  instance-id: ${INSTANCE_ID}"
echo "  instance-type: ${INSTANCE_TYPE}"
echo "  ami-id: ${AMI_ID}"