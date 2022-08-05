# Migrating databases from {{ mms-name }} to a third-party {{ MS }} cluster

{% note info %}

Data migration from a third-party {{ MS }} cluster is described in [{#T}](../../managed-sqlserver/tutorials/data-migration.md).

{% endnote %}

To migrate a database deployed in a {{ mms-name }} cluster to a third-party {{ MS }} cluster:

1. Remove the load from the source cluster.
1. Switch the source cluster to <q>read-only</q> mode:

   * Using {{ ssms }}:

      1. Open {{ ssms }}.
      1. Open the context menu for the replicated database and select **Properties**.
      1. Select **Database Properties** → **Options** and under **State**, change the value of **Database Read Only** to **True**.

   * Using a query:

      ```sql
      ALTER DATABASE <database name> SET READ_ONLY
      ```

1. [Create a backup](../../managed-sqlserver/operations/cluster-backups.md#create-backup) of the {{ mms-name }} cluster. This is necessary for exporting backups of the cluster database.
1. [Export the backups of the databases](../../managed-sqlserver/operations/cluster-backups.md#objstorage-export) to {{ objstorage-full-name }}.
1. [Download](../../storage/operations/objects/download.md) the backup files from {{ objstorage-full-name }}.
1. Restore the database backups in the third-party {{ MS }} cluster by following the instructions in the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/quickstart-backup-restore-database?view=sql-server-ver16#restore-a-backup).

If you no longer need the {{ mms-name }} cluster, [delete it](../../managed-sqlserver/operations/cluster-delete.md).
