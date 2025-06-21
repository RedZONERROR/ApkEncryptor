# APKEncryptor Server

Java TCP server that validates VIP status & manages the database for the APKEncryptor ecosystem.

## Prerequisites
1. JDK 8 or newer in your `PATH`
2. MySQL 5.6+ running locally or remotely
3. Port 6666 open in the firewall

## 1. Database

```
CREATE DATABASE apk_encryptor CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Import the default tables:

```
mysql -u root -p apk_encryptor < init.sql
```

The individual table schemas are provided as plain-text inside `src/cn/beingyi/apkenceyptor/sql/*.txt`; copy & execute them or paste the statements into a MySQL console.

## 2. Configuration file

The server reads a properties file whose path is defined in `Conf.java` (default `/root/beingyi.conf`).  Create it with e.g.:

```
DB_NAME=apk_encryptor
DB_USER=root
DB_PASS=123456
RootPath=/opt/apkencryptor
RootURL=http://your-domain.com/
```

For local development you may change `Conf.ConfPath` in `src/.../Conf.java` to a relative file such as `conf.properties`.

## 3. Build

Import the folder into IntelliJ IDEA (or any IDE) as a plain Java project and ensure `libs/*.jar` are on the class-path.

Command-line build example (Linux/macOS, replace `:` with `;` on Windows):

```bash
javac -d out -cp "libs/*" $(find src -name "*.java")
```

## 4. Run

```bash
java -cp "libs/*:out" cn.beingyi.apkenceyptor.Main
```

You should see something like:

```
服务器已开启:
监听端口：6666
配置文件路径：/path/to/beingyi.conf
服务器IP: 192.168.x.x
```

## 5. Common problems

* `端口被占用:6666` – stop the program occupying the port or change it in `Main.java`.
* `配置文件不存在` – create the properties file then restart.
