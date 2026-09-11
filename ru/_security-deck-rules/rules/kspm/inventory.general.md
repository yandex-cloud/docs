### Инвентаризация о базовых параметрах ОС {#general}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.general ||
|#

#### Описание

Это правило инвентаризации собирает информацию о базовых параметрах на рабочих узлах с помощью агента инвентаризации.

Запросы:

os_version_s. Информация о версии ОС, ядре и CPU.

```SELECT os_name, os_version, major, minor, patch, build, platform, platform_like, codename, version AS kernel_version, phys_cpu, log_cpu, cpu_microcode FROM kernel_info, (SELECT cpu_physical_cores AS phys_cpu, cpu_logical_cores AS log_cpu, cpu_microcode FROM system_info), (SELECT name AS os_name, version AS os_version, major, minor, patch, build, platform, platform_like, codename FROM os_version);```

authorized_keys_s. Снимок файла authorized_keys.

```WITH homes AS MATERIALIZED (SELECT substr(path, 7, length(path)-7) AS uname FROM file WHERE path LIKE '/home/%' UNION SELECT 'root'), uids AS MATERIALIZED (SELECT username, uid, gid, directory FROM users WHERE username IN homes) SELECT u.username, u.uid, u.gid, k.key_file, k.key FROM authorized_keys AS k JOIN uids AS u ON k.uid = u.uid WHERE k.key IS NOT NULL;```

authorized_keys. Файл authorized_keys.

```WITH homes AS MATERIALIZED (SELECT substr(path, 7, length(path)-7) AS uname FROM file WHERE path LIKE '/home/%' UNION SELECT 'root'), uids AS MATERIALIZED (SELECT username, uid, gid, directory FROM users WHERE username IN homes) SELECT u.username, u.uid, u.gid, k.key_file, k.key FROM authorized_keys AS k JOIN uids AS u ON k.uid = u.uid WHERE k.key IS NOT NULL;```

sudoers_rules_s. Снимок правил sudoers.

```SELECT * FROM sudoers;```

known_hosts_s. Снимок known_hosts.

```SELECT * FROM known_hosts;```

crontab. Строки системного и пользовательского cron/tab.

```SELECT * FROM crontab;```

crontab_s. Строки системного и пользовательского cron/tab.

```SELECT * FROM crontab;```

disk_encryption_s. Статус и информация о шифровании дисков.

```SELECT * FROM disk_encryption;```

disk_encryption_mounts_s. Статус и информация о шифровании дисков.

```SELECT * FROM mounts m, disk_encryption d WHERE m.device_alias = d.name AND m.path = '/' AND d.encrypted = 0;```

sshd_config_s. Критические опции в sshd_config.

```SELECT DISTINCT SUBSTRING(node, 8 + LENGTH(path)) AS node, LOWER(label) AS label, value FROM augeas WHERE path = '/etc/ssh/sshd_config' AND label != '#comment' AND (node LIKE '%/PasswordAuthentication' OR node LIKE '%/PermitRootLogin' OR node LIKE '%/LogLevel' OR node LIKE '%/AuthorizedKeysCommand' OR node LIKE '%/PermitEmptyPasswords');```

nss_s. Конфигурация NSS для passwd/shadow/hosts. Следует сортировать GROUP_CONCAT через OVER(ORDER BY), но это работает плохо.

```WITH dta AS MATERIALIZED (SELECT * FROM augeas WHERE path = '/etc/nsswitch.conf'), dbs AS (SELECT node, value AS name FROM dta WHERE label = 'database' AND value IN ('passwd', 'shadow', 'hosts')) SELECT dbs.name AS db, GROUP_CONCAT(dta.value, ' ') AS services FROM dta JOIN dbs ON dta.node LIKE dbs.node || '/%' WHERE label = 'service' GROUP BY dbs.name;```

oslogin_present_s. Возвращает true, если oslogin присутствует, иначе false.

```WITH dta AS MATERIALIZED (SELECT * FROM augeas WHERE path = '/etc/nsswitch.conf'), dbs AS (SELECT node, value AS name FROM dta WHERE label = 'database' AND value IN ('passwd', 'shadow', 'hosts')) SELECT CASE WHEN EXISTS(SELECT dbs.name, GROUP_CONCAT(dta.value, ' ') AS services FROM dta JOIN dbs ON dta.node LIKE dbs.node || '/%' AND dta.value LIKE '%oslogin%') THEN 'true' ELSE 'false' END AS oslogin_present;```

Результаты можно анализировать с помощью экспорта данных событий из [сервиса Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) в вашу систему SIEM/SOC.

#### Инструкции и решения по выполнению

Правило не требует рекомендаций, потому что является информационным и используется для сбора событий инвентаризации в Audit Trails.

Настройте сбор [событий для Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) в Audit Trails с экспортом в системы SIEM/SOC для анализа результатов инвентаризации.
