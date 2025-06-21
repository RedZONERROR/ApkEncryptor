# APKEncryptor – Android Client

Android application that communicates with `APKEncryptor-Server` to verify VIP status and perform APK encryption locally.

## Requirements
* Android Studio Giraffe | 2022.3.1 or newer (Gradle 8.9 wrapper is included)
* Android SDK Platform 34
* A running instance of `APKEncryptor-Server`

## 1. Import the project
1. Open Android Studio → **Open an Existing Project** and select the `APKEncryptor-Android` folder.
2. The first sync will download the Gradle wrapper & dependencies – be patient.

## 2. Configure the server endpoint
The app reads its configuration from **`app/src/main/assets/conf.json`**.  Ensure the file contains the correct URL and port of your server, for example:

```json
{
  "server_ip": "192.168.1.100",
  "server_port": 6666
}
```

> Tip: If the file is missing, run the **APKEncryptor-Tools** module which will create / update it automatically.

## 3. Build & install
Use the **Run** button in Android Studio, or build an APK via:

```
./gradlew :app:assembleRelease
```

The generated APK will be in `app/build/outputs/apk/`.

## 4. Troubleshooting
* “Unable to resolve host” → phone/AVD cannot reach the server.  Check Wi-Fi, VPN, or use your public IP.
* “java.security.cert.CertPathValidatorException” → mismatch between HTTPS cert and `RootURL` in server conf.
