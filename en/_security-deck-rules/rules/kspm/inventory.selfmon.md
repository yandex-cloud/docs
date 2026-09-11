### Osquery agent self-monitoring inventory {#selfmon}

#|
|| **kind** | **severity** | **ID** ||
|| inventory | low | inventory.selfmon ||
|#

#### Description

This inventory rule collects resource usage metrics for the osquery agent across worker nodes using an inventory agent.

Queries:

resource_usage. Osquery daemon CPU in seconds, RAM in MiB usage and db size in MiB.

```SELECT SUM(resident_size)/1024/1024 AS mem, ((SUM(user_time) + SUM(system_time)) / 1000) AS cpu, db.db_size_mb AS db_size FROM processes, (SELECT (SUM(size) / 1024) / 1024 AS db_size_mb FROM (SELECT value FROM osquery_flags WHERE name = 'database_path' LIMIT 1) flags, file WHERE path LIKE flags.value || '%%' AND type = 'regular') db WHERE name = 'osqueryd' OR name = 'osqueryd.exe';```

You can analyze the results by exporting event data from [Audit Trails](https://yandex.cloud/ru/docs/security-deck/at-ref) to your SIEM or SOC system.

#### Instructions and solutions

This rule does not require guidance since it is informational and used to collect inventory events within Audit Trails.

You can configure [event collection for Security Deck](https://yandex.cloud/ru/docs/security-deck/at-ref) in Audit Trails and export the data to SIEM or SOC systems to analyze the inventory results.
