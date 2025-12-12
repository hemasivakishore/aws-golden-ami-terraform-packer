#!/bin/bash
set -e

META=http://169.254.169.254/latest/meta-data

INSTANCE_ID=$(curl -s $META/instance-id)
INSTANCE_TYPE=$(curl -s $META/instance-type)
AMI_ID=$(curl -s $META/ami-id)
AZ=$(curl -s $META/placement/availability-zone)
REGION=$(echo "$AZ" | sed 's/[a-z]$//')
PRIVATE_IP=$(curl -s $META/local-ipv4)
PUBLIC_IP=$(curl -s $META/public-ipv4)
HOSTNAME=$(curl -s $META/hostname)
LOCAL_HOSTNAME=$(curl -s $META/local-hostname)
LOCAL_IPV4=$(curl -s $META/local-ipv4)
MAC=$(curl -s $META/mac)
VPC_ID=$(curl -s $META/network/interfaces/macs/$MAC/vpc-id)
SUBNET_ID=$(curl -s $META/network/interfaces/macs/$MAC/subnet-id)
SECGROUPS=$(curl -s $META/security-groups)

TABLE_TEXT=$(cat <<EOF
+----------------------+-------------------------------------------+
| Property             | Value                                     |
+----------------------+-------------------------------------------+
| Instance ID          | $INSTANCE_ID                              |
| Instance Type        | $INSTANCE_TYPE                            |
| AMI ID               | $AMI_ID                                   |
| Availability Zone    | $AZ                                       |
| Region               | $REGION                                   |
| Private IP           | $PRIVATE_IP                               |
| Public IP            | ${PUBLIC_IP:-N/A}                          |
| Hostname             | $HOSTNAME                                 |
| Local Hostname       | $LOCAL_HOSTNAME                           |
| Local IPv4           | $LOCAL_IPV4                               |
| MAC Address          | $MAC                                      |
| VPC ID               | $VPC_ID                                   |
| Subnet ID            | $SUBNET_ID                                |
| Security Groups      | $SECGROUPS                                |
+----------------------+-------------------------------------------+
EOF
)

echo "$TABLE_TEXT" > /etc/system-info.txt

cat <<EOF > /var/www/html/index.html
<html>
<head>
<title>EC2 System Info</title>
<style>
body { font-family: Arial; padding: 20px; }
table { border-collapse: collapse; width: 80%; }
th, td { border: 1px solid #333; padding: 8px; }
th { background-color: #222; color: white; }
tr:nth-child(even) { background-color: #f2f2f2; }
</style>
</head>
<body>
<h2>EC2 Instance System Information</h2>
<table>
<tr><th>Property</th><th>Value</th></tr>
<tr><td>Instance ID</td><td>$INSTANCE_ID</td></tr>
<tr><td>Instance Type</td><td>$INSTANCE_TYPE</td></tr>
<tr><td>AMI ID</td><td>$AMI_ID</td></tr>
<tr><td>Availability Zone</td><td>$AZ</td></tr>
<tr><td>Region</td><td>$REGION</td></tr>
<tr><td>Private IP</td><td>$PRIVATE_IP</td></tr>
<tr><td>Public IP</td><td>${PUBLIC_IP:-N/A}</td></tr>
<tr><td>Hostname</td><td>$HOSTNAME</td></tr>
<tr><td>Local Hostname</td><td>$LOCAL_HOSTNAME</td></tr>
<tr><td>Local IPv4</td><td>$LOCAL_IPV4</td></tr>
<tr><td>MAC Address</td><td>$MAC</td></tr>
<tr><td>VPC ID</td><td>$VPC_ID</td></tr>
<tr><td>Subnet ID</td><td>$SUBNET_ID</td></tr>
<tr><td>Security Groups</td><td>$SECGROUPS</td></tr>
</table>
</body>
</html>
EOF

systemctl restart nginx
