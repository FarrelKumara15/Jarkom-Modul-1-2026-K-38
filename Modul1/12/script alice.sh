#!/bin/sh

# Mendefinisikan IP target (Node knights)
TARGET_IP="192.230.3.2"

echo "Mulai memindai port pada $TARGET_IP..."

# Scan port 22 (Seharusnya Succeeded)
echo "Scanning port 22 (SSH)..."
nc -zv $TARGET_IP 22

# Scan port 80 (Seharusnya Succeeded)
echo "Scanning port 80 (HTTP)..."
nc -zv $TARGET_IP 80

# Scan port 7777 (Seharusnya Connection refused)
echo "Scanning port 7777 (Random/Closed)..."
nc -zv $TARGET_IP 7777