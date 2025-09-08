Роль `dataproc.user` предоставляет доступ к веб-интерфейсам компонентов Yandex Data Processing и позволяет создавать задания, а также позволяет просматривать информацию о кластерах управляемых баз данных Yandex Cloud.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [кластерах](../../data-proc/concepts/index.md#resources) Yandex Data Processing и [заданиях](../../data-proc/concepts/jobs.md), а также создавать задания;
* использовать веб-интерфейс для доступа к компонентам Yandex Data Processing;
* просматривать информацию о кластерах [ClickHouse®](../../managed-clickhouse/concepts/index.md), [Greenplum®](../../managed-greenplum/concepts/index.md), [Apache Kafka®](../../managed-kafka/concepts/index.md), [Yandex StoreDoc](../../storedoc/concepts/index.md), [MySQL®](../../managed-mysql/concepts/index.md), [PostgreSQL](../../managed-postgresql/concepts/index.md), [Valkey™](../../managed-redis/concepts/index.md), [OpenSearch](../../managed-opensearch/concepts/index.md) и SQL Server;
* просматривать информацию о хостах кластеров [Greenplum®](../../managed-greenplum/concepts/instance-types.md), [Yandex StoreDoc](../../storedoc/concepts/instance-types.md), [MySQL®](../../managed-mysql/concepts/instance-types.md), [PostgreSQL](../../managed-postgresql/concepts/instance-types.md), [Valkey™](../../managed-redis/concepts/instance-types.md) и SQL Server;
* просматривать информацию о резервных копиях БД кластеров [Greenplum®](../../managed-greenplum/concepts/backup.md), [Yandex StoreDoc](../../storedoc/concepts/backup.md), [MySQL®](../../managed-mysql/concepts/backup.md), [PostgreSQL](../../managed-postgresql/concepts/backup.md), [Valkey™](../../managed-redis/concepts/backup.md) и SQL Server;
* просматривать информацию о пользователях кластеров [Yandex StoreDoc](../../storedoc/concepts/users-and-roles.md), [MySQL®](../../managed-mysql/concepts/user-rights.md), [PostgreSQL](../../managed-postgresql/concepts/roles.md) и SQL Server;
* просматривать информацию о базах данных Yandex StoreDoc, MySQL®, PostgreSQL и SQL Server;
* просматривать информацию об алертах Yandex StoreDoc, MySQL®, PostgreSQL и Valkey™;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®, Yandex StoreDoc, MySQL® и PostgreSQL;
* просматривать информацию о шардах кластеров [Yandex StoreDoc](../../storedoc/concepts/sharding.md) и [Valkey™](../../managed-redis/concepts/sharding.md);
* просматривать логи работы кластеров Greenplum®, Yandex StoreDoc, MySQL®, PostgreSQL, Valkey™ и SQL Server;
* просматривать информацию о квотах сервисов [Managed Service for ClickHouse®](../../managed-clickhouse/concepts/limits.md#mch-quotas), [Managed Service for Apache Kafka®](../../managed-kafka/concepts/limits.md#mkf-quotas), [Managed Service for OpenSearch](../../managed-opensearch/concepts/limits.md#quotas), [Managed Service for Greenplum®](../../managed-greenplum/concepts/limits.md#quotas), [Yandex StoreDoc](../../storedoc/concepts/limits.md#mmg-quotas), [Managed Service for MySQL®](../../managed-mysql/concepts/limits.md#mmy-quotas), [Managed Service for PostgreSQL](../../managed-postgresql/concepts/limits.md#mpg-quotas), [Yandex Managed Service for Valkey™](../../managed-redis/concepts/limits.md#mrd-quotas) и SQL Server;
* просматривать информацию об операциях с ресурсами всех сервисов управляемых баз данных Yandex Cloud;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролями `dataproc.viewer` и `mdb.viewer`.