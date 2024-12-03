Роль `dataproc.admin` позволяет управлять кластерами Yandex Data Processing, запускать задания и просматривать информацию о них, а также предоставляет доступ к веб-интерфейсам компонентов сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [кластерах](../../data-proc/concepts/index.md#resources) Yandex Data Processing, а также создавать, изменять, запускать, останавливать и удалять такие кластеры;
* просматривать информацию о [заданиях](../../data-proc/concepts/jobs.md), а также создавать задания;
* использовать веб-интерфейс для доступа к компонентам Yandex Data Processing;
* просматривать информацию о кластерах [ClickHouse®](../../managed-clickhouse/concepts/index.md), [Greenplum®](../../managed-greenplum/concepts/index.md), [Apache Kafka®](../../managed-kafka/concepts/index.md), [MongoDB](../../managed-mongodb/concepts/index.md), [MySQL®](../../managed-mysql/concepts/index.md), [PostgreSQL](../../managed-postgresql/concepts/index.md), [Redis](../../managed-redis/concepts/index.md), [OpenSearch](../../managed-opensearch/concepts/index.md) и SQL Server;
* просматривать информацию о хостах кластеров [Greenplum®](../../managed-greenplum/concepts/instance-types.md), [MongoDB](../../managed-mongodb/concepts/instance-types.md), [MySQL®](../../managed-mysql/concepts/instance-types.md), [PostgreSQL](../../managed-postgresql/concepts/instance-types.md), [Redis](../../managed-redis/concepts/instance-types.md) и SQL Server;
* просматривать информацию о резервных копиях БД кластеров [Greenplum®](../../managed-greenplum/concepts/backup.md), [MongoDB](../../managed-mongodb/concepts/backup.md), [MySQL®](../../managed-mysql/concepts/backup.md), [PostgreSQL](../../managed-postgresql/concepts/backup.md), [Redis](../../managed-redis/concepts/backup.md) и SQL Server;
* просматривать информацию о пользователях кластеров [MongoDB](../../managed-mongodb/concepts/users-and-roles.md), [MySQL®](../../managed-mysql/concepts/user-rights.md), [PostgreSQL](../../managed-postgresql/concepts/roles.md) и SQL Server;
* просматривать информацию о базах данных MongoDB, MySQL®, PostgreSQL и SQL Server;
* просматривать информацию об алертах MongoDB, MySQL®, PostgreSQL и Redis;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®, MongoDB, MySQL® и PostgreSQL;
* просматривать информацию о шардах кластеров [MongoDB](../../managed-mongodb/concepts/sharding.md) и [Redis](../../managed-redis/concepts/sharding.md);
* просматривать логи работы кластеров Greenplum®, MongoDB, MySQL®, PostgreSQL, Redis и SQL Server;
* просматривать информацию о квотах сервисов [Managed Service for ClickHouse®](../../managed-clickhouse/concepts/limits.md#mch-quotas), [Managed Service for Apache Kafka®](../../managed-kafka/concepts/limits.md#mkf-quotas), [Managed Service for OpenSearch](../../managed-opensearch/concepts/limits.md#quotas), [Managed Service for Greenplum®](../../managed-greenplum/concepts/limits.md#quotas), [Managed Service for MongoDB](../../managed-mongodb/concepts/limits.md#mmg-quotas), [Managed Service for MySQL®](../../managed-mysql/concepts/limits.md#mmy-quotas), [Managed Service for PostgreSQL](../../managed-postgresql/concepts/limits.md#mpg-quotas), [Managed Service for Redis](../../managed-redis/concepts/limits.md#mrd-quotas) и SQL Server;
* просматривать информацию об операциях с ресурсами всех сервисов управляемых баз данных Yandex Cloud;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `dataproc.editor`.