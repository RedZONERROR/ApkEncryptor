# KeyCreator – Android

Generates & manages VIP license keys that are consumed by **APKEncryptor-Server**.

## Requirements
* Android Studio (same version as in the main client)
* Server URL/credentials, if the app uploads keys automatically (check source code)

## Setup
1. Open **KeyCreateor-Andtoid** in Android Studio.
2. Gradle sync will download dependencies; accept any SDK platform prompts.
3. Update any hard-coded endpoint constants (search for `http://` or IP addresses in the code).
4. Run on a device/emulator and generate keys.

## Output
Keys are usually saved to internal storage or uploaded to the server; check `app/src/main/java/...` for implementation details.
