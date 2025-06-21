# APKEncryptor – Complete Setup Guide

This document explains how to install **all** modules on either Linux or Windows, from the first `git clone` to a running server and Android client.

> Shell prompt legend  
> `#` = Linux root or sudo shell  
> `$` = Linux regular user  
> `PS>` = Windows PowerShell (run as Administrator)

---

## 0. Clone the repository

### Linux / macOS / WSL
```bash
$ git clone https://github.com/RedZONERROR/ApkEncryptor.git
$ cd ApkEncryptor
```

### Windows
```powershell
PS> git clone https://github.com/RedZONERROR/ApkEncryptor.git
PS> cd .\ApkEncryptor
```

---

## 1. Install prerequisites

| Software | Linux (Ubuntu 22.04 / Debian) | Windows 10/11 |
|----------|--------------------------------|---------------|
| JDK 17 (recommended) | `# apt update && apt install -y openjdk-17-jdk-headless` | `PS> winget install --id Microsoft.OpenJDK.17` |
| MySQL 8 | `# apt install -y mysql-server` | `PS> winget install MySQL.MySQLServer` |
| Git | `# apt install -y git` | `PS> winget install Git.Git` |
| Android Studio* | Download from google.com/android/studio | Download installer |

*Android Studio provides the Android SDK and Gradle. The Gradle Wrapper bundled in each module means you do **not** need a system-wide Gradle install.

Verify your tools:
```bash
$ java -version
$ javac -version
$ mysql --version
```

---

## 2. Prepare the database

```sql
CREATE DATABASE apk_encryptor CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Import the table schemas contained in `APKEncryptor-Server/src/cn/beingyi/apkenceyptor/sql/*.txt`.

---

## 3. Configure the server

Create the properties file referenced by `Conf.ConfPath` (default `/root/beingyi.conf`). Example:
```properties
DB_NAME=apk_encryptor
DB_USER=root
DB_PASS=passw0rd
RootPath=/opt/apkencryptor
RootURL=http://your-domain.com/
```

---

## 4. Build & run each module

### 4.1 `APKEncryptor-Server`

Linux/macOS:
```bash
$ cd APKEncryptor-Server
$ javac -d out -cp "libs/*" $(find src -name "*.java")
$ java  -cp "libs/*:out" cn.beingyi.apkenceyptor.Main
```

Windows CMD (path separator is `;`):
```cmd
> cd APKEncryptor-Server
> mkdir out
> for /r src %f in (*.java) do javac -cp "libs/*;out" -d out "%f"
> java -cp "libs/*;out" cn.beingyi.apkenceyptor.Main
```
You should see:
```
服务器已开启:
监听端口：6666
```

### 4.2 `SubApplication` (shell APK)

Linux:
```bash
$ cd SubApplication
$ ./gradlew :app:assembleDebug
```
Windows:
```powershell
PS> cd .\SubApplication
PS> .\gradlew.bat :app:assembleDebug
```
The APK appears at `SubApplication/app/build/outputs/apk/debug/app-debug.apk`.

### 4.3 `APKEncryptor-Tools`

Edit the three `File` variables at the top of `src/com/beingyi/tools/Main.java` so they reference your workspace:

| Variable | Should point to |
|----------|-----------------|
| `apkFile` | The shell APK built in **4.2** – e.g. `SubApplication/app/build/outputs/apk/debug/app-debug.apk` |
| `assetsDir` | `APKEncryptor-Android/app/src/main/assets` |
| `assetsEnDir` | `APKEncryptor-Android/app/src/main/assets_en` |

When executed, the tool will:
1. Patch and encrypt the shell APK.
2. Generate **`conf.json`** with whatever `server_ip` / `server_port` values are currently hard-coded (edit it first if not localhost).

Then compile & run:

Linux:
```bash
$ cd APKEncryptor-Tools
$ javac -d out -cp "libs/*" $(find src -name "*.java")
$ java  -cp "libs/*:out" com.beingyi.tools.Main
```
Windows:
```cmd
> cd APKEncryptor-Tools
> mkdir out
> for /r src %f in (*.java) do javac -cp "libs/*;out" -d out "%f"
> java -cp "libs/*;out" com.beingyi.tools.Main
```
Outputs:
* `APKEncryptor-Android/app/src/main/assets/sub.apk`
* Encrypted assets under `APKEncryptor-Android/app/src/main/assets_en/`

### 4.4 `APKEncryptor-Android` (client)

Linux:
```bash
$ cd APKEncryptor-Android
$ ./gradlew :app:installDebug   # use :app:assembleRelease for production
```
Windows:
```powershell
PS> cd .\APKEncryptor-Android
PS> .\gradlew.bat :app:installDebug
```
Ensure the device or emulator can reach the server (`ping <server-ip>` from a real device, or `adb reverse tcp:6666 tcp:6666` for an *emulator*).

#### Client endpoint (`conf.json`)
Create or edit `APKEncryptor-Android/app/src/main/assets/conf.json`:
```json
{
  "server_ip"   : "192.168.0.42",
  "server_port" : 6666,
  "SubApplication" : "cn.beingyi.sub.apps.SubApp.SubApplication"
}
```
Adjust the IP/port as needed. **APKEncryptor-Tools** overwrites this file each time it runs, so edit it again afterward if required.

#### Android Studio, SDK & NDK
1. Launch **Android Studio** → *More Actions* → **SDK Manager**.
2. Under **SDK Platforms** select *Android 14 (Upside-Down Cake)* or the API level you target.
3. Under **SDK Tools** enable:  
   • *Android SDK Build-Tools*  
   • *Android SDK Platform-Tools* (includes **adb**)  
   • *NDK (Side by side)* – required if you plan to add native code or enable R8 full-mode.
4. Apply and wait for the packages to download.
5. Add environment variables (Windows example):
   ```powershell
   PS> setx ANDROID_HOME "$Env:LOCALAPPDATA\Android\Sdk"
   PS> setx Path "%Path%;%ANDROID_HOME%\platform-tools"
   ```
   Linux/macOS (`~/.bashrc` or `~/.zshrc`):
   ```bash
   export ANDROID_HOME="$HOME/Android/Sdk"
   export PATH="$PATH:$ANDROID_HOME/platform-tools"
   ```

#### Networking scenarios

| Scenario | What to do |
|----------|------------|
| **Local LAN test-bed** | 1. On the server PC run `ipconfig` (Win) or `ip addr` (Linux) and note the IPv4, e.g. `192.168.0.42`. 2. Edit `APKEncryptor-Android/app/src/main/assets/conf.json` → `"server_ip": "192.168.0.42"`. 3. Optional: `sudo ufw allow 6666/tcp` or enable **Inbound Rule → Port 6666** in Windows Defender Firewall. |
| **Public VPS / Cloud** | 1. SSH into the VPS and run `curl -4 ifconfig.co` to obtain the public IP. 2. Make sure the provider’s dashboard security-group/firewall allows **TCP 6666**. 3. Also allow it at OS level: `sudo ufw allow 6666/tcp` (Ubuntu) or `firewall-cmd --add-port=6666/tcp --permanent && firewall-cmd --reload` (CentOS). 4. Update `RootURL` in `beingyi.conf` to `http://<public-ip>/` and regenerate the client `conf.json` (rerun **APKEncryptor-Tools**). 5. Optional: point an A-record to the VPS and terminate TLS with Nginx or Caddy (not covered here). |
| **Android Emulator** | Use IP `10.0.2.2` *or* run `adb reverse tcp:6666 tcp:6666` so the emulator can reach a server running on the host. |

After updating the IP/port, either edit `APKEncryptor-Android/app/src/main/assets/conf.json` manually or rerun **APKEncryptor-Tools**, which writes a fresh file during its build step.



### 4.5 `KeyCreateor-Andtoid` (optional)
1. Open the module in **Android Studio** and click **Run** to install on your test device.
2. If the app uploads keys automatically, locate the constant such as `BASE_URL` within `KeyCreateor-Andtoid/app/src/main/java` and change it to `http://<your-server-ip>:6666/`.
3. Use the UI to generate a key – it will either be POST-ed to the server or shown on screen.
4. You can also copy the generated string and insert it manually into the MySQL `keys` table.

---

## 5. Troubleshooting

| Symptom | Resolution |
|---------|------------|
| `javac: command not found` | Install/open the JDK (step 1). |
| `端口被占用:6666` | `sudo lsof -i :6666` → kill the conflicting process or change the port constant in `Main.java`. |
| Client cannot connect | Check firewall (`sudo ufw allow 6666/tcp`), verify IP, or use `adb reverse` on emulators. |
| ADB not found | Ensure **platform-tools** is on your `PATH` or reinstall it via the SDK Manager. |
| Gradle build fails | Update Android Studio or edit `gradle-wrapper.properties` to a supported version. |
| Wrong URL in client | Confirm `RootURL` in `beingyi.conf` and the `server_ip`/`server_port` in `conf.json` match the actual IP and port exposed by the server. |

---

Happy coding and secure APK-protection!