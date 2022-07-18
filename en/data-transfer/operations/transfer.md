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

      * Transfer name.
      * (Optional) Description of the transfer.
      * Transfer type:

         * `{{ dt-type-copy-repl }}`: To create a full copy of the source data and keep it up-to-date.
         * `{{ dt-type-copy }}`: To create a full copy of the data without receiving further updates from the source.
         * `{{ dt-type-repl }}`: To continuously receive data updates from the source and apply them to the target (without creating a full copy of the source data).

      * (Optional) List of objects to transfer: only objects on this list will transfer. If you specified a list of included tables or collections in the source endpoint settings, only objects on both the lists will transfer.

         Enter the full name of the object. Depending on the source type, use the appropriate naming convention:

         * {{ CH }}: `<database name>.<table name>`.
         * {{ GP }}: `<database name>.<schema name>.<table name>`.
         * {{ MG }}: `<database name>.<collection name>`.
         * {{ MY }}: `<database name>.<table name>`.
         * {{ PG }}: `<database name>.<schema name>.<table name>`.

         If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will return an error. A running transfer with **{{ dt-type-repl }}** or **{{ dt-type-copy-repl }}** as its status will terminate immediately while an inactive transfer will exit once it is activated.

   1. Click **Create**.

- Terraform

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

   A transfer activates automatically after changes are applied.

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-transfer }}).

{% endlist %}

## Updating a transfer {#update}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/data-transfer/transfer.svg) **Transfers**.
   1. Select a transfer and click ![pencil](../../_assets/pencil.svg) **Edit** on the top panel.
   1. Edit the transfer parameters:

      * Transfer name.
      * Transfer description.
      * List of objects to transfer: only objects on this list will transfer. If you specified a list of included tables or collections in the source endpoint settings, only objects on both the lists will transfer.

         Enter the full name of the object. Depending on the source type, use the appropriate naming convention:

         * {{ CH }}: `<database name>.<table name>`.
         * {{ GP }}: `<database name>.<schema name>.<table name>`.
         * {{ MG }}: `<database name>.<collection name>`.
         * {{ MY }}: `<database name>.<table name>`.
         * {{ PG }}: `<database name>.<schema name>.<table name>`.

         If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will return an error. A running transfer with **{{ dt-type-repl }}** or **{{ dt-type-copy-repl }}** as its status will terminate immediately while an inactive transfer will exit once it is activated.

   1. Click **Save**.

- Terraform

   1. Open the current {{ TF }} configuration file with the transfer description.

      For information on creating a transfer like this, please review [Create transfer](#create).

   1. Edit the values in the `name` and the `description` fields (transfer name and description).
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-transfer }}).

{% endlist %}

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

- Terraform

   {% include [terraform-delete](../../_includes/data-transfer/terraform-delete-transfer.md) %}

{% endlist %}
