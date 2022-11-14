# Migrating databases from a third-party {{ MS }} cluster to {{ mms-full-name }}

You can migrate a database from a third-party {{ MS }} _source cluster_ to a {{ mms-short-name }} _target cluster_ using a [logical import]({{ ms.docs }}/sql/relational-databases/replication/snapshot-replication) of a database snapshot or [transactional replication]({{ ms.docs }}/sql/relational-databases/replication/transactional/transactional-replication). Both methods have their limitations:

- [Migrating by logical import](#snapshot):

   - Creating a snapshot uses table locking.
   - The snapshot import process is relatively slow compared to transactional replication.
   - Data in the target cluster is only relevant when the snapshot is created and might become outdated.
   - This method can't be used for a database with logical inconsistencies: for example, if dependencies or tables referenced by views have been deleted from it. If you need to migrate this type of database, create a [database snapshot]({{ ms.docs }}/sql/relational-databases/databases/create-a-database-snapshot-transact-sql) and forward it to [technical support]({{ link-console-support }}) to have our specialists manually recover the database from your snapshot.

- [Migrating with transactional replication](#replication):

   - Unidirectional replication: Changes on the target cluster aren't replicated to the source cluster.
   - You can't change the target cluster's schema while publishing DB objects.

## Before you begin {#before-you-begin}

Create the necessary resources:

{% list tabs %}

- Manually

   [Create a {{ mms-name }} cluster](../../managed-sqlserver/operations/cluster-create.md) with public internet access.

   - When [migrating by logical import](#snapshot), create the target cluster with the same **SQL Server Collation** setting as the source cluster.

   - When [migrating by transactional replication](#replication):

      - The {{ MS }} version must be the same or higher than the version in the source cluster.
      - The database names in the source and the target clusters must be the same.
      - [Add](../../managed-sqlserver/operations/cluster-users.md#adduser) all the same users that exist in the source cluster and use **SQL Server Authentication** to the target cluster with the same usernames and passwords.

- Using {{ TF }}

   1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [sqlserver-data-migration.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/sqlserver-data-migration.tf) configuration file to the same working directory.

      This file describes:

      - [Network](../../vpc/concepts/network.md#network).
      - [Subnet](../../vpc/concepts/network.md#subnet).
      - [Security group](../../vpc/concepts/security-groups.md) and rule enabling cluster connections.
      - {{ mms-name }} cluster with public internet access.

   1. Specify the infrastructure settings under `locals` in the `sqlserver-data-migration.tf` configuration file.

      - `sql_server_version`: {{ MS }} version.
      - `sql_server_collation`: Value of the **SQL Server Collation** setting. It must be the same as the value of **SQL Server Collation** on the source cluster.
      - `db_name`: Target cluster database name.
      - `username` and `password`: Database owner username and password.

      When [migrating by logical import](#snapshot), comment out and replicate the `user` section. Specify the account credentials of all the source cluster users that utilize **SQL Server Authentication**.

      When [migrating by transactional replication](#replication), the {{ MS }} version must be the same as or higher than in the source cluster while the source and target cluster database names must be the same.

   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Migrating by logical import {#snapshot}

You can transfer data from a {{ MS }} cluster to a {{ mms-short-name }} cluster with [sqlpackage]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-download). It will create a {{ MS }} database snapshot with a table schema and data and import it into a {{ mms-short-name }} cluster.

To migrate a database from the source {{ MS }} cluster to the target {{ mms-name }} cluster by logical import:

1. [Set up the source cluster](#configure-source).
1. [Create a snapshot of the database from the source cluster](#create-snapshot).
1. [Import a snapshot of the database to the target cluster](#import-snapshot).

If you no longer need these resources, [delete them](#clear-out).

### Set up the source cluster {#configure-source}

1. Check that you can [connect to the target cluster](../../managed-sqlserver/operations/connect.md#connection-ide) and the source cluster using {{ ssms }}.

1. [Download and install sqlpackage]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-download).

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

### Create a database snapshot {#create-snapshot}

To export the database to a .dacpac file, run PowerShell, navigate to the directory with sqlpackage, and run the command:

```powershell
.\sqlpackage.exe `
    /a:Extract `
    /ssn:"<source cluster address {{ MS }}>" `
    /sdn:"<database name>" `
    /tf:"<local path to the .dacpac file>" `
    /p:ExtractAllTableData=True `
    /p:ExtractReferencedServerScopedElements=False
```

{% note info %}

To export only the table schema without the data itself, set the `/p:ExtractAllTableData` parameter to `False`. If you need to export certain tables only, replace the `/p:ExtractAllTableData` parameter with the required number of `/p:TableData=<table name>` parameters.

{% endnote %}

For more information, see the [{{ MS }} documentation]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-extract).

### Import a snapshot of the database to the target {#import-snapshot} cluster

To import the snapshot to the {{ mms-name }} cluster, run PowerShell, go to the directory with sqlpackage, and run the command:

```powershell
.\sqlpackage.exe `
    /a:Publish `
    /sf:"<local path to the .dacpac file>" `
    /tsn:"<FQDN of the master host in the cluster {{ mms-name }}>,1433" `
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

You can transfer data from a {{ MS }} to a {{ mms-name }} cluster with minimum downtime using [transactional replication]({{ ms.docs }}/sql/relational-databases/replication/transactional/transactional-replication). This type of replication is supported as of {{ MS }} 2016 and lets you migrate data to newer versions of SQL Server in {{ mms-name }} clusters.

When performing transactional replication:

* A [snapshot agent]({{ ms.docs }}/sql/relational-databases/replication/agents/replication-agents-overview#snapshot-agent) creates a database snapshot with a table schema and data files and copies it from the [publisher]({{ ms.docs }}/sql/relational-databases/replication/publish/replication-publishing-model-overview#publisher) to the [distributor]({{ ms.docs }}/sql/relational-databases/replication/publish/replication-publishing-model-overview#distributor), which manages data migration.

   {% note info %}

   Since creating a snapshot locks tables, use a period of time when your database experiences minimum load.

   {% endnote %}

* [Log Reader Agent]({{ ms.docs }}/sql/relational-databases/replication/agents/replication-agents-overview#log-reader-agent) transfers transactions from the transaction log to the distributor.
* The snapshot and the transactions are transferred by the [Distribution Agent]({{ ms.docs }}/sql/relational-databases/replication/agents/replication-agents-overview#distribution-agent) from the distributor to the [subscriber]({{ ms.docs }}/sql/relational-databases/replication/publish/replication-publishing-model-overview#subscribers).

The publisher, the distributor, and the two agents are located in the source cluster, while the subscriber is in the target cluster. The roles can also be assigned differently, such as using dedicated servers for the distributor.

{% note info %}

Performing large transactions in the source cluster may slow replication down.

{% endnote %}

To migrate a database from the source {{ MS }} cluster to the target {{ mms-name }} cluster using transactional replication:

1. [Create a publication in the source cluster](#create-publication).
1. [Create a subscription in the source cluster](#create-subscription).
1. [Stop the replication and transfer the load](#transfer-load).

If you no longer need these resources, [delete them](#clear-out).

### Create a publication in the source cluster {#create-publication}

1. Check that you can [connect to the target cluster](../../managed-sqlserver/operations/connect.md#connection-ide) and the source cluster using {{ ssms }}.
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

   For more information, see the [{{ MS }} documentation]({{ ms.docs }}/sql/relational-databases/replication/publish/create-a-publication).

1. Click **Finish**.

{% note info %}

* When migrating multiple databases, create a separate publication for each of them.

* You need privileged user rights to all tables selected for publication.

{% endnote %}

### Create a subscription in the source cluster {#create-subscription}

1. Connect to the source cluster from {{ ssms }}.
1. Expand the list of server objects in **Object Explorer**.
1. Open the context menu for the **Replication** directory and select **New → Subscription**.
1. Go through all the steps of the subscription creation wizard, including:
   1. For the distribution agent, select **Run all agents at the Distributor** (on the source cluster).
   1. Add a subscriber and specify the [data to connect to the master host of the target cluster](../../managed-sqlserver/operations/connect.md#connection-ide).
   1. Select the target cluster's database for the subscriber.
   1. In the **Distribution Agent Security** settings, use the **Connect to the Subscriber** section to specify the target cluster DB owner account name and password.

   For more information, see the [{{ MS }} documentation]({{ ms.docs }}/sql/relational-databases/replication/create-a-push-subscription).

1. Click **Finish**.

This starts replication. To keep track of its status, [start a monitor]({{ ms.docs }}/sql/relational-databases/replication/monitor/start-the-replication-monitor) and [add a subscription for tracking]({{ ms.docs }}/sql/relational-databases/replication/monitor/add-and-remove-publishers-from-replication-monitor).

### Stop the replication and transfer the load {#transfer-load}

1. Check that all the data migrated from the source cluster is available in the target cluster.
1. Switch the source cluster to <q>read-only</q> mode:
   1. Open {{ ssms }}.
   1. Open the context menu for the replicated database and select **Properties**.
   1. Select **Database Properties → Options** and, under **State**, change **Database Read Only** to **True**.
1. [Stop replication]({{ ms.docs }}/sql/relational-databases/replication/agents/start-and-stop-a-replication-agent-sql-server-management-studio) in the source cluster.
1. Delete the subscription and the publication in the source cluster. Confirm allowing {{ ssms }} to delete the subscriber in the target cluster.
1. Switch the load over to the target cluster.

## Delete the resources you created {#clear-out}

{% list tabs %}

- Manually

   If you no longer need these resources, delete them:

   - [Delete a {{ mms-full-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
   - If you reserved a public static IP address, release and [delete it](../../vpc/operations/address-delete.md).

- Using {{ TF }}

   To delete the infrastructure created with {{ TF }}:

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the `sqlserver-data-migration.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      This will delete all the resources described in the `sqlserver-data-migration.tf` configuration file.

{% endlist %}
