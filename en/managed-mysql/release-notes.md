# {{ mmy-full-name }} releases

This section presents the revision history for {{ mmy-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## Q4 2022 {#q4-2022}

* The status of a host on the **Hosts** page now changes to `READ-ONLY` in the management console if data writes to the host are disabled. {{ tag-con }}
* You can now [move a cluster](operations/update.md#move-cluster) to a different folder using {{ TF }}.
* Added such settings as `Backup retain period days`, `Lock wait timeout`, `Max prepared stmt count`, `Optimizer search depth`, and `Optimizer switch`.

## Q3 2022 {#q3-2022}

* Added a `Free space` plot on the [cluster monitoring](operations/monitoring.md#monitoring-cluster) tab and an `Inode usage` plot on the [host monitoring](operations/monitoring.md#monitoring-hosts) page. {{ tag-con }}
* Added the [Binlog transaction dependency tracking](concepts/settings-list.md#setting-binlog-transaction-dependency-tracking) setting.

## Q2 2022 {#q2-2022}

* In the {{ TF }} configuration files, the `database` and the `user` sections have been deprecated, and the `yandex_mdb_mysql_database` and the `yandex_mdb_mysql_user` resources have been added. {{ tag-tf }}
* Added the [Innodb compression level](concepts/settings-list.md#setting-innodb-compression-level) setting.
* Accelerated the process of restoring replicas from a backup by using WAL-G with subsequent synchronization of data from the master host.
* Fixed the display of long queries on the **Performance diagnostics** tab. {{ tag-con }}

## Q1 2022 {#q1-2022}

* You can now edit the [Innodb strict mode](concepts/settings-list.md#setting-strict-mode), [Max digest length](concepts/settings-list.md#setting-max-digest-length), and [Max sp recursion depth](concepts/settings-list.md#setting-max-sp-recursion-depth) settings. {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}
* Added a section on {{ MY }} cluster performance in {{ TF }}. {{ tag-tf }}
* You can now manage the settings of the performance diagnostics service. {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}
* Updated the master failover mechanism: you can no longer switch to a replica that is lagging far behind or change the master if there is no quorum. The maximum lag for a replica is set by the [Mdb priority choice max lag](concepts/settings-list.md#setting-mdb-priority-choice-max-lag) setting.
* You can now set a priority for selecting a master host if the master changes. {{ tag-con }} {{ tag-cli }}
