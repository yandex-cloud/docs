# Managing the transfer process

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
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.

{% endlist %}

## Creating a transfer {#create}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.
   1. Click **Create transfer**.
   1. Select the source endpoint or [create](./endpoint/index.md#create) a new one.
   1. Select the target endpoint or [create](./endpoint/index.md#create) a new one.
   1. Specify the transfer parameters:

      * **Transfer name**.
      * (Optional) **Description**.
      * **Transfer type**:

         * {{ dt-type-copy }}: Creates a full copy of data without receiving further updates from the source.
         * {{ dt-type-copy-reg }}: Creates a full copy of data at certain intervals of time.
         * {{ dt-type-repl }}: Lets you receive data updates from the source and apply them to the target (without creating a full copy of the source data).
         * {{ dt-type-copy-repl }}: Creates a full copy of the source data and keeps it up-to-date.

         For the _{{ dt-type-copy }}_, _{{ dt-type-copy-reg }}_, and _{{ dt-type-copy-repl }}_ types, under **Snapshot settings**, specify the number of copy processes and threads.

         In the **Incremental tables** list, add tables whose data is copied from where the copy process stopped previously and not in full: set values for the **Schema**, **Table**, **Key column**, and **Initial state** (optional) fields. The transfer will remember the maximum value of the cursor column and, during the next activation, will only read the data added or updated since the last run. This is more effective than copying entire tables but less affective than using transfers of the _{{ dt-type-copy-repl }}_ type. The setting is available for sources such as {{ PG }}, {{ CH }}, and Airbyte.

         {% include [postgresql-cursor-serial](../../_includes/data-transfer/serial-increment-cursor.md) %}

         For the _{{ dt-type-copy-reg }}_ transfer type, select the appropriate copy interval in the **Interval** field.

         For the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ types, under **Replication settings**, specify the number of replication processes. The setting is available for sources such as {% if audience == "internal" %}{{ logbroker-name }}, {{ eventhub-name }}, {% endif %}{{ KF }}, and {{ DS }}. If multiple replication processes are run, they share the partitions of the topic being replicated. {% if audience == "internal" %}For {{ logbroker-name }}, data can be read from multiple topics.{% endif %}

{% if audience == "internal" %}
      * **Runtime environment**: The system type and transfer run parameters:
         * **YT**:
            * **Pool type**: The type of the YT pool where the transfer operations will be started. Select **Common** or **Private**. For a private pool, specify the pool name and YT cluster where the transfer operations will be started (`ARNOLD`, `HAHN`, or `VANGA`).
            * **CPU**: Guaranteed CPU performance per operation.
            * **RAM**: Guaranteed amount of RAM per operation. If the amount of RAM you need is higher than the value you can set through this form, contact the administrators.
            * **Multi YT**: Add multiple YT clusters where the transfer operations will be started. The setting is available for the {{ logbroker-name }} source.
{% endif %}
      * (Optional) **List of objects to transfer**: Only objects on this list will transfer. If you specified a list of included tables or collections in the source endpoint settings, only objects on both the lists will transfer. If you specify objects that are not in the list of the included tables or collections in the source endpoint settings, the transfer activation will return the `$table not found in source` error. The setting is not available for sources such as {% if audience == "internal" %}{{ logbroker-name }}, {{ logfeller-name }}, {{ eventhub-name }}, {% endif %}{{ KF }}, and {{ DS }}.

            Enter the full name of the object. Depending on the source type, use the appropriate naming convention:

            * {{ CH }}: `<database name>.<table name>`.
            * {{ GP }}: `<schema name>.<table name>`.
            * {{ MG }}: `<database name>.<collection name>`.
            * {{ MY }}: `<database name>.<table name>`.
            * {{ PG }}: `<schema name>.<table name>`.
            * Oracle: `<schema name>.<table name>`.
            * {{ ydb-short-name }}: Table path.

            If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will return an error. A running {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfer will terminate immediately, while an inactive transfer will stop once it is activated.

      * (Optional) **Data transformations**: Rules for transforming data. This setting only appears when the source and target are of different types. Select **Rename tables** or **Columns filter**.
            * **Rename tables**: Settings for renaming tables:
               * **Source table name**:
                  * **Named schema**: Naming convention depending on the source type. For example, a schema for {{ PG }} or a database for {{ MY }}. If the source doesn't support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field empty.
                  * **Table name**: Source table name.
               * **Target table name**:
                  * **Named schema**: Naming convention depending on the target type. For example, a schema for {{ PG }} or a database for {{ MY }}. If the source doesn't support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field empty.
                  * **Table name**: New name for the target table.
            * **Columns filter**: Specifies column transfer settings:
               * **Tables**:
                  * **Included tables**: Names of the tables the column transfer settings apply to.
                  * **Excluded tables**: Names of the tables the column transfer settings do not apply to.
               * **List of columns**:
                  * **Included columns**: Names of the columns in the list of included tables to transfer.
                  * **Excluded columns**: Names of the columns in the list of included tables not to transfer.
    1. Click **Create**.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   To create a transfer:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

   {% if audience != "internal" %}
   1. If you don't have {{ TF }} yet, [install it and create a configuration file with provider settings](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   {% endif %}
   1. Create a configuration file with a description of your transfer.

      Example configuration file structure:

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

   1. Confirm the update of resources.

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
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.
   1. Select a transfer and click ![pencil](../../_assets/pencil.svg) **Edit** on the top panel.
   1. Edit the transfer parameters:
      * **Transfer name**.
      * (Optional) **Description**.
{% if audience == "internal" %}
      * **Runtime environment** (system type and parameters for starting a transfer):
         * **YT**:
            * **Pool type**: The type of the YT pool where the transfer operations will be started. Select **Common** or **Private**. For a private pool, specify the pool name and YT cluster where the transfer operations will be started (`ARNOLD`, `HAHN`, or `VANGA`).
            * **CPU**: Guaranteed CPU performance per operation.
            * **RAM**: Guaranteed amount of RAM per operation. If the amount of RAM you need is higher than the value you can set through this form, contact the administrators.
         * **Multi YT**: Add multiple YT clusters where the transfer operations will be started. The setting is available for the {{ logbroker-name }} source.
{% endif %}
      * (Optional) **List of objects to transfer**: Only objects on this list will transfer. If you specified a list of included tables or collections in the source endpoint settings, only objects on both the lists will transfer. If you specify objects that are not in the list of the included tables or collections in the source endpoint settings, the transfer activation will return the `$table not found in source` error. The setting is not available for sources such as {% if audience == "internal" %}{{ logbroker-name }}, {{ logfeller-name }}, {{ eventhub-name }}, {% endif %}{{ KF }}, and {{ DS }}.

         Adding new objects to {{ dt-type-copy-repl }} or {{ dt-type-repl }} transfers in the {{ dt-status-repl }} status will result in uploading data history for these objects or tables. If a table is large, uploading the history may take a long time. You can't edit the list of objects for transfers in the {{ dt-status-copy }} status.

         Enter the full name of the object. Depending on the source type, use the appropriate naming convention:

         * {{ CH }}: `<database name>.<table name>`.
         * {{ GP }}: `<schema name>.<table name>`.
         * {{ MG }}: `<database name>.<collection name>`.
         * {{ MY }}: `<database name>.<table name>`.
         * {{ PG }}: `<schema name>.<table name>`.
         * Oracle: `<schema name>.<table name>`.
         * {{ ydb-short-name }}: Table path.

         If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will return an error. A running {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfer will terminate immediately, while an inactive transfer will stop once it is activated.

      * (Optional) **Data transformations**: Rules for transforming data. This setting only appears when the source and target are of different types. Select **Rename tables** or **Columns filter**.
         * **Rename tables** are settings for renaming tables:
            * **Source table name**:
               * **Named schema** is a naming convention depending on the source type. For example, a schema for {{ PG }} or a database for {{ MY }}. If the source doesn't support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field empty.
               * **Table name** is the source table name.
            * **Target table name**:
               * **Named schema** is a naming convention depending on the target type. For example, a schema for {{ PG }} or a database for {{ MY }}. If the source doesn't support schema or DB abstractions, such as in {{ ydb-short-name }}, leave the field empty.
               * **Table name** is a new name for the target table.
         * **Column filter** specifies column transfer settings:
            * **List of tables**:
               * **Included tables** are the names of tables that column transfer settings apply to.
               * **Excluded tables** are the names of tables that column transfer settings don't apply to.
            * **List of columns**:
               * **Included columns** are the names of columns in the list of included tables to be transferred.
               * **Excluded columns** are the names of columns in the list of included tables that are not to be transferred.
   1. Click **Save**.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with the transfer description.

      For information on creating a transfer like this, please review [Create transfer](#create).

   1. Edit the values in the `name` and the `description` fields (transfer name and description).
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-transfer }}).

{% endlist %}

When updating a transfer, its settings are applied immediately. Editing {{ dt-type-copy-repl }} or {{ dt-type-repl }} transfer settings with the {{ dt-status-repl }} status will result in restarting the transfer.

## Activating a transfer {#activate}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired transfer and select **Activate**.

{% endlist %}

## Reloading a transfer {#reupload}

If you assume that the transfer replication stage may fail (for example, due to [changes to the schema of the transferred data](db-actions.md) on the source), force reload the transfer.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired transfer and select **Restart**.

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
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired transfer and select **Deactivate**.
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
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.
   1. If the desired transfer is active, [deactivate it](#deactivate).
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired transfer and select **Delete**.
   1. Click **Delete**.

- {{ TF }}

   {% include [terraform-delete](../../_includes/data-transfer/terraform-delete-transfer.md) %}

{% endlist %}
