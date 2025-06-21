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

Edit the three `File` paths at the top of `src/com/beingyi/tools/Main.java` so they point to your local directories, then compile:

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
Ensure the device or emulator can reach the server (`ping` or `adb reverse tcp:6666 tcp:6666`).

### 4.5 `KeyCreateor-Andtoid` (optional)
Open the module in Android Studio and click **Run**. Generated keys can be inserted into the `keys` table manually or via any built-in upload feature.

---

## 5. Troubleshooting

| Symptom | Resolution |
|---------|------------|
| `javac: command not found` | Install/open the JDK (step 1). |
| `端口被占用:6666` | `sudo lsof -i :6666` → kill the conflicting process or change the port constant in `Main.java`. |
| Client cannot connect | Check firewall (`sudo ufw allow 6666/tcp`), verify IP, or use `adb reverse` on emulators. |
| Gradle build fails | Update Android Studio or edit `gradle-wrapper.properties` to a supported version. |

---

Happy coding and secure APK-protection!

