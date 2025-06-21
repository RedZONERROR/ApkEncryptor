# APKEncryptor-Tools

Command-line helper utilities that (1) encrypt static assets, (2) patch the SubApplication APK, and (3) generate the `conf.json` consumed by **APKEncryptor-Android**.

## Prerequisites
* JDK 8+
* The paths declared at the top of `src/com/beingyi/tools/Main.java` must point to valid files on your machine.

```java
File apkFile   = new File("/absolute/path/to/SubApplication/app/build/outputs/apk/debug/app-debug.apk");
File assetsDir = new File("APKEncryptor-Android/app/src/main/assets");
File assetsEnDir = new File("APKEncryptor-Android/app/src/main/assets_en");
```

Change them to match your folder layout before compiling.

## Build & run

```bash
javac -d out -cp "libs/*" $(find src -name "*.java")
java -cp "libs/*:out" com.beingyi.tools.Main
```

The script will:
1. Encrypt strings inside the SubApplication DEX
2. Re-pack the modified `sub.apk` into the Android client’s assets directory
3. Encrypt every asset into `assets_en/`
4. Write a **`conf.json`** file pointing the Android client to the correct SubApplication entry-point.

## Output
* `APKEncryptor-Android/app/src/main/assets/sub.apk` – protected shell APK
* `APKEncryptor-Android/app/src/main/assets_en/` – encrypted resources ready for release
