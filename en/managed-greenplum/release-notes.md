# {{ mgp-full-name }} release notes

This section contains {{ mgp-name }} release notes.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## July 2024 {#jule-2024}

* Enabled managing [PXF](./operations/external-tables.md) settings from the API and UI. You can now customize the import and export of data from other DBMSs, S3, and HDFS.

## June 2024 {#jun-2024}

Now you can [create](operations/index.md#pxf) external S3, JDBC, HDFS, and Hive data sources for accessing external tables. {{ tag-con }}

## February 2024 {#feb-2024}

Added the ability to partially [restore a cluster](./operations/cluster-backups.md#restore) from a backup: now you can specify a list of databases or tables to restore. This greatly reduces the recovery time and saves cluster resources if restoring small amounts of data.

## January 2024 {#jan-2024}

* A new version is available: {{ GP }} 6.25. It features [cold storage integration](tutorials/yezzey.md) tools and a [command center](./concepts/command-center.md) by default.
* Now you can [configure PXF](operations/pxf/settings.md) for accessing external tables yourself. Previously, users had to contact support for PXF configuration.

## Q3 2023 {#q3-2023}

* Added support for [incremental backups](concepts/backup.md).
* Added the option of [committing](../billing/concepts/cvos.md) a specific volume of services. All users of the platform can get a discount up to 22% starting from August 1, 2023. The cost of services will not change during the whole period of the offer.
* Added [PXF metrics](metrics.md#managed-greenplum-pxf-metrics) to {{ monitoring-full-name }}.
* Added logs for PXF and the Odyssey connection manager. {{ tag-con }}
* Added [audit logs](at-ref.md) in {{ at-full-name }}.

## Q2 2023 {#q2-2023}

* You can now recover from a backup as of any point in time (Point-in-Time-Recovery, PITR). The feature is enabled by default for new clusters.
* When recovering a cluster, you can now select the number of hosts and segments.
* PXF is updated to version 6.6.0.
* Logs now support PXF-based events.

## Q4 2022 {#q4-2022}

* You can now [expand a cluster](operations/hosts/cluster-expand.md) via the CLI and API by adding new segment hosts with data redistribution across all segments. {{ tag-cli }}
* You can now view cluster backups, recover from backups, and modify public access to the cluster via the CLI. For more information, see [YC CLI Releases](../cli/release-notes.md#version0.100.0). {{ tag-cli }}
* Added the `mdb_toolkit.table_privileges()` function that allows users with the `mdb_admin` role to view the history of granting and revoking privileges in the cluster. For more information, see the [{{ PG }} documentation]({{ pg.docs.org }}/current/infoschema-table-privileges.html).
* Added the `mdb_toolkit.gp_workfile_usage_per_query()` function that allows users with the `mdb_admin` role to view information about active queries from all users. For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-gp_toolkit.html#topic34).
* Improved the algorithm for creating clusters via the wizard: {{ tag-con }}
   * Cluster size cannot exceed `<maximum_host_count> × <maximum_disk_size_per_host>`.
   * You can select groups of dedicated hosts to deploy the cluster.
   * If the amount of data you specify is large, the wizard will prompt you to create a cluster on dedicated hosts.

## Q3 2022 {#q3-2022}

* Added the ability to change the administrator password. {{ tag-cli }}
* You can now [configure the DBMS and the connection pooler in {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex/blob/master/CHANGELOG.md#0770-july-27-2022). {{ tag-tf }}
* Added support for the [postgis]({{gp.docs.vmware}}/5/greenplum-database/ref_guide-extensions-postGIS.html) extension.
* Added the ability to edit clusters and cluster settings via CLI as well as to grant access from {{ data-transfer-full-name }}. For more information, see [YC CLI Releases](../cli/release-notes.md#version0.94.0). {{ tag-cli }}
* Updated the master failover mechanism: a former master is returned to a cluster as a replica and becomes available for another failover right after the first one completes.
* Added the `gp_cancel_backend` function to forcibly stop user queries.
* Added the `gp_terminate_backend` function to forcibly terminate user DB connections.
* Added the ability to expand a cluster with new segment hosts via the API and re-distribute data across all segments.

## Q2 2022 {#q2-2022}

* Added CLI support: `{{ yc-mdb-gp }} cluster` and `{{ yc-mdb-gp }} hosts` commands are available. {{ tag-cli }}
* You can now migrate databases from/to {{ mgp-name }} using {{ data-transfer-full-name }}. See the [documentation](../data-transfer/concepts/index.md#connectivity-matrix) for available targets and sources. This feature is at the [Preview](../overview/concepts/launch-stages.md) stage.
* Added support of the [pgcrypto]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-modules-pgcrypto.html) extension.
* [Optimized](https://github.com/wal-g/wal-g/pull/1257) backup creation through special processing of append-only segments.
* Added the [diskquota]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-modules-diskquota.html) module allowing to limit the disk space taken up by database schemas.
* Implemented automatic switchover to a standby master host via [gpactivatestandby]({{ gp.docs.vmware }}/6/greenplum-database/utility_guide-ref-gpactivatestandby.html).
* Added the `max_statement_mem` and `log_statement` settings that are available when creating or changing a cluster.
* Added the ability to create a cluster with an odd number of segments.
* Limited the minimum storage size on network SSD disks for a master host to 100 GB.
* Optimized the vacuuming process (`VACUUM`):
   * The operation is carried out concurrently across several databases.
   * New tables are processed last.
   * Tables with active locks are excluded.

## Q1 2022 {#q1-2022}

* {{ mgp-full-name }} is now publicly available. It is now subject to a [Service Level Agreement]({{ link-sla-greenplum }}) (SLA) and [pricing rules](pricing/index.md).
* The new {{ GP }} 6.19 version is available with the known bugs fixed.
* You can now hide the contents of external tables.
* You can now change the storage size, including for local SSDs.
* Added `io-optimized` [configurations](concepts/instance-types.md) with an increased ratio of GBs of RAM to the number of vCPUs (8:1).

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}
