### Base OS property inventory {#general}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.general ||
|#

#### Description

This inventory rule collects data on base OS properties across worker nodes using an inventory agent.

Queries:

os_version_s. Retrieves information about the OS version, kernel and CPU.

```SELECT os_name, os_version, major, minor, patch, build, platform, platform_like, codename, version AS kernel_version, phys_cpu, log_cpu, cpu_microcode FROM kernel_info, (SELECT cpu_physical_cores AS phys_cpu, cpu_logical_cores AS log_cpu, cpu_microcode FROM system_info), (SELECT name AS os_name, version AS os_version, major, minor, patch, build, platform, platform_like, codename FROM os_version);```

authorized_keys_s. Authorized_keys file snapshot.

```WITH homes AS MATERIALIZED (SELECT substr(path, 7, length(path)-7) AS uname FROM file WHERE path LIKE '/home/%' UNION SELECT 'root'), uids AS MATERIALIZED (SELECT username, uid, gid, directory FROM users WHERE username IN homes) SELECT u.username, u.uid, u.gid, k.key_file, k.key FROM authorized_keys AS k JOIN uids AS u ON k.uid = u.uid WHERE k.key IS NOT NULL;```

authorized_keys. Authorized_keys present.

```WITH homes AS MATERIALIZED (SELECT substr(path, 7, length(path)-7) AS uname FROM file WHERE path LIKE '/home/%' UNION SELECT 'root'), uids AS MATERIALIZED (SELECT username, uid, gid, directory FROM users WHERE username IN homes) SELECT u.username, u.uid, u.gid, k.key_file, k.key FROM authorized_keys AS k JOIN uids AS u ON k.uid = u.uid WHERE k.key IS NOT NULL;```

sudoers_rules_s. Sudoers rules snapshot.

```SELECT * FROM sudoers;```

known_hosts_s. Known_hosts snapshot.

```SELECT * FROM known_hosts;```

crontab. Line parsed values from system and user cron/tab.

```SELECT * FROM crontab;```

crontab_s. Line parsed values from system and user cron/tab.

```SELECT * FROM crontab;```

disk_encryption_s. Disk encryption status and information.

```SELECT * FROM disk_encryption;```

disk_encryption_mounts_s. Disk encryption status and information.

```SELECT * FROM mounts m, disk_encryption d WHERE m.device_alias = d.name AND m.path = '/' AND d.encrypted = 0;```

sshd_config_s. Critical options in sshd_config.

```SELECT DISTINCT SUBSTRING(node, 8 + LENGTH(path)) AS node, LOWER(label) AS label, value FROM augeas WHERE path = '/etc/ssh/sshd_config' AND label != '#comment' AND (node LIKE '%/PasswordAuthentication' OR node LIKE '%/PermitRootLogin' OR node LIKE '%/LogLevel' OR node LIKE '%/AuthorizedKeysCommand' OR node LIKE '%/PermitEmptyPasswords');```

nss_s. Nss configuration for passwd/shadow/hosts. Should sort GROUP_CONCAT using OVER(ORDER BY) clause, but its works bad.

```WITH dta AS MATERIALIZED (SELECT * FROM augeas WHERE path = '/etc/nsswitch.conf'), dbs AS (SELECT node, value AS name FROM dta WHERE label = 'database' AND value IN ('passwd', 'shadow', 'hosts')) SELECT dbs.name AS db, GROUP_CONCAT(dta.value, ' ') AS services FROM dta JOIN dbs ON dta.node LIKE dbs.node || '/%' WHERE label = 'service' GROUP BY dbs.name;```

oslogin_present_s. Returns true if oslogin is present, else false.

```WITH dta AS MATERIALIZED (SELECT * FROM augeas WHERE path = '/etc/nsswitch.conf'), dbs AS (SELECT node, value AS name FROM dta WHERE label = 'database' AND value IN ('passwd', 'shadow', 'hosts')) SELECT CASE WHEN EXISTS(SELECT dbs.name, GROUP_CONCAT(dta.value, ' ') AS services FROM dta JOIN dbs ON dta.node LIKE dbs.node || '/%' AND dta.value LIKE '%oslogin%') THEN 'true' ELSE 'false' END AS oslogin_present;```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
