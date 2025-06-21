# SubApplication (Shell APK)

Minimal Android application that wraps your real APK and performs runtime decryption of strings & assets.

## Build
Open the project in Android Studio and build it as you would any other module:

```
./gradlew :app:assembleDebug
```

The generated APK is required by **APKEncryptor-Tools**, so build it first.  Its path is hard-coded in `APKEncryptor-Tools/src/com/beingyi/tools/Main.java` – adjust either the gradle output path or the Java constant so the tools can find the file.

## Customisation
* Change the package name in `app/src/main/AndroidManifest.xml` if needed.
* Update ProGuard / R8 rules in `app/proguard-rules.pro` so that reflection-based decryption still works.
