-- APKEncryptor full database schema for MySQL 8+
-- Usage (command-line):
--   mysql -u root -p apk_encryptor < schema.sql
-- Or from inside the MySQL monitor:
--   USE apk_encryptor;
--   SOURCE /absolute/path/to/schema.sql;

USE apk_encryptor;

-- ------------------------------------------------------------
-- 1. Table: code
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS code (
  ID          INT(11)      NOT NULL AUTO_INCREMENT,
  Code        VARCHAR(6)   NOT NULL,
  Email       VARCHAR(32)  NOT NULL,
  isUsed      INT(1)       NOT NULL DEFAULT 0,
  CreateTime  DATETIME     NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 2. Table: feedback
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS feedback (
  ID          INT(11)      NOT NULL AUTO_INCREMENT,
  Content     TEXT         NOT NULL,
  AuthorID    INT(11)      NOT NULL,
  CreateTime  DATETIME     NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 3. Table: keys  (back-ticked because KEY is reserved)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `keys` (
  ID            INT(11)       NOT NULL AUTO_INCREMENT,
  `Key`         VARCHAR(255)  NOT NULL,
  `Type`        INT(1)        NOT NULL DEFAULT 0,
  UserID        VARCHAR(16)   NOT NULL DEFAULT '0',
  isUsed        INT(1)        NOT NULL DEFAULT 0,
  Mark          VARCHAR(255),
  CreateTime    DATETIME      NOT NULL,
  ActivateTime  DATETIME,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 4. Table: users
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
  ID            INT(11)       NOT NULL AUTO_INCREMENT,
  Email         VARCHAR(32)   NOT NULL,
  `Password`    VARCHAR(32)   NOT NULL,
  VIP           DATE,
  isLifeTimeVip INT(1)        NOT NULL DEFAULT 0,
  isForbidden   INT(1)        NOT NULL DEFAULT 0,
  LoginTime     DATETIME,
  SignupTime    DATETIME,
  LoginIP       VARCHAR(255),
  SignupIP      VARCHAR(255),
  LoginKey      VARCHAR(255),
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
