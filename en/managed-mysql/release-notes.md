---
title: '{{ mmy-full-name }} release notes'
description: This section contains {{ mmy-name }} release notes.
---

# {{ mmy-full-name }} release notes

## April 2025 {#apr-2025}

Added [integration with {{ connection-manager-name }}](operations/update.md#conn-man). A {{ connection-manager-name }} connection is now created for all new clusters automatically.

## October 2024 {#oct-2024}

Now you can [specify a retention period for your automatic backups](operations/cluster-backups.md#set-backup-retain).


## September 2024 {#sep-2024}

Added the **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** option to cluster settings. It enables you to run YQL queries from [{{ yq-full-name }}](../query/concepts/index.md) to a {{ mgp-name }} database.


## May 2024 {#may-2024}

* New {{ MY }} versions are now available: [5.7.44](https://dev.mysql.com/doc/relnotes/mysql/5.7/en/news-5-7-44.html) and [8.0.35](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-35.html).

## Q4 2023 {#q4-2023}

* A new version is out: {{ MY }} [8.0.31](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-31.html).

## Q2 2023 {#q2-2023}

* New {{ MY }} versions are now available: [5.7.39](https://dev.mysql.com/doc/relnotes/mysql/5.7/en/news-5-7-39.html) and [8.0.30](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-30.html).
* {{ MY }} 5.7 now supports analyzing queries using `query_response_time_stats`. For more information, see the [Percona documentation](https://docs.percona.com/percona-server/5.7/diagnostics/response_time_distribution.html).
* Added new global user permissions: `FLUSH_OPTIMIZER_COSTS` and `SHOW_ROUTINE`.

## Q4 2022 {#q4-2022}

* The status of a host on the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** page in the management console now changes to `READ-ONLY` if data writes to the host are disabled.
* You can now [move a cluster](operations/update.md#move-cluster) to a different folder using {{ TF }}.
* Added new DBMS settings:

  * `Backup retain period days`
  * [Lock wait timeout](./concepts/settings-list.md#setting-lock-wait-timeout)
  * [Max prepared stmt count](./concepts/settings-list.md#setting-max-prepared-stmt-count)
  * [Optimizer search depth](./concepts/settings-list.md#setting-optimizer-search-depth)
  * [Optimizer switch](./concepts/settings-list.md#setting-optimizer-switch)

## Q3 2022 {#q3-2022}

* Added the `Free space` plot to the [cluster monitoring](operations/monitoring.md#monitoring-cluster) tab and the `Inode usage` plot to the [host monitoring](operations/monitoring.md#monitoring-hosts) page.
* Added the [Binlog transaction dependency tracking](concepts/settings-list.md#setting-binlog-transaction-dependency-tracking) setting.

## Q2 2022 {#q2-2022}

* Removed the `database` and `user` sections in the {{ TF }} configuration files and added the `yandex_mdb_mysql_database` and `yandex_mdb_mysql_user` resources instead.
* Added the [Innodb compression level](concepts/settings-list.md#setting-innodb-compression-level) setting.
* Accelerated the process of restoring replicas from a backup by using WAL-G with subsequent synchronization of data from the master host.
* Fixed the display of long queries on the **{{ ui-key.yacloud.mysql.cluster.switch_diagnostics }}** tab.

## Q1 2022 {#q1-2022}

* You can now edit the [Innodb strict mode](concepts/settings-list.md#setting-strict-mode), [Max digest length](concepts/settings-list.md#setting-max-digest-length), and [Max sp recursion depth](concepts/settings-list.md#setting-max-sp-recursion-depth) settings.
* Added a section for diagnostics of {{ MY }} cluster performance in {{ TF }}.
* You can now manage the settings of the performance diagnostics service.
* Updated the master failover mechanism: you can no longer switch to a replica that is lagging far behind or change the master if there is no quorum. The maximum lag for a replica is set by the [Mdb priority choice max lag](concepts/settings-list.md#setting-mdb-priority-choice-max-lag) setting.
* You can now set a priority for selecting a master host if the master changes.
