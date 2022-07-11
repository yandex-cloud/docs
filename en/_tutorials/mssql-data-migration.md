You can migrate a {{ MS }} cluster to a {{ mms-short-name }} cluster using a [logical import](#snapshot) of a database snapshot or [transactional replication](#replication). Both methods have their limitations:

- Migrating with logical import:
  - In the process of creating a snapshot, table locks are used.
  - The snapshot import process is relatively slow compared to transactional replication.
  - Data in the target cluster is only relevant when the snapshot is created and might become outdated.
  - This method can't be used for a database with logical inconsistencies: for example, if dependencies or tables referenced by views have been deleted from it. If this limitation applies to you, then you can create a [database snapshot]({{ ms.docs }}/sql/relational-databases/databases/create-a-database-snapshot-transact-sql) and send it to the [support]({{ link-console-support }}) so our specialists can restore the database from the snapshot manually.

- Migrating with transactional replication:
  - Unidirectional replication: Changes on the target cluster aren't replicated to the source cluster.
  - You can't change the target cluster's schema while publishing DB objects.

## Migrating with logical import {#snapshot}

To migrate data from a {{ MS }} cluster to a {{ mms-short-name }} cluster, you can use [sqlpackage]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-download). It will create a snapshot of your {{ MS }} database, including a schema and data from tables and other objects, and then it will import the snapshot to the {{ mms-short-name }} cluster.

To migrate a database from the source {{ MS }} cluster to the target {{ mms-name }} cluster with logical import:

1. [Configure the source cluster](#configure-source).
1. [Configure the target cluster](#configure-target).
1. [Create a snapshot of the database from the source cluster](#create-snapshot).
1. [Import the snapshot of the database to the target cluster](#import-snapshot).

### Before you start {#before-you-begin-snapshot}

1. [Create a {{ mms-name }} cluster](../managed-sqlserver/operations/cluster-create.md). In this case:

   - The host master of the target cluster must be publicly available so that sqlpackage can connect to it.
   - The target cluster must run the same **SQL Server Collation** as the source cluster.

1. Check that you can [connect to the target cluster](../managed-sqlserver/operations/connect.md#connection-ide) and the source cluster using {{ ssms }}.

1. [Download and set up the sqlpackage programm]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-download).

### Set up the source cluster {#configure-source}

1. From the source database, delete all the users that use **Windows Authentication**, leaving only the users with **SQL Server Authentication**.

1. Grant the `sa` user the `db_owner` role for the migrated database, using the query:

    ```sql
    ALTER AUTHORIZATION ON DATABASE::<database name> TO sa;
    ```

1. Enable the **Service Broker** component in the source database and switch its recovery model to **Full**:
   1. Open {{ ssms }}.
   1. Open the context menu of the desired database and select **Properties**.
   1. Click the **Options** tab.
   1. Change the value of the **Recovery model** option to **Full**.
   1. Under **Service Broker**, change the **Broker Enabled** value to **True**.

### Configure the target cluster {#configure-target}

[Add](../managed-sqlserver/operations/cluster-users.md#adduser)) all the users that exist in the source database, with the same names and passwords, to the target {{ mms-name }} cluster.

### Create a database snapshot {#create-snapshot}

To export the database to a .dacpac file, run PowerShell, navigate to the directory with sqlpackage, and run the command:

   ```powershell
   .\sqlpackage.exe `
       /a:Extract `
       /ssn:"{{ MS }} source cluster address>" `
       /sdn:"<database name>" `
       /tf:"<local path to the .dacpac file>" `
       /p:ExtractAllTableData=True `
       /p:ExtractReferencedServerScopedElements=False
   ```

{% note info %}

To export only the table schema without the data, remove the `/p:ExtractAllTableData=False` parameter from the command. If you need to export only certain tables, specify the `/p:TableData=<table name>` parameter (you can specify this parameter multiple times).

{% endnote %}

For more information, see the [{{ MS }} documentation]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-extract).

### Import a snapshot of the database to the target {#import-snapshot} cluster

To import the snapshot to the {{ mms-name }} cluster, run PowerShell, go to the directory with sqlpackage, and run the command:

   ```powershell
   .\sqlpackage.exe `
       /a:Publish `
       /sf:"<local path to the .dacpac file>" `
       /tsn:"<FQDN of the master host in the {{ mms-name }} cluster>,1433" `
       /tdn:"<target database name>" `
       /tec:True `
       /ttsc:True `
       /tu:"<target DB username with the db_owner role>" `
       /tp:"<password>" `
       /p:AllowIncompatiblePlatform=True `
       /p:IgnoreCryptographicProviderFilePath=True `
       /p:IgnoreExtendedProperties=True `
       /p:IgnoreFileAndLogFilePath=True `
       /p:IgnoreFilegroupPlacement=True `
       /p:IgnoreFileSize=True `
       /p:IgnoreFullTextCatalogFilePath=True `
       /p:IgnoreLoginSids=True `
       /p:ScriptRefreshModule=False
   ```

For more information, see the [{{ MS }} documentation]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-publish).

## Migrating with transactional replication {#replication}

You can transfer data from an {{ MS }} cluster to a {{ mms-name }} cluster with minimal downtime using [transactional replication]({{ ms.docs }}/sql/relational-databases/replication/transactional/transactional-replication). This type of replication is supported starting from {{ MS }} 2016 and lets you migrate data to newer versions of SQL Server in {{ mms-name }} clusters.

When replicating transactions:

* Once initialized, the [snapshot agent]({{ ms.docs }}/sql/relational-databases/replication/agents/replication-agents-overview#snapshot-agent) creates a snapshot of a database with a schema and data files of tables and other objects and copies it from the [publisher]({{ ms.docs }}/sql/relational-databases/replication/publish/replication-publishing-model-overview#publisher) to the [distributor]({{ ms.docs }}/sql/relational-databases/replication/publish/replication-publishing-model-overview#distributor) that manages the transfer of data.

   {% note info %}

   Since table locks are used when creating a snapshot, it is recommended to perform initialization when the load on the database is minimal.

   {% endnote %}

* [The Log Reader Agent]({{ ms.docs }}/sql/relational-databases/replication/agents/replication-agents-overview#log-reader-agent) transfers transactions from the transaction log to the distributor.

* The snapshot and transactions from the distributor are transferred using the [Distribution Agent]({{ ms.docs }}/sql/relational-databases/replication/agents/replication-agents-overview#distribution-agent) to a [subscriber]({{ ms.docs }}/sql/relational-databases/replication/publish/replication-publishing-model-overview#subscribers).

Under this scheme, the publisher, distributor, and two agents are located in the source cluster, while the subscriber is in the target cluster. The roles can also be assigned differently, such as using dedicated servers for the distributor.

The following limitations apply when replicating transactions:

* Unidirectional replication: Changes on the target cluster aren't replicated to the source cluster.
* You can't change the target cluster's schema while publishing DB objects.

{% note info %}

Performing large transactions on the source cluster may slow down replication.

{% endnote %}

To migrate a database from the source {{ MS }} cluster to the target {{ mms-name }} cluster using transactional replication:

1. [Create a publication on the source cluster](#create-publication).
1. [Create a subscription on the source cluster](#create-subscription).
1. [Stop the replication and transfer the load](#transfer-load).

If you no longer need the created resources, [delete them](#clear-out).

### Before you start {#before-you-begin-replication}

1. [Create a {{ mms-name }} cluster](../managed-sqlserver/operations/cluster-create.md) in any suitable configuration. In this case:
    * Specify the same database name as in the source cluster.
    * Make sure the target cluster's master host is publicly available to connect the source cluster to it.
    * The {{ MS }} version must be the same or higher than the version in the source cluster.

1. Check that you can [connect to the target cluster](../managed-sqlserver/operations/connect.md#connection-ide) and the source cluster using {{ ssms }}.

### Create a publication on the source cluster {#create-publication}

1. Connect to the source cluster from {{ ssms }}.

1. Expand the list of server objects in Object Explorer.

1. Open the context menu for the **Replication** directory and select **New → Publication**.

1. Go through all the steps of the publication creation wizard, including:
   1. Specify that the server itself will act as a distributor.
   1. Specify the directory for the database snapshot.
   1. Select the database to migrate.
   1. Select the **Transactional replication** type of publication.
   1. In the list of articles to publish, select all DB entities that you want to replicate (tables, views, and stored procedures).
   1. Select the DB snapshot creation time.

   For more information, see [{{ MS }} documentation]({{ ms.docs }}/sql/relational-databases/replication/publish/create-a-publication).

1. Click **Finish**.

{% note info %}

* When migrating multiple databases, create a separate publication for each of them.

* You need privileged user rights to all tables selected for publication.

{% endnote %}

### Create a subscription on the source cluster {#create-subscription}

1. Connect to the source cluster from {{ ssms }}.

1. Expand the list of server objects in **Object Explorer**.

1. Open the context menu for the **Replication** directory and select **New → Subscription**.

1. Go through all the steps of the subscription creation wizard, including:
   1. For the distribution agent, select **Run all agents at the Distributor** (on the source cluster).
   1. Add a subscriber and specify the [data to connect to the master host of the target cluster](../managed-sqlserver/operations/connect.md#connection-ide).
   1. Select the target cluster's database for the subscriber.
   1. In the **Distribution Agent Security** settings under **Connect to the Subscriber**, specify the name and password of the DB owner's account on the target cluster.

   For more information, see [{{ MS }} documentation]({{ ms.docs }}/sql/relational-databases/replication/create-a-push-subscription).

1. Click **Finish**.

This starts replication. To monitor its status, [start the replication monitor]({{ ms.docs }}/sql/relational-databases/replication/monitor/start-the-replication-monitor) and [add a tracking subscription]({{ ms.docs }}/sql/relational-databases/replication/monitor/add-and-remove-publishers-from-replication-monitor).

### Stop the replication and transfer the load {#transfer-load}

1. Check that all data migrated from the source cluster is available on the target cluster.
1. Switch the source cluster to <q>read-only</q> mode:
   1. Open {{ ssms }}.
   1. Open the context menu for the replicated database and select **Properties**.
   1. Select **Database Properties → Options** and, under **State**, change **Database Read Only** to **True**.
1. [Stop the replication]({{ ms.docs }}/sql/relational-databases/replication/agents/start-and-stop-a-replication-agent-sql-server-management-studio) on the source cluster.
1. Delete the subscription and publication on the source cluster. Allow {{ ssms }} to delete the subscriber on the target cluster.
1. Switch over the load to the target cluster.

### How to delete created resources {#clear-out}

To stop paying for the created resources, [delete](../managed-sqlserver/operations/cluster-delete.md) them.

If you reserved a static public IP address, [delete](../vpc/operations/address-delete.md) it.

