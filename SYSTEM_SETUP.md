# APKEncryptor – Complete Setup Guide

Follow the 5-step checklist below to get the whole ecosystem running on a single machine.

| # | Component | Purpose |
|---|-----------|---------|
|1|`APKEncryptor-Server`|Holds MySQL data & validates VIP status over TCP (port **6666**) |
|2|`SubApplication`|Light-weight shell APK that will be embedded into the client |
|3|`APKEncryptor-Tools`|Encrypts assets & patches the SubApplication APK |
|4|`APKEncryptor-Android`|Main Android client users install |
|5|`KeyCreateor-Andtoid`|Admin tool for generating licence keys |

---

## 1. Install prerequisites
* **Java Development Kit** 8 or newer (`java -version`)
* **MySQL** server 5.6+
* **Android Studio** + SDK Platform 34
* Git (optional) for version control

---

## 2. Spin up the server
1. Create a new MySQL database and import the schema (see server README).
2. Write `beingyi.conf` and point `Conf.ConfPath` there if you keep it outside `/root`.
3. Build & run the server:
   ```bash
   cd APKEncryptor-Server
   javac -d out -cp "libs/*" $(find src -name "*.java")
   java -cp "libs/*:out" cn.beingyi.apkenceyptor.Main
   ```
4. Verify you see *服务器已开启* in the console.

---

## 3. Build the shell APK (SubApplication)
```bash
cd SubApplication
./gradlew :app:assembleDebug
```
> Output: `SubApplication/app/build/outputs/apk/debug/app-debug.apk`

---

## 4. Encrypt assets & generate `conf.json`
```bash
cd APKEncryptor-Tools
# Edit Main.java paths if required
javac -d out -cp "libs/*" $(find src -name "*.java")
java -cp "libs/*:out" com.beingyi.tools.Main
```
The tool will copy the modified `sub.apk` and encrypted assets into the Android client module.

---

## 5. Build the Android client
```bash
cd APKEncryptor-Android
./gradlew :app:installDebug   # or assembleRelease for production
```
Make sure your phone/emulator can reach the server’s IP & port.

---

## 6. (Optional) Generate VIP keys
Open **KeyCreateor-Andtoid** in Android Studio.  Build & run the app, then create licence keys and insert them into the MySQL `keys` table (or upload via the app if implemented).

---

## Troubleshooting checklist
* **Port conflicts** – change ports or free the listening socket.
* **Firewall** – allow TCP/6666 on the host.
* **DB credentials** – confirm they match exactly in `beingyi.conf`.
* **Network** – run `ping <server-ip>` from the device; use `adb reverse tcp:6666 tcp:6666` for emulators.
* **Gradle version mismatch** – upgrade Android Studio or change the version in `gradle-wrapper.properties`.
