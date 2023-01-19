# {{ mmy-full-name }} releases

This section presents the revision history for {{ mmy-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.09.2022 {#01.09.2022}

* Added a `Free space` plot on the [cluster monitoring](operations/monitoring.md#monitoring-cluster) tab and an `Inode usage` plot on the [host monitoring](operations/monitoring.md#monitoring-hosts) page. {{ tag-con }}

## 01.08.2022 {#01.08.2022}

* Added the `binlog_transaction_dependency_tracking` setting.

## 01.07.2022 {#01.07.2022}

* In the {{ TF }} configuration files, the `database` and the `user` sections have been deprecated, and the `yandex_mdb_mysql_database` and the `yandex_mdb_mysql_user` resources have been added. {{ tag-tf }}

## 01.06.2022 {#01.06.2022}

* Added the `innodb_compression_level` setting.
* Accelerated the process of restoring replicas from a backup by using WAL-G with subsequent synchronization of data from the master host.

## 01.05.2022 {#01.05.2022}

* Fixed the display of long queries on the **Performance diagnostics** tab. {{ tag-con }}

## 20.04.2022 {#20.04.2022}

* You can now change the `max_sp_recursion_depth` setting that defines the maximum number of recursive invocations of a stored procedure. Defaults to `0`, meaning that recursive invocations are completely disabled. The maximum value is `255`. {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}
* Added a section on {{ MY }} cluster performance in {{ TF }}. {{ tag-tf }}

## 13.04.2022 {#13.04.2022}

* You can now manage the settings of the performance diagnostics service. {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}
* Updated the master failover mechanism: you can no longer switch to a replica that is lagging far behind or change the master if there is no quorum. The maximum lag for a replica is set by the `mdb_priority_choice_max_lag` setting.

## 01.04.2022 {#01.04.2022}

* You can now change the `innodb_strict_mode` setting.
* You can now change the `max_digest_length` setting. The setting applies when restarting a cluster.
* You can now set a priority for selecting a master host if the master changes. {{ tag-con }} {{ tag-cli }}
