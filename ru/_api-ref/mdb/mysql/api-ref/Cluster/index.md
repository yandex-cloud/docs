---
editable: false
---

# Cluster
Набор методов для управления кластерами MySQL.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "monitoring": [
    {
      "name": "string",
      "description": "string",
      "link": "string"
    }
  ],
  "config": {
    "version": "string",
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": true
    },

    // `config` включает только одно из полей `mysqlConfig_5_7`, `mysqlConfig_8_0`
    "mysqlConfig_5_7": {
      "effectiveConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string"
      },
      "userConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string"
      },
      "defaultConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string"
      }
    },
    "mysqlConfig_8_0": {
      "effectiveConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string"
      },
      "userConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string"
      },
      "defaultConfig": {
        "innodbBufferPoolSize": "integer",
        "maxConnections": "integer",
        "longQueryTime": "number",
        "generalLog": true,
        "auditLog": true,
        "sqlMode": [
          "string"
        ],
        "maxAllowedPacket": "integer",
        "defaultAuthenticationPlugin": "string"
      }
    },
    // конец списка возможных полей`config`

  },
  "networkId": "string",
  "health": "string",
  "status": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор кластера MySQL. Этот идентификатор Managed Service for MySQL генерирует при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер MySQL.</p> 
createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя кластера MySQL. Имя должно быть уникальным в каталоге, соответствовать RFC 1035 и иметь длину 1-63 символа.</p> 
description | **string**<br><p>Описание кластера MySQL. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Пользовательские метки для кластера MySQL в виде пар <code>key:value</code>. Максимум 64 на ресурс.</p> 
environment | **string**<br><p>Среда развертывания кластера MySQL.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
monitoring[] | **object**<br><p>Описание систем мониторинга, относящихся к данному кластеру MySQL.</p> 
monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера MySQL.</p> 
config | **object**<br><p>Конфигурация кластера MySQL.</p> 
config.<br>version | **string**<br><p>Версия серверного программного обеспечения MySQL.</p> 
config.<br>resources | **object**<br>
config.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mysql/concepts/instance-types">документации</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту.</p> 
config.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-ssd — быстрое сетевое хранилище;</li> <li>local-ssd — быстрое локальное хранилище.</li> </ul> 
config.<br>backupWindowStart | **object**<br><p>Описывает время суток. Дата и часовой пояс либо не имеют значения, либо указаны другим образом. API может разрешить високосные секунды. Связанные типы: [google.type.Date][google.type.Date] и <code>google.protobuf.Timestamp</code>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Час в 24-часовом формате. Допустимые значения — от 0 до 23. API может разрешить значение &quot;24:00:00&quot; для таких сценариев, как время закрытия заведения.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минута часа. Допустимые значения — от 0 до 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунда минуты. Обычно допустимые значения — от 0 до 59. API может разрешить значение 60, если поддерживаются високосные секунды.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды, в наносекундах. Допустимые значения — от 0 до 999 999 999.</p> 
config.<br>access | **object**<br>
config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Разрешить доступ для DataLens</p> 
config.<br>mysqlConfig_5_7 | **object** <br>`config` включает только одно из полей `mysqlConfig_5_7`, `mysqlConfig_8_0`<br><br>
config.<br>mysqlConfig_5_7.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера MySQL 5.7 (сочетание параметров, определенных в <code>userConfig</code> и <code>defaultConfig</code>).</p> <p>Поля и структура <code>MysqlConfig5_7</code> отражает параметры конфигурации MySQL 5.7.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании параметра в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_5_7.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера MySQL 5.7.</p> <p>Поля и структура <code>MysqlConfig5_7</code> отражает параметры конфигурации MySQL 5.7.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании параметра в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
config.<br>mysqlConfig_5_7.<br>userConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_5_7.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера MySQL 5.7.</p> <p>Поля и структура <code>MysqlConfig5_7</code> отражает параметры конфигурации MySQL 5.7.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании параметра в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/mysql-security-excerpt/5.6/en/audit-log-options-variables.html#option_mysqld_audit-log">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/5.7/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_8_0 | **object** <br>`config` включает только одно из полей `mysqlConfig_5_7`, `mysqlConfig_8_0`<br><br>
config.<br>mysqlConfig_8_0.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера MySQL 8.0 (сочетание параметров, определенных в <code>userConfig</code> и <code>defaultConfig</code>).</p> <p>Поля и структура <code>MysqlConfig8_0</code> отражает параметры конфигурации MySQL 8.0.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании переменной в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
config.<br>mysqlConfig_8_0.<br>effectiveConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_8_0.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера MySQL 8.0.</p> <p>Поля и структура <code>MysqlConfig8_0</code> отражает параметры конфигурации MySQL 8.0.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании переменной в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
config.<br>mysqlConfig_8_0.<br>userConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
config.<br>mysqlConfig_8_0.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера MySQL 8.0.</p> <p>Поля и структура <code>MysqlConfig8_0</code> отражает параметры конфигурации MySQL 8.0.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании переменной в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>generalLog | **boolean** (boolean)<br><p>Включить запись общего лога запросов MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_general_log">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>auditLog | **boolean** (boolean)<br><p>Включить запись лога аудита MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/audit-log-reference.html#audit-log-options-variables">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>sqlMode[] | **string**<br><p>Режим SQL для сервера MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting">описании переменной в документации MySQL</a>.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>maxAllowedPacket | **integer** (int64)<br><p>Максимальный размер одного пакета в байтах.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 1024 до 134217728 включительно.</p> 
config.<br>mysqlConfig_8_0.<br>defaultConfig.<br>defaultAuthenticationPlugin | **string**<br><p>Плагин аутентификации, используемый в управляемом кластере MySQL.</p> <ul> <li>MYSQL_NATIVE_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html">Native Pluggable Authentication</a>.</li> <li>CACHING_SHA2_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html">Caching SHA-2 Pluggable Authentication</a>.</li> <li>SHA256_PASSWORD: Использует <a href="https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html">SHA-256 Pluggable Authentication</a>.</li> </ul> 
networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (<code>health</code> для каждого хоста в кластере — UNKNOWN).</li> <li>ALIVE: Кластер работает нормально (<code>health</code> для каждого хоста в кластере — ALIVE).</li> <li>DEAD: Кластер не работает (<code>health</code> для каждого узла в кластере — DEAD).</li> <li>DEGRADED: Кластер работает неоптимально (<code>health</code> по крайней мере для одного узла в кластере не ALIVE).</li> </ul> 
status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: На кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 

## Методы {#methods}
Метод | Описание
--- | ---
[addHosts](addHosts.md) | Создает новые хосты для кластера.
[backup](backup.md) | Создает резервную копию для указанного кластера MySQL.
[create](create.md) | Создает кластер MySQL в указанном каталоге.
[delete](delete.md) | Удаляет указанный кластер MySQL.
[deleteHosts](deleteHosts.md) | Удаляет указанные хосты кластера.
[get](get.md) | Возвращает указанный кластер MySQL.
[list](list.md) | Возвращает список кластеров MySQL, принадлежащих указанному каталогу.
[listBackups](listBackups.md) | Получает список доступных резервных копий для указанного кластера MySQL.
[listHosts](listHosts.md) | Получает список хостов для указанного кластера MySQL.
[listLogs](listLogs.md) | Получает логи для указанного кластера MySQL.
[listOperations](listOperations.md) | Возвращает список операций для указанного кластера MySQL.
[move](move.md) | Перемещает кластер MySQL в указанный каталог.
[restore](restore.md) | Создает новый кластер MySQL с использованием указанной резервной копии.
[start](start.md) | Запускает указанный кластер MySQL.
[startFailover](startFailover.md) | Запускает ручное переключение мастера для указанного кластера MySQL.
[stop](stop.md) | Останавливает указанный кластер MySQL.
[update](update.md) | Изменяет указанный кластер MySQL.