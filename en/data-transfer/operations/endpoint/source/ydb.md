---
title: How to set up a {{ ydb-full-name }} source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to create and configure a {{ ydb-full-name }} source endpoint in {{ data-transfer-full-name }}.
---

# Transferring data from a {{ ydb-name }} source endpoint


{{ data-transfer-full-name }} enables you to migrate data from a {{ ydb-name }} database and implement various transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Prepare the {{ ydb-name }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. If you run into any problems, [check the available solutions](#troubleshooting) for troubleshooting.

## {{ ydb-name }} data transfer scenarios {#scenarios}

1. {% include [cdc](../../../../_includes/data-transfer/scenario-captions/cdc.md) %}

    * [Capturing changes from {{ PG }} and delivering to {{ DS }}](../../../tutorials/ydb-to-yds.md).
    * [Capturing changes from {{ PG }} and delivering to {{ KF }}](../../../tutorials/cdc-ydb.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Loading data from {{ ydb-short-name }} to the {{ CH }}](../../../tutorials/ydb-to-clickhouse.md) data mart.

1. {% include [storage](../../../../_includes/data-transfer/scenario-captions/storage.md) %}

    * [Loading data from {{ ydb-short-name }} to {{ objstorage-name }}](../../../tutorials/ydb-to-object-storage.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/ydb-prepare.md) %}

## Configuring the {{ ydb-name }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can configure:
* {{ ydb-full-name }} DB connection settings. These settings are required.
* Transfer path list (for tables and directories).


{% note warning %}

To create or edit an endpoint of a managed database, you will need the [`ydb.viewer`](../../../../ydb/security/index.md#ydb-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder the cluster of this managed database resides in.

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  * Select the **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.on_premise_connection.title }}** or **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.managed_connection.title }}** connection type.
  
    To set up your connection manually, specify the following:

      * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name-onprem.md) %}

      * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/ydb-endpoint-settings.md) %}

      
      * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}

      * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/ca-sertificate.md) %}
    
      * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/subnet-id.md) %}
  
      * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/security-groups.md) %}

  
    To set up a connection to {{ ydb-full-name }}:

      * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name.md) %}

      
      * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}

      * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/security-groups.md) %}


  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}**: Add paths to the {{ ydb-name }} tables and directories to transfer.

      Table and directory names must meet the ID naming rules in {{ ydb-short-name }}. Double quote escaping is not required. The `/` character is used as a path delimiter. For more information, see [this {{ ydb-short-name }} guide]({{ ydb.docs }}/concepts/connect#database).

      Adding new paths when editing an endpoint used in {{ dt-type-copy-repl }} transfers in the {{ dt-status-repl }} status will not result in uploading the data history of these tables. To add a table with its historical data, use the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** field in the [transfer settings](../../transfer.md#update).

      For {{ dt-type-copy }} transfers, you may skip specifying paths. In this case, all tables will be transferred.

      For {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfers, specifying paths is required, including when you replicate all tables.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbCustomFeedSettings.changefeed_custom_name.title }}**: Specify the name of the update stream if already created. Otherwise, leave the field blank.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbCustomFeedSettings.changefeed_custom_consumer_name.title }}**: Specify the data consumer you created for the update stream. The default consumer is `__data_transfer_consumer`.

      
      {% note info %}

      If a data consumer is specified, the `ydb.viewer` role is enough for the service account specified in the endpoint settings to connect the transfer to {{ ydb-short-name }}. If no data consumer is specified, the service account must have the `ydb.editor` role to create the default consumer.

      {% endnote %}
      

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.YdbSourceAdvancedSettings.sharded_snapshot.title }}**:

    {% note warning %}

    For consistent data migration during parallel copying, the transfer first copies the original tables from the source to a temporary folder, reads the data from these copies, and then deletes the temporary copies.
    The data is copied at the metadata level, which does not take much time. However, the copied tables are fully counted towards the {{ ydb-name }} disk quota.
    **Therefore, by running a transfer with the sharded snapshot option on you may deplete your disk quota for the source database. So make sure your database has enough disk quota left before you run a transfer.**

    {% endnote %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbShardedSnapshotSettings.is_snapshot_sharded.title }}**: Enable to speed up the transfer with the help of a sharded snapshot.

      During the copying stage, tables are divided into partitions. Copying will proceed faster if the number of workers multiplied by the number of threads inside a worker is proportional to the number of partitions.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbShardedSnapshotSettings.copy_folder.title }}**: Specify the name of the directory to store the copies of the tables during the copying stage. The directory is created in the root directory of the source base and gets the default name of `data-transfer`. As soon as the copying stage is over, the directory will be deleted.
    
    
    To control parallel copying, the service account specified in the endpoint settings must have the [`ydb.editor`](../../../../ydb/security/index.md#ydb-editor) role.


    To maximize the parallel copying speed:

      * In the source endpoint parameters, enable **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbShardedSnapshotSettings.is_snapshot_sharded.title }}**.

      
      * In the transfer parameters, under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}**, set the number of workers and threads per worker so that the total number of threads equals the number of partitions. For example, to copy a table of 6 partitions faster, you can allocate three workers with two threads per worker.
      

    [More on parallel copying](../../../concepts/sharded.md).

- {{ TF }} {#tf}

  * Endpoint type: `ydb_source`.

  {% include [Managed YDB {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/managed-ydb-source.md) %}

  Here is an example of the configuration file structure (not all parameters are given):

  
  ```hcl
  resource "yandex_datatransfer_endpoint" "ydb-source" { 
    name = "<endpoint_name>"
    settings {
      ydb_source {
        database               = "<YDB_database_name>"
        service_account_id     = "<service_account_ID>"
        paths                  = ["<list_of_paths_to_transferrable_YDB_objects>"]
        changefeed_custom_name = "<changefeed_name>"
      }
    }
  }
  ```


  For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

{% endlist %}


## Configuring the target {#supported-targets}

Configure one of the supported data targets:

* [{{ CH }}](../target/clickhouse.md)
* [{{ objstorage-full-name }}](../target/object-storage.md)
* [{{ KF }}](../target/kafka.md)
* [{{ DS }}](../target/data-streams.md)
* [{{ ytsaurus-name }}](../source/yt.md)
* [{{ PG }}](../target/postgresql.md)
* [{{ ydb-full-name }}](../target/yandex-database.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).

## Data transfer troubleshooting {#troubleshooting}

Known issues when using a {{ ydb-name }} endpoint:

{% include [overloaded](../../../../_includes/data-transfer/troubles/overloaded.md) %}

For the full list of troubleshooting tips, see [Troubleshooting](../../../troubleshooting/index.md).
