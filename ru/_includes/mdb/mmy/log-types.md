* `MYSQL_ERROR` — лог ошибок, связанных с запуском, работой и остановкой инстансов {{ MY }}.
* `MYSQL_GENERAL` — лог клиентских соединений и запросов.

    По умолчанию, лог не ведется. Чтобы включить его, измените значение настройки [General log](../../../managed-mysql/concepts/settings-list.md#setting-general-log) при [изменении настроек {{ MY }}](../../../managed-mysql/operations/update.md#change-mysql-config).

* `MYSQL_SLOW_QUERY` — лог медленных запросов.

    По умолчанию, лог не ведется. Чтобы включить его, измените значение настройки [Slow query log](../../../managed-mysql/concepts/settings-list.md#setting-slow-query-log) при [изменении настроек {{ MY }}](../../../managed-mysql/operations/update.md#change-mysql-config). См. также настройки [Log slow filter](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-filter), [Log slow rate limit](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-rate-limit), [Log slow rate type](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-rate-type), [Log slow sp statements](../../../managed-mysql/concepts/settings-list.md#setting-log-slow-sp-statements) и [Slow query log always write time](../../../managed-mysql/concepts/settings-list.md#setting-slow-query-log-always-write-time).

* `MYSQL_AUDIT` — лог аудита.

    По умолчанию, лог не ведется. Чтобы включить его, измените значение настройки [Audit log](../../../managed-mysql/concepts/settings-list.md#setting-audit-log) при [изменении настроек {{ MY }}](../../../managed-mysql/operations/update.md#change-mysql-config).
