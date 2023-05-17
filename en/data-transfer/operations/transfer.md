# Managing transfer process

You can:

* [Retrieve a transfer list](#list).
* [Create a transfer](#create).
* [Update a transfer](#update).
* [Activate a transfer](#activate).
* [Deactivate a transfer](#deactivate).
* [Restart a transfer](#reupload).
* [Delete a transfer](#delete).

For more information about transfer states, operations applicable to transfers, and existing limitations, please see [{#T}](../concepts/transfer-lifecycle.md).

## Getting a list of transfers {#list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.

{% endlist %}

## Creating a transfer {#create}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
   1. Click **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
   1. Select the source endpoint or [create](./endpoint/index.md#create) a new one.
   1. Select the target endpoint or [create](./endpoint/index.md#create) a new one.
   1. Specify the transfer parameters:

      * **{{ ui-key.yacloud.common.name }}**.
      * (Optional) **{{ ui-key.yacloud.common.description }}**.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**:

         * {{ dt-type-copy }}: Creates a full copy of data without receiving further updates from the source. Under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}**, specify the number of parallel copy processes and threads.
            To have a full copy of data created at certain intervals of time, enable **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.regular_snapshot.title }}** and select the required copy interval in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.RegularSnapshotIntervalType.interval.title }}** field.

            In the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.incremental_tables.title }}** list, add tables whose data is copied incrementally, i.e. from where the copy process stopped previously; set values for the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_namespace.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_name.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_column.title }}**, and **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_start_value.title }}** (optional) fields. The transfer will remember the maximum value of the cursor column and, when run next time, will only read the data added or updated since the last run. This is more efficient than copying entire tables but less efficient than using transfers of the _{{ dt-type-copy-repl }}_ type. This setting is available for such sources as {{ PG }}, {{ CH }}, and Airbyte.

            {% include [postgresql-cursor-serial](../../_includes/data-transfer/serial-increment-cursor.md) %}

         * {{ dt-type-repl }}: Allows you to receive data updates from the source and apply them to the target (without creating a full copy of the source data). Under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeIncrement.increment_settings.title }}**, specify the number of replication processes. This setting is available for such sources as {{ KF }}, and {{ DS }}. If multiple replication processes are run, they share the partitions of the topic being replicated. 
         * {{ dt-type-copy-repl }}: Creates a full copy of the source data and keeps it up-to-date. Under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshotAndIncrement.snapshot_settings.title }}**, specify the number of parallel copy and replication processes and threads. Under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshotAndIncrement.increment_settings.title }}**, specify the number of replication processes. This setting is available for such sources as {{ KF }}, and {{ DS }}. If multiple replication processes are run, they share the partitions of the topic being replicated. 

       * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}**: Specify the full path to each object being transferred. Only objects from this list will be transferred. If you specified a list of included tables or collections in the source endpoint settings, only objects on both the lists will transfer. If you specify objects that are not in the list of the included tables or collections in the source endpoint settings, the transfer activation will return the `$table not found in source` error. This setting is not available for such sources as {{ KF }}, and {{ DS }}.

            Enter the full name of the object. Depending on the source type, use the appropriate naming convention:

            * {{ CH }}: `<database name>.<table path>`.
            * {{ GP }}: `<scheme name>.<table path>`.
            * {{ MG }}: `<database name>.<collection path>`.
            * {{ MY }}: `<database name>.<table path>`.
            * {{ PG }}: `<scheme name>.<table path>`.
            * Oracle: `<scheme name>.<table path>`.
            * {{ ydb-short-name }}: Table path.

            If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will return an error. A running {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfer will terminate immediately, while an inactive transfer will stop once it is activated.

       * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}**: Rules for transforming data. This setting only appears when the source and target are of different types. Select **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}** or **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}**.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}**: Settings for renaming tables:
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.original_name.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}**: Naming convention depending on the source type. e.g., a schema for {{ PG }} or a database for {{ MY }}. If the source does not support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field blank.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}**: Source table name.
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.new_name.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}**: Naming convention depending on the target type. e.g., a schema for {{ PG }} or a database for {{ MY }}. If the source does not support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field blank.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}**: New name for the target table.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}**: Specifies column transfer settings:
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.tables.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.include_tables.title }}**: Names of the tables the column transfer settings apply to.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.exclude_tables.title }}**: Names of the tables the column transfer settings do not apply to.
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.columns.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.include_columns.title }}**: Names of the columns included in the list of tables to transfer.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.exclude_columns.title }}**: Names of the columns included in the list of tables not to be transferred.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   To create a transfer:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

      1. If you do not have {{ TF }} yet, [install it and create a configuration file with provider settings](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Create a configuration file with a description of your transfer.

      Example of the configuration file structure:

      ```hcl
      resource "yandex_datatransfer_transfer" "<transfer name in {{ TF }}>" {
        folder_id   = "<folder ID>"
        name        = "<transfer name>"
        description = "<transfer description>"
        source_id   = "<source endpoint ID>"
        target_id   = "<target endpoint ID>"
        type        = "<transfer type>"
      }
      ```

      Available transfer types:

      * `SNAPSHOT_ONLY` — _{{ dt-type-copy }}_;
      * `INCREMENT_ONLY` — _{{ dt-type-repl }}_;
      * `SNAPSHOT_AND_INCREMENT` — _{{ dt-type-copy-repl }}_.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-transfer }}).

   When created, the `INCREMENT_ONLY` and `SNAPSHOT_AND_INCREMENT` transfers are activated and run automatically.
   If you want to activate the `SNAPSHOT_ONLY` transfer when it is created, add the `provisioner "local-exec"` section with the transfer activation command to the configuration file:

   ```hcl
      provisioner "local-exec" {
         command = "yc --profile <profile> datatransfer transfer activate ${yandex_datatransfer_transfer.<name of the transfer's Terraform resource>.id
      }
   ```

   In this case, copying will only take place once at the time of transfer creation.

{% endlist %}

## Updating a transfer {#update}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
   1. Select a transfer and click ![pencil](../../_assets/pencil.svg) **{{ ui-key.yacloud.common.edit }}** in the top panel.
   1. Edit the transfer parameters:
      * **{{ ui-key.yacloud.common.name }}**.
      * (Optional) **{{ ui-key.yacloud.common.description }}**.
        * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}**: Specify the full path to each object to be transferred. Only objects from this list will be transferred. If you specified a list of included tables or collections in the source endpoint settings, only objects on both the lists will transfer. If you specify objects that are not in the list of the included tables or collections in the source endpoint settings, the transfer activation will return the `$table not found in source` error. This setting is not available for such sources as {{ KF }}, and {{ DS }}.

         Adding new objects to {{ dt-type-copy-repl }} or {{ dt-type-repl }} transfers in the {{ dt-status-repl }} status will result in uploading data history for these objects or tables. If a table is large, uploading the history may take a long time. You can't edit the list of objects for transfers in the {{ dt-status-copy }} status.

         Enter the full name of the object. Depending on the source type, use the appropriate naming convention:

            * {{ CH }}: `<database name>.<table path>`.
            * {{ GP }}: `<scheme name>.<table path>`.
            * {{ MG }}: `<database name>.<collection path>`.
            * {{ MY }}: `<database name>.<table path>`.
            * {{ PG }}: `<scheme name>.<table path>`.
            * Oracle: `<scheme name>.<table path>`.
            * {{ ydb-short-name }}: Table path.

            If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will return an error. A running {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfer will terminate immediately, while an inactive transfer will stop once it is activated.

        * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}**: Rules for transforming data. This setting only appears when the source and target are of different types. Select **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}** or **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}**.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}**: Settings for renaming tables:
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.original_name.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}**: Naming convention depending on the source type. e.g., a schema for {{ PG }} or a database for {{ MY }}. If the source does not support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field blank.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}**: Source table name.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.new_name.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}**: Naming convention depending on the target type. e.g., a schema for {{ PG }} or a database for {{ MY }}. If the source does not support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field blank.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}**: New name for the target table.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}** specifies column transfer settings:
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.tables.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.include_tables.title }}**: Names of the tables the column transfer settings apply to.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.exclude_tables.title }}**: Names of the tables the column transfer settings do not apply to.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.columns.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.include_columns.title }}**: Names of the columns included in the list of tables to transfer.
                   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.exclude_columns.title }}**: Names of the columns included in the list of tables not to be transferred.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with the transfer description.

      For information on creating a transfer like this, please review [Create transfer](#create).

   1. Edit the values in the `name` and the `description` fields (transfer name and description).
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-transfer }}).

{% endlist %}

When updating a transfer, its settings are applied immediately. Editing {{ dt-type-copy-repl }} or {{ dt-type-repl }} transfer settings with the {{ dt-status-repl }} status will result in restarting the transfer.

## Activating a transfer {#activate}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the transfer in question and select **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

{% endlist %}

## Reloading a transfer {#reupload}

If you assume that the transfer replication stage may fail (for example, due to [changes to the schema of the transferred data](db-actions.md) on the source), force reload the transfer.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the transfer in question and select **{{ ui-key.yacloud.data-transfer.label_connector-operation-REUPLOAD }}**.

{% endlist %}

For more information, see [{#T}](../concepts/transfer-lifecycle.md).

## Deactivating a transfer {#deactivate}

During transfer deactivation:

* The replication slot on the source is disabled.
* Temporary data transfer logs are deleted.
* The target is brought into the aligned state:
   * The data schema objects of the source are transferred for the final stage.
   * Indexes are created.

{% list tabs %}

- Management console

   1. Switch the source to <q>read-only</q>.
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the transfer in question and select **{{ ui-key.yacloud.data-transfer.label_connector-operation-DEACTIVATE }}**.
   1. Wait for the transfer status to change to {{ dt-status-stopped }}.

{% endlist %}

{% note warning %}

Do not interrupt the deactivation of the transfer! If the process fails, the performance of the source and target is not guaranteed.

{% endnote %}

For more information, see [{#T}](../concepts/transfer-lifecycle.md).

## Deleting a transfer {#delete}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
   1. If the desired transfer is active, [deactivate it](#deactivate).
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the transfer in question and select **{{ ui-key.yacloud.common.remove }}**.
   1. Click **{{ ui-key.yacloud.common.remove }}**.

- {{ TF }}

   {% include [terraform-delete](../../_includes/data-transfer/terraform-delete-transfer.md) %}

{% endlist %}
