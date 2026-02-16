* `MYSQL_ERROR`: Log of errors related to starting, running, and stopping {{ MY }} instances.
* `MYSQL_GENERAL`: Log of client connections and queries.

    It is disabled by default. To enable it, change the [General log](../../../managed-mysql/concepts/settings-list.md#setting-general-log) value when [updating the {{ MY }} settings](../../../managed-mysql/operations/update.md#change-mysql-config).

* `MYSQL_SLOW_QUERY`: Slow query log.

    It is disabled by default. To enable it, change the [Slow query log](../../../managed-mysql/concepts/settings-list.md#setting-slow-query-log) value when [updating the {{ MY }} settings](../../../managed-mysql/operations/update.md#change-mysql-config). See also: [Log slow filter](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-filter), [Log slow rate limit](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-rate-limit), [Log slow rate type](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-rate-type), [Log slow sp statements](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-sp-statements), and [Slow query log always write time](../../../managed-mysql/concepts/settings-list.md#setting-slow-query-log-always-write-time).

* `MYSQL_AUDIT`: Audit log.

    It is disabled by default. To enable it, change the [Audit log](../../../managed-mysql/concepts/settings-list.md#setting-audit-log) value when [updating the {{ MY }} settings](../../../managed-mysql/operations/update.md#change-mysql-config).
