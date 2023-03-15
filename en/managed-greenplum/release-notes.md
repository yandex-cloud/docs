# {{ mgp-full-name }} releases

This section covers the revision history for {{ mgp-name }}.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## Q4 2022 {#q4-2022}

* You can now [expand a cluster](operations/hosts/cluster-expand.md) via the CLI and API by adding new segment hosts with data redistribution across all segments. {{ tag-cli }} {{ tag-api }}
* You can now view cluster backups, recover from backups, and modify public access to the cluster via the CLI. For more information, see [YC CLI Releases](../cli/release-notes.md#version0.100.0). {{ tag-cli }}
* Added the `mdb_toolkit.table_privileges()` function that allows users with the `mdb_admin` role to view the history of granting and revoking privileges in the cluster. For more information, see the [{{ PG }} documentation]({{ pg.docs.org }}/current/infoschema-table-privileges.html).
* Added the `mdb_toolkit.gp_workfile_usage_per_query()` function that allows users with the `mdb_admin` role to view information about active queries from all users. For more information, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-gp_toolkit.html#topic34).
* Improved the algorithm for creating clusters via the wizard: {{ tag-con }}
   * The cluster size cannot exceed `<maximum host count> × <maximum disk size per host>`.
   * You can select groups of dedicated hosts to deploy the cluster.
   * If the amount of data you specify is large, the wizard will prompt you to create a cluster on dedicated hosts.

## Q3 2022 {#q3-2022}

* Added the ability to change the administrator password. {{ tag-cli }} {{ tag-tf }}
* Added the ability to [configure the DBMS and the connection pooler in {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex/blob/master/CHANGELOG.md#0770-july-27-2022). {{ tag-tf }}
* Added support for the [postgis](https://docs.vmware.com/en/VMware-Tanzu-Greenplum/5/greenplum-database/GUID-ref_guide-extensions-postGIS.html) extension.
* Added the ability to edit clusters and cluster settings via CLI as well as to grant access from {{ data-transfer-full-name }}. For more information, see [YC CLI Releases](../cli/release-notes.md#version0.94.0). {{ tag-cli }}
* Updated the master failover mechanism: a former master is returned to a cluster as a replica and becomes available for another failover right after the first one completes.
* Added the `gp_cancel_backend` function to forcibly stop user queries.
* Added the `gp_terminate_backend` function to forcibly terminate user DB connections.
* Added the ability to expand a cluster with new segment hosts via the API and re-distribute data across all segments.

## Q2 2022 {#q2-2022}

* Added CLI support: `{{ yc-mdb-gp }} cluster` and `{{ yc-mdb-gp }} hosts` commands are available. {{ tag-cli }}
* You can now migrate databases from/to {{ mgp-name }} using {{ data-transfer-full-name }}. See the [documentation](../data-transfer/concepts/index.md#connectivity-matrix) for available targets and sources. This feature is at the [Preview](../data-transfer/concepts/index.md#greenplum) stage.
* Added support for the [pgcrypto](https://gpdb.docs.pivotal.io/6-9/ref_guide/modules/pgcrypto.html) extension.
* [Optimized](https://github.com/wal-g/wal-g/pull/1257) backup creation through special processing of append-only segments.
* Added the [diskquota](https://gpdb.docs.pivotal.io/6-19/ref_guide/modules/diskquota.html) module that enables you to limit the amount of disk space used by schemas in a database.
* Implemented automatic switchover to a standby master host using the [gpactivatestandby](https://gpdb.docs.pivotal.io/6-3/utility_guide/ref/gpactivatestandby.html) utility.
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
