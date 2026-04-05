---
title: Table and system folder vacuuming in {{ mgp-name }}
description: In this guide, you will learn why you need table and system folder vacuuming and how it is done in {{ mgp-full-name }}.
---

# Table and system folder vacuuming in {{ mgp-name }}

In {{ mgp-name }}, custom tables and the system folder are vacuumed [automatically](#autovacuum) in background mode. If automatic vaccuming is not enough, [manual vacuuming](#vacuum-recomendation) may be required.

## Table vacuuming {#tables}

When a transaction is written to a database, it gets a unique ID, `XID` (a 32-bit counter). The database uses this ID to figure out which transaction started earlier, which one later, and which changes are visible to the current transaction. When the `XID` value overflows, the counter gets reset and restarts the transaction count (wraparound).

When you run the `UPDATE` and `DELETE` operations, old versions of rows get marked as dead tuples but are not physically deleted from the table to keep them visible to transactions that started earlier. As a result, tables start taking up more disk space, and database queries become slower due to higher amount of data processing.

To free up the space taken by dead tuples, the `VACUUM` and `VACUUM FULL` commands are used. These commands also freeze `XID` in rows created by completed transactions. This is done so the rows can remain visible even if `XID` overflows and the IDs of completed transactions are used for new ones.

By default, {{ GP }} uses [heap tables](tables.md), the standard type of {{ PG }} tables. For them, the `VACUUM` and `VACUUM FULL` commands work as follows:

* `VACUUM` marks deleted and obsolete rows in the table and its indexes as free space available for reuse. However, the table does not become smaller on the disk in terms of physical size.
* `VACUUM FULL` creates a new table, copies all rows to it, except for deleted and obsolete ones, and creates new indexes for the table. The new table then replaces the original one. `VACUUM FULL` reduces the table’s physical size on the disk and cleans the indexes of obsolete rows. Throughout the operation, the `ACCESS EXCLUSIVE` lock must be on.

{% note tip %}

`VACUUM FULL` blocks access to the table and requires extra space on the disk to create a temporary table, so we do not recommend using this operation often. To avoid a lock, you can create a new table with relevant rows via `CREATE TABLE ... AS` and then delete the original one.

{% endnote %}

[Learn more about vacuuming in {{ PG }}](https://www.postgresql.org/docs/18/routine-vacuuming.html).

### Information about unfrozen XIDs {#relfrozenxid}

{{ PG }} stores information about unfrozen `XID` in the `pg_class` and `pg_database` tables:

* The oldest unfrozen `XID` for each table is in the `pg_class` table's `relfrozenxid` column.
* The oldest unfrozen `XID` for each database is in the `pg_database` table's `datfrozenxid` column.

These measures are updated after you run `VACUUM` or `VACUUM FULL`.

[Learn more about wraparound in {{ PG }}](https://www.postgresql.org/docs/18/routine-vacuuming.html#VACUUM-FOR-WRAPAROUND).

### AO and AOCO table vacuuming {#ao-tables}

[AO and AOCO tables](tables.md) are append-optimized tables. These tables store data in segment files, which consist of blocks. New rows are added to the end of the segment files, and the old ones are marked as dead tuples and not overwritten.

For AO and AOCO tables, the `VACUUM` and `VACUUM FULL` commands work as follows:

* `VACUUM` creates a new file for each segment and transfers visible rows to it. The number of blocks on the disk remains the same. During the deletion of the old file and the activation of the new one, the table remains locked.
* `VACUUM FULL` creates a new file for each segment and transfers visible rows to it, redistributing them among blocks. This reduces the number of blocks on the disk. Throughout the operation, the table remains locked.

[Learn more about AO and AOCO table vacuuming](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/ref_guide-sql_commands-VACUUM.html).

### {{ YZ }} table vacuuming {#yezzey}

[{{ YZ }}](../operations/extensions/yezzey.md) is a {{ GP }} extension that allows storing AO and AOCO tables in a [hybrid storage](hybrid-storage.md).

For AO and AOCO tables in a hybrid storage, the `VACUUM` and `VACUUM FULL` operations are performed the same way as for similar tables in the cluster storage.

## System folder vacuuming {#catalog}

In {{ GP }}, the system folder is a set of system tables in the `pg_catalog` schema. System tables store metadata about tables, columns, and other database objects. Over time, they bloat as a result of creating and deleting DDL objects, especially if there is a massive ingestion of data, e.g., using [{{ maf-name }}](../../managed-airflow/index.yaml). So you need `VACUUM` and `VACUUM FULL` for the system folder as well.

When performing `VACUUM FULL` of the system folder, we recommend switching the database to the limited access mode, e.g., by denying connections based on [user authentication rules](../operations/user-auth-rules.md), to prevent users from interacting with the folder. After vacuuming is complete, you can switch the database back to normal mode.

{% note warning %}

Interrupting the `VACUUM FULL` operation can damage the folder on the segment.

{% endnote %}

## Table and index state monitoring {#monitoring}

You can view the system folder bloat statistics and the custom table vacuuming statistics in the [management console]({{ link-console-main }}), the **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** tab of the cluster management page, or in [{{ monitoring-full-name }}](../../monitoring/concepts/index.md), on charts under **Background activities**.

[Learn more about monitoring the {{ mgp-name }}](../operations/monitoring.md#monitoring-cluster) cluster state.

## Automatic vacuuming {#autovacuum}

In {{ mgp-name }}, custom tables and the system folder are vacuumed (`VACUUM`) automatically in background mode. However, we recommend you to monitor your tables and indexes using the [bloat charts](../operations/monitoring.md#monitoring-cluster) and to vacuum [manually](#vacuum-recomendation), if automatic vacuuming is not enough to keep the tables from bloating.

[Learn more about automatic vacuuming](maintenance.md#custom-table-vacuum).

## Scheduling and conducting manual vacuuming {#vacuum-recomendation}

The `VACUUM` and `VACUUM FULL` operations for AO and AOCO tables, as well as `VACUUM FULL` for heap tables, require exclusive table locking (`ACCESS EXCLUSIVE`). If the database has incomplete transactions locking the table, a conflict of locks occurs. This temporarily suspends operations with the table and system folder.

To avoid failures, follow these recommendations:

  * Vacuum individual tables instead of the whole database.
  * Adjust vacuuming frequency for each table individually.
  * Limit the vacuuming time.
  * Control active connections and do not allow incomplete, frozen transactions.