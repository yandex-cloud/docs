# {{ mpg-full-name }} releases

This section presents the revision history for {{ mpg-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.09.2022 {#01.09.2022}

* On the [cluster monitoring](operations/monitoring.md#monitoring-cluster) tab, added the `Inode usage`, `Memory usage`, and `Free space` plots.

## 01.08.2022 {#01.08.2022}

* {{ PG }} 10 is [no longer](https://www.postgresql.org/about/news/postgresql-143-137-1211-1116-and-1021-released-2449/) supported. As of August 15, you can no longer create new clusters of this version, and an automatic cluster update is scheduled from September 1 as part of the maintenance window. For information about updating a cluster on your own, see [{#T}](operations/cluster-version-update.md).
* You can now create a database from a template with the CLI and {{ TF }}. {{ tag-cli }} {{ tag-tf }}
* Added support for the `pg_cron` [extension](operations/extensions/pg_cron.md).
* Installed an [update to version 14.4]({{ pg.docs.org }}/release/14.4/) correcting the index corruption issues.

## 01.07.2022 {#01.07.2022}

* Added the `mdb_monitor` role that includes the privileges of the [pg_monitor](https://www.postgresql.org/docs/10/default-roles.html) system role. For more information, see [Assigning {{ PG }} roles](concepts/roles.md#mdb-monitor).
* In the {{ TF }} configuration files, the `database` and the `user` sections have been deprecated, and the `yandex_mdb_postgresql_database` and the `yandex_mdb_postgresql_user` resources have been added. {{ tag-tf }}
* Added the ability to upgrade versions from 13 to 14.
* Clusters for 1C are available under versions 13 and 14. {{ tag-con }}
* [Odyssey 1.3](https://www.postgresql.org/about/news/odyssey-13-released-2476/) is now available with support for prepared statements in transaction pooling mode. You can use the `pool_reserve_prepared_statement` setting to activate a pool of prepared database statements where Odyssey will prepare session statements as needed.

## 01.06.2022 {#01.06.2022}

* [Updates](https://www.postgresql.org/about/news/postgresql-143-137-1211-1116-and-1021-released-2449/) from versions 14.3, 13.7, 12.11, 11.16, and 10.21 were installed.

## 01.05.2022 {#01.05.2022}

* Added the `max_logical_replication_workers` and `max_replication_slots` settings.

## 01.04.2022 {#01.04.2022}

* Added [{{ PG }} extensions](operations/extensions/cluster-extensions.md) such as `pgcompacttable`, `clickhouse_fdw`, and `orafce`.
* Added the ability to create a new database from a template. {{ tag-con }}
