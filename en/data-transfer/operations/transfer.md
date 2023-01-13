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
      * (Optional) **Transfer description**.
      * **Transfer type**:

         * {{ dt-type-copy-repl }}: To create a full copy of the source data and keep it up-to-date.
         * {{ dt-type-copy }}: To create a full copy of the data without receiving further updates from the source. You can also use this type to [replicate constantly changing tables](../concepts/transfer-lifecycle.md#select-transfer-type).
         * {{ dt-type-repl }}: To continuously receive data updates from the source and apply them to the target (without creating a full copy of the source data).

      * (Optional) **Runtime environment** (system type and parameters for running a transfer):

         * **{{ yandex-cloud }}**:

            * **Sharded copying parameters** are parameters for parallel reading from tables to increase transfer bandwidth. For the {{ PG }} source, parallel reading is only available for tables that contain a primary key in [serial mode](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).

               * **Number of instances** is the number of VM instances in {{ compute-full-name }} that the transfer will be run on. We recommend a value between 2 and 8.
               * **Number of processes** is the number of threads to run the transfer in the instance. We recommend a value between 4 and 8.
      * (Optional) **Copying** is the frequency of activating _{{ dt-type-copy }}_ transfers:

         * **Once**.
         * **Regularly**:

            * **Interval** is the period of time between transfer activations. It's counted from the last transfer activation, regardless of the way it's run: manually or by schedule. If the transfer duration exceeds the specified period, the next activation is run after the previous one is completed.
            * **Incremental tables** (list of tables that have a cursor field for incremental copies). Specify the **Table namespace**, **Table name**, **Cursor column**, and **Initial state** (optional). The transfer will remember the maximum value of the cursor column and, during the next activation, will only read the data added or updated since the last run. This is more effective than copying entire tables but less affective than using transfers of the _{{ dt-type-copy-repl }}_ type.

               {% include [postgresql-cursor-serial](../../_includes/data-transfer/serial-increment-cursor.md) %}

      * (Optional) **Data transformations** are rules for transforming data:

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

      * (Optional) **List of objects to transfer**: only objects on this list will transfer. If you specified a list of included tables or collections in the source endpoint settings, only objects on both the lists will transfer.

         Enter the full name of the object. Depending on the source type, use the appropriate naming convention:
​
         * {{ CH }}: `<database name>.<table name>`.
         * {{ GP }}: `<schema name>.<table name>`.
         * {{ MG }}: `<database name>.<collection name>`.
         * {{ MY }}: `<database name>.<table name>`.
         * {{ PG }}: `<schema name>.<table name>`.

         If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will return an error. A running transfer with **{{ dt-type-repl }}** or **{{ dt-type-copy-repl }}** as its status will terminate immediately while an inactive transfer will exit once it is activated.

   1. Click **Create**.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   To create a transfer:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

      1. If you don't have {{ TF }} yet, [install it and create a configuration file with provider settings](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
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
      * **Transfer description**.
      * **Runtime environment** (system type and parameters for starting a transfer):

         * {{ yandex-cloud }}:

            * **Sharded copying parameters** are parameters for parallel reading from tables to increase transfer bandwidth. Parallel reading is only available for tables that contain a primary key in [serial mode](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).

               * The number of instances is the number of virtual machines in {{ compute-full-name }} that the transfer will be run on. We recommend a value between 2 and 8.
               * The number of processes is the number of streams to run the transfer in the instance. We recommend a value between 4 and 8.

      * **Copying** is the frequency of activating _{{ dt-type-copy }}_ transfers:

         * **Once**.
         * **Regularly**:

            * **Interval** is the period of time between transfer activations. It's counted from the last transfer activation, regardless of the way it's run: manually or by schedule. If the transfer duration exceeds the specified period, the next activation is run after the previous one is completed.
            * **Incremental tables** (list of tables that have a cursor field for incremental copies). Specify the **Table namespace**, **Table name**, **Cursor column**, and **Initial state** (optional). The transfer will remember the maximum value of the cursor column and, during the next activation, will only read the data added or updated since the last run. This is more effective than copying entire tables but less affective than using transfers of the _{{ dt-type-copy-repl }}_ type.

               {% include [postgresql-cursor-serial](../../_includes/data-transfer/serial-increment-cursor.md) %}

      * **Data transformations** are rules for transforming data:

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

      * **List of objects to transfer**: only objects on this list will transfer. If you specified a list of included tables or collections in the source endpoint settings, only objects on both the lists will transfer.

         Enter the full name of the object. Depending on the source type, use the appropriate naming convention:

         * {{ CH }}: `<database name>.<table name>`.
         * {{ GP }}: `<schema name>.<table name>`.
         * {{ MG }}: `<database name>.<collection name>`.
         * {{ MY }}: `<database name>.<table name>`.
         * {{ PG }}: `<schema name>.<table name>`.

         If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will return an error. A running transfer with **{{ dt-type-repl }}** or **{{ dt-type-copy-repl }}** as its status will terminate immediately while an inactive transfer will exit once it is activated.

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

When updating a transfer, its settings are applied immediately. Editing the settings of a transfer with the {{ dt-type-repl }} type and the {{ dt-status-repl }} status will result in the transfer's restart. Adding new objects to the **List of objects to transfer** for {{ dt-type-copy-repl }} transfers in the {{ dt-status-repl }} status will result in uploading the data history for these objects (tables). If a table is large, uploading the history may take a long time.
You can't edit the list of objects for transfers in the {{ dt-status-copy }} status.

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
