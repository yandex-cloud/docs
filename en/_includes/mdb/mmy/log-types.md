* `MYSQL_ERROR`: Log of errors related to starting, running, and stopping {{ MY }} instances.
* `MYSQL_GENERAL`: Log of client connections and queries.

   This log is disabled by default. To enable this log, change the value of the [General log](../../../managed-mysql/concepts/settings-list.md#setting-general-log) setting when [updating the {{ MY }} settings](../../../managed-mysql/operations/update.md#change-mysql-config).

* `MYSQL_SLOW_QUERY`: Slow query log.

   This log is disabled by default. To enable the log, change the value of the [Slow query log](../../../managed-mysql/concepts/settings-list.md#setting-slow-query-log) setting when [updating the {{ MY }} settings](../../../managed-mysql/operations/update.md#change-mysql-config). For details, see also the [Log slow filter](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-filter), [Log slow rate limit](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-rate-limit), [Log slow rate type](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-rate-type), [Log slow sp statements](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-sp-statements), and [Slow query log always write time](../../../managed-mysql/concepts/settings-list.md#setting-slow-query-log-always-write-time) settings.

* `MYSQL_AUDIT`: Audit log.

   This log is disabled by default. To enable the log, change the value of the [Audit log](../../../managed-mysql/concepts/settings-list.md#setting-audit-log) setting when [updating the {{ MY }} settings](../../../managed-mysql/operations/update.md#change-mysql-config).
