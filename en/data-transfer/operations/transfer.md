# Managing transfer process

You can:

* [Retrieve a transfer list](#list).
* [Create a transfer](#create).
* [Update a transfer](#update).
* [Activate a transfer](#activate).
* [Restart a transfer](#reupload).
* [Deactivate a transfer](#deactivate).
* [Delete a transfer](#delete).

For more information about transfer states, operations applicable to transfers, and existing limitations, please see [{#T}](../concepts/transfer-lifecycle.md).

## Getting a list of transfers {#list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of transfers in a folder, run the following command:

    ```bash
    {{ yc-dt }} transfer list
    ```

- API

    Use the API [list](../api-ref/Transfer/list.md) method.

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

         * {{ dt-type-copy }}: Creates a full copy of data without receiving further updates from the source.

            * {% include [field periodic snapshot](../../_includes/data-transfer/fields/periodic-snapshot.md) %}

            * {% include [field incremental tables](../../_includes/data-transfer/fields/incremental-tables.md) %}

            * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}

         * {{ dt-type-repl }}: Allows you to receive data updates from the source and apply them to the target (without creating a full copy of the source data).

            * {% include [field parallel repl](../../_includes/data-transfer/fields/parallel-repl.md) %}

         * {{ dt-type-copy-repl }}: Creates a full copy of the source data and keeps it up-to-date.

            * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}


      * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}**: Specify the full path to each object to be transferred. Only objects from this list will be transferred. If you specified a list of included tables or collections in the source endpoint settings, only objects on both the lists will transfer. If you specify objects that are not in the list of the included tables or collections in the source endpoint settings, the transfer activation will return the `$table not found in source` error. This setting is not available for such sources as {{ KF }}, and {{ DS }}.

            Enter the full name of the object. Depending on the source type, use the appropriate naming convention:

            * {{ CH }}: `<database name>.<table path>`.
            * {{ GP }}: `<scheme name>.<table path>`.
            * {{ MG }}: `<database name>.<collection path>`.
            * {{ MY }}: `<database name>.<table path>`.
            * {{ PG }}: `<scheme name>.<table path>`.
            * Oracle: `<scheme name>.<table path>`.
            * {{ ydb-short-name }}: Table path.

            If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will return an error. A running {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfer will terminate immediately, while an inactive transfer will stop once it is activated.

       * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}**: Rules for [transforming data](../concepts/data-transformation.md). This setting only appears when the source and target are of different types.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}**: Settings for renaming tables:
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.original_name.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}**: Naming convention depending on the source type. e.g., a schema for {{ PG }} or a database for {{ MY }}. If the source does not support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field blank.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}**: Source table name.
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.new_name.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}**: Naming convention depending on the target type. e.g., a schema for {{ PG }} or a database for {{ MY }}. If the source does not support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field blank.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}**: New name for the target table.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}**: Specifies column transfer settings. If both the rename tables and column filter options are set for the transfer, the column filter should specify the source table names. Table and column names are specified using regular expressions. Lists of excluded tables and columns take priority in the event of a conflict with included ones.
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.tables.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.include_tables.title }}**: Names of the tables the column transfer settings apply to.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.exclude_tables.title }}**: Names of the tables the column transfer settings do not apply to.
                * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.columns.title }}**:
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.include_columns.title }}**: Names of the columns included in the list of tables to transfer.
                    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.exclude_columns.title }}**: Names of the columns excluded from the list of tables to transfer.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a transfer:

    1. View a description of the CLI create transfer command:

        ```bash
        {{ yc-dt }} transfer create --help
        ```

    1. Specify the transfer parameters in the create command:

        ```bash
        {{ yc-dt }} transfer create <transfer name> \
           --source-id=<source endpoint ID> \
           --target-id=<target endpoint ID> \
           --type=<transfer type: snapshot-only, increment-only, or snapshot-and-increment>
        ```

        {% note info %}

        The transfer name must be unique within the folder. It may contain Latin letters, numbers, and hyphens. The name may not be longer than 63 characters.

        {% endnote %}

        Where:

        * `--source-id`: Source endpoint ID.
        * `--target-id`: Target endpoint ID.
        * `--type`: [Transfer type](../concepts/transfer-lifecycle.md#transfer-types):
            * `snapshot-only`: [Copy](../concepts/transfer-lifecycle.md#copy).
            * `increment-only`: [Replicate](../concepts/transfer-lifecycle.md#replication).
            * `snapshot-and-increment`: [Copy and replicate](../concepts/transfer-lifecycle.md#copy-and-replication).

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   
   If you do not have {{ TF }} yet, [install it and configure the provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To create a transfer:

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

- API

   Use the [create](../api-ref/Transfer/create.md) API method and include the following information in the request:

   * ID of the folder where the transfer should be placed, in the `folderId` parameter.
   * Transfer name in the `name` parameter.
   * Source endpoint ID in the `sourceId` parameter.
   * Target endpoint ID in the `targetId` parameter.
   * Transfer type in the `type` parameter.

{% endlist %}

## Updating a transfer {#update}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
   1. Select a transfer and click ![pencil](../../_assets/pencil.svg) **{{ ui-key.yacloud.common.edit }}** in the top panel.
   1. Edit the transfer parameters:
      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * For the {{ dt-type-copy }} transfer type:

         * {% include [field periodic snapshot](../../_includes/data-transfer/fields/periodic-snapshot.md) %}

         * {% include [field incremental tables](../../_includes/data-transfer/fields/incremental-tables.md) %}

         * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}

      * For the {{ dt-type-repl }} transfer type:

         * {% include [field parallel repl](../../_includes/data-transfer/fields/parallel-repl.md) %}

      * For the {{ dt-type-copy-repl }} transfer type:

         * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}


      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}**: Specify the full path to each object to be transferred. Only objects from this list will be transferred. If you specified a list of included tables or collections in the source endpoint settings, only objects on both the lists will transfer. If you specify objects that are not in the list of the included tables or collections in the source endpoint settings, the transfer activation will return the `$table not found in source` error. This setting is not available for such sources as {{ KF }}, and {{ DS }}.

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

      * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}**: Rules for [transforming data](../concepts/data-transformation.md). This setting only appears when the source and target are of different types.
         * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.rename_tables.title }}**: Settings for renaming tables:
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.original_name.title }}**:
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}**: Naming convention depending on the source type. e.g., a schema for {{ PG }} or a database for {{ MY }}. If the source does not support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field blank.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}**: Source table name.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTable.new_name.title }}**:
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name_space.title }}**: Naming convention depending on the target type. e.g., a schema for {{ PG }} or a database for {{ MY }}. If the source does not support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field blank.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Table.name.title }}**: New name for the target table.
         * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.filter_columns.title }}** specifies column transfer settings. If both the rename tables and column filter options are set for the transfer, the column filter should specify the source table names. Table and column names are specified using regular expressions. Lists of excluded tables and columns take priority in the event of a conflict with included ones.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.tables.title }}**:
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.include_tables.title }}**: Names of the tables the column transfer settings apply to.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.TablesFilter.exclude_tables.title }}**: Names of the tables the column transfer settings do not apply to.
            * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.columns.title }}**:
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.include_columns.title }}**: Names of the columns included in the list of tables to transfer.
               * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ColumnsFilter.exclude_columns.title }}**: Names of the columns excluded from the list of tables to transfer.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update the transfer settings:

    1. View a description of the update transfer CLI command:

        ```bash
        {{ yc-dt }} transfer update --help
        ```

    1. Run the following command with a list of settings to update:

        ```bash
        {{ yc-dt }} transfer update <transfer ID> \
           --name=<transfer name> \
           --description=<transfer description>
        ```

        You can get the transfer ID with a [list of transfers in the folder](#list).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with the transfer description.

      For information on creating a transfer like this, please review [Create transfer](#create).

   1. Edit the values in the `name` and the `description` fields (transfer name and description).
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-transfer }}).

- API

    Use the [update](../api-ref/Transfer/update.md) API method and include the following in the request:

    * Transfer ID in the `transferId` parameter. To find out the ID, [get a list of transfers in the folder](#list).
    * Transfer name in the `name` parameter.
    * Transfer description in the `description` parameter.
    * List of transfer configuration fields to update in the `updateMask` parameter.

    {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

When updating a transfer, its settings are applied immediately. Editing {{ dt-type-copy-repl }} or {{ dt-type-repl }} transfer settings with the {{ dt-status-repl }} status will result in restarting the transfer.

## Activating a transfer {#activate}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the transfer in question and select **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To activate a transfer, run this command:

    ```bash
    {{ yc-dt }} transfer activate <transfer ID>
    ```

    You can get the transfer ID with a [list of transfers in the folder](#list).

- API

    Use the [activate](../api-ref/Transfer/activate.md) API method and provide the transfer ID in the `transferId` request parameter.

    To find out the transfer ID, [get a list of transfers in the folder](#list).

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

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To deactivate a transfer, run this command:

    ```bash
    {{ yc-dt }} transfer deactivate <transfer ID>
    ```

    You can get the transfer ID with a [list of transfers in the folder](#list).

- API

    Use the [deactivate](../api-ref/Transfer/deactivate.md) API method and provide the transfer ID in the `transferId` request parameter.

    To find out the transfer ID, [get a list of transfers in the folder](#list).

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

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete a transfer, run this command:

    ```bash
    {{ yc-dt }} transfer delete <transfer ID>
    ```

    You can get the transfer ID with a [list of transfers in the folder](#list).

- {{ TF }}

   {% include [terraform-delete](../../_includes/data-transfer/terraform-delete-transfer.md) %}

- API

    Use the [delete](../api-ref/Transfer/delete.md) API method and provide the transfer ID in the `transferId` request parameter.

    To find out the transfer ID, [get a list of transfers in the folder](#list).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
