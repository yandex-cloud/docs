The `dataproc.user` role grants access to the Yandex Data Processing component web interfaces and enables creating jobs and viewing info on Yandex Cloud managed DB clusters.

{% cut "Users with this role can:" %}

* View info on Yandex Data Processing [clusters](../../data-proc/concepts/index.md#resources) and [jobs](../../data-proc/concepts/jobs.md), as well as create jobs.
* Use the web interface to access the Yandex Data Processing components.
* View info on [ClickHouse®](../../managed-clickhouse/concepts/index.md), [Greenplum®](../../managed-greenplum/concepts/index.md), [Apache Kafka®](../../managed-kafka/concepts/index.md), [Yandex StoreDoc](../../storedoc/concepts/index.md), [MySQL®](../../managed-mysql/concepts/index.md), [PostgreSQL](../../managed-postgresql/concepts/index.md), [Valkey™](../../managed-redis/concepts/index.md), [OpenSearch](../../managed-opensearch/concepts/index.md), and SQL Server clusters.
* View info on [Greenplum®](../../managed-greenplum/concepts/instance-types.md), [Yandex StoreDoc](../../storedoc/concepts/instance-types.md), [MySQL®](../../managed-mysql/concepts/instance-types.md), [PostgreSQL](../../managed-postgresql/concepts/instance-types.md), [Valkey™](../../managed-redis/concepts/instance-types.md), and SQL Server cluster hosts.
* View info on database backups for [Greenplum®](../../managed-greenplum/concepts/backup.md), [Yandex StoreDoc](../../storedoc/concepts/backup.md), [MySQL®](../../managed-mysql/concepts/backup.md), [PostgreSQL](../../managed-postgresql/concepts/backup.md), [Valkey™](../../managed-redis/concepts/backup.md), and SQL Server clusters.
* View info on [Yandex StoreDoc](../../storedoc/concepts/users-and-roles.md), [MySQL®](../../managed-mysql/concepts/user-rights.md), [PostgreSQL](../../managed-postgresql/concepts/roles.md), and SQL Server cluster users.
* View info on Yandex StoreDoc, MySQL®, PostgreSQL, and SQL Server DBs.
* View info on Yandex StoreDoc, MySQL®, PostgreSQL, and Valkey™ alerts.
* View info on the results of Greenplum®, Yandex StoreDoc, MySQL®, and PostgreSQL cluster performance diagnostics.
* View info on [Yandex StoreDoc](../../storedoc/concepts/sharding.md) and [Valkey™](../../managed-redis/concepts/sharding.md) cluster shards.
* View Greenplum®, Yandex StoreDoc, MySQL®, PostgreSQL, Valkey™, and SQL Server cluster logs.
* View info on [Managed Service for ClickHouse®](../../managed-clickhouse/concepts/limits.md#mch-quotas), [Managed Service for Apache Kafka®](../../managed-kafka/concepts/limits.md#mkf-quotas), [Managed Service for OpenSearch](../../managed-opensearch/concepts/limits.md#quotas), [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/concepts/limits.md#quotas), [Yandex StoreDoc](../../storedoc/concepts/limits.md#mmg-quotas), [Managed Service for MySQL®](../../managed-mysql/concepts/limits.md#mmy-quotas), [Managed Service for PostgreSQL](../../managed-postgresql/concepts/limits.md#mpg-quotas), [Yandex Managed Service for Valkey™](../../managed-redis/concepts/limits.md#mrd-quotas), and SQL Server quotas.
* View info on resource operations for all Yandex Cloud managed DB services.
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role includes the `dataproc.viewer` and `mdb.viewer` permissions.