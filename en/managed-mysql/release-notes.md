---
title: '{{ mmy-full-name }} release notes'
description: This section contains {{ mmy-name }} release notes.
---

# {{ mmy-full-name }} release notes

## November 2025 {#nov-2025}

Added the `managed-mysql.restorer` role, which allows restoring clusters from backups. To learn more, see [Access management](security/index.md#managed-mysql-restorer).

## October 2025 {#oct-2025}

* Increased the binary log size for clusters with large disks for quicker recovery of large clusters in case of failure.
* Added new [host classes](concepts/instance-types.md) on AMD Zen 4 and AMD Zen 4 HighFreq platforms.

## September 2025 {#sep-2025}

* A new major {{ MY }} version is out: [8.4.6](https://docs.percona.com/percona-server/8.4/release-notes/8.4.6-6.html). Upgrade is not yet available, it will be supported later.
* New {{ MY }} minor versions are out: [5.7.44-53](https://docs.percona.com/percona-server/5.7/release-notes/5.7.44-53.html) and [8.0.41](https://docs.percona.com/percona-server/8.0/release-notes/8.0.41-32.html).
* Now you can configure incremental [automatic expansion of your cluster storage](concepts/storage.md#disk-size-autoscaling). Users can set the disk storage usage threshold and the maximum disk size. Upon reaching the threshold, the disk size will automatically increase in fixed increments up to its maximum.
* Added a new [administrative privilege](./concepts/settings-list.md#setting-administrative-privileges): `mdb_admin`.


## July 2025 {#jul-2025}

Now you can [encrypt storage disks](concepts/storage.md#disk-encryption) with a custom KMS key when creating a cluster and restoring it from a backup.


## April 2025 {#apr-2025}

Added [integration with {{ connection-manager-name }}](operations/update.md#conn-man). Now, a connection in {{ connection-manager-name }} is automatically created for all new clusters.

## October 2024 {#oct-2024}

You can now [specify a retention period for your automatic backups](operations/cluster-backups.md#set-backup-retain).


## September 2024 {#sep-2024}

Added the **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** option to cluster settings. It enables you to run YQL queries from [{{ yq-full-name }}](../query/concepts/index.md) to a {{ mgp-name }} database.


## May 2024 {#may-2024}

* New {{ MY }} versions are out: [5.7.44](https://dev.mysql.com/doc/relnotes/mysql/5.7/en/news-5-7-44.html) and [8.0.35](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-35.html).

## Q4 2023 {#q4-2023}

* A new {{ MY }} version is out: [8.0.31](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-31.html).

## Q2 2023 {#q2-2023}

* New {{ MY }} versions are out: [5.7.39](https://dev.mysql.com/doc/relnotes/mysql/5.7/en/news-5-7-39.html) and [8.0.30](https://dev.mysql.com/doc/relnotes/mysql/8.0/en/news-8-0-30.html).
* {{ MY }} 5.7 now supports analyzing queries using `query_response_time_stats`. For more information, see [this Percona article](https://docs.percona.com/percona-server/5.7/diagnostics/response_time_distribution.html).
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

* Added the `Free space` chart to the [cluster monitoring](operations/monitoring.md#monitoring-cluster) tab and the `Inode usage` chart to the [host monitoring](operations/monitoring.md#monitoring-hosts) page.
* Added the [Binlog transaction dependency tracking](concepts/settings-list.md#setting-binlog-transaction-dependency-tracking) setting.

## Q2 2022 {#q2-2022}

* Removed the `database` and `user` sections in the {{ TF }} configuration files and added the `yandex_mdb_mysql_database` and `yandex_mdb_mysql_user` resources instead.
* Added the [Innodb compression level](concepts/settings-list.md#setting-innodb-compression-level) setting.
* Accelerated replica restoration from a backup through WAL-G with subsequent synchronization of data from the master host.
* Fixed the display of long queries on the **{{ ui-key.yacloud.mysql.cluster.switch_diagnostics }}** tab.

## Q1 2022 {#q1-2022}

* You can now edit the [Innodb strict mode](concepts/settings-list.md#setting-strict-mode), [Max digest length](concepts/settings-list.md#setting-max-digest-length), and [Max sp recursion depth](concepts/settings-list.md#setting-max-sp-recursion-depth) settings.
* Added a section for diagnostics of {{ MY }} cluster performance in {{ TF }}.
* You can now manage the settings of the performance diagnostics service.
* Enhanced master failover logic: the system now prevents failover to a significantly lagging replica or when the quorum is missing. The maximum lag for a replica is defined by the [Mdb priority choice max lag](concepts/settings-list.md#setting-mdb-priority-choice-max-lag) setting.
* You can now set the master host failover priority.
