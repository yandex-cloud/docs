# {{ mpg-full-name }} releases

This section covers the revision history for {{ mpg-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## Q2 2023 {#q2-2023}

* You can now export raw data on performance diagnostics using the [ListRawSessionStates](api-ref/grpc/perf_diag_service.md#ListRawSessionStates) and [ListRawStatements](api-ref/grpc/perf_diag_service.md#ListRawStatements) API methods.
* Added the `Session duration timeout` setting that controls the lifetime of the longest active session or transaction. The default value is 12 hours.

## Q4 2022 {#q4-2022}

* Added support for {{ PG }} version 15.

   Key changes in the new version:

   * Added support for the `SQL MERGE` command that allows performing an `INSERT`, `UPDATE`, or `DELETE` action depending on the conditions.
   * You can now specify column lists and row filter conditions. This allows selective publication of table contents within logical replication publications.
   * You can now specify [ICU]({{ pg.docs.org }}/15/locale.html#id-1.6.11.3.7) as default for databases.
   * Performance improvements, in particular, for in-memory and on-disk sorting.

   To learn how to update a cluster, see [{#T}](operations/cluster-version-update.md).

   To learn more about new features and enhancements in {{ PG }} v15, see the [{{ PG }} documentation]({{ pg.docs.org }}/release/15.0/).

* Added support for the [pgaudit](https://www.pgaudit.org/) and [pg_prewarm]({{ pg-docs }}/pgprewarm.html) extensions.
* You can now restore a cluster from backup in a different folder using any interface.

## Q3 2022 {#q3-2022}

* Added the `Inode usage`, `Memory usage`, and `Free space` charts to the [cluster monitoring](operations/monitoring.md#monitoring-cluster) tab. {{ tag-con }}
* {{ PG }} 10 is [no longer](https://www.postgresql.org/about/news/postgresql-143-137-1211-1116-and-1021-released-2449/) supported. As of August 15, you can no longer create new clusters of this version, and an automatic cluster update is scheduled from September 1 as part of the maintenance window. For information about updating a cluster on your own, see [{#T}](operations/cluster-version-update.md).
* You can now create a database from a template with the CLI and {{ TF }}. {{ tag-cli }} {{ tag-tf }}
* Added support for the `pg_cron` [extension](operations/extensions/pg_cron.md).
* Installed an [update to version 14.4]({{ pg.docs.org }}/release/14.4/) correcting the index corruption issues.

## Q2 2022 {#q2-2022}

* [Updates](https://www.postgresql.org/about/news/postgresql-143-137-1211-1116-and-1021-released-2449/) from versions 14.3, 13.7, 12.11, 11.16, and 10.21 were installed.
* Clusters for 1C are available under versions 13 and 14. {{ tag-con }}
* Added the ability to upgrade versions from 13 to 14.
* Added the `mdb_monitor` role that includes the privileges of the [pg_monitor](https://www.postgresql.org/docs/10/default-roles.html) system role. For more information, see [Assigning {{ PG }} roles](concepts/roles.md#mdb-monitor).
* In the {{ TF }} configuration files, the `database` and the `user` sections have been deprecated, and the `yandex_mdb_postgresql_database` and the `yandex_mdb_postgresql_user` resources have been added. {{ tag-tf }}
* [Odyssey 1.3](https://www.postgresql.org/about/news/odyssey-13-released-2476/) is now available with support for prepared statements in transaction pooling mode. You can use the `pool_reserve_prepared_statement` setting to activate a pool of prepared database statements where Odyssey will prepare session statements as needed.
* Added the `max_logical_replication_workers` and `max_replication_slots` settings.

## Q1 2022 {#q1-2022}

* Added [{{ PG }} extensions](operations/extensions/cluster-extensions.md), such as `pgcompacttable`, `clickhouse_fdw`, and `orafce`.
* Added the ability to create a new database from a template. {{ tag-con }}
