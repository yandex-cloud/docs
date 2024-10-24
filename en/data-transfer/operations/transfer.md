---
title: How to manage transfers in {{ data-transfer-full-name }}
description: Follow this guide to manage a transfer.
---

# Managing transfer process

You can:
* [Get a list of transfers](#list).
* [Get detailed information about a transfer](#get).
* [Create a transfer](#create).
* [Update a transfer](#update).
* [Activate a transfer](#activate).
* [Deactivate a transfer](#deactivate).
* [Delete a transfer](#delete).

For more information about [transfer](../concepts/index.md#transfer) states, possible operations on transfers, and existing limits, see [{#T}](../concepts/transfer-lifecycle.md).

To move a transfer and [endpoints](../concepts/index.md#endpoint) to a different [availability zone](../../overview/concepts/geo-scope.md), follow [this guide](endpoint/migration-to-an-availability-zone.md).

## Getting a list of transfers {#list}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of transfers in a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), run the following command:

  ```bash
  {{ yc-dt }} transfer list
  ```

- API {#api}

  Use the [list](../api-ref/Transfer/list.md) API method.

{% endlist %}

## Getting detailed information about a transfer {#get}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Click the required transfer name.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get information about a transfer, run the following command:

    ```bash
    {{ yc-dt }} transfer get <transfer_ID>
    ```

    You can get the transfer ID with a [list of transfers in the folder](#list).

- API {#api}

    Use the [get](../api-ref/Transfer/get.md) API method and provide the transfer ID value in the `transferId` request parameter.

    To find out the transfer ID, [get a list of transfers in the folder](#list).

{% endlist %}

## Creating a transfer {#create}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
  1. Click **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
  1. Select the source endpoint or [create](./endpoint/index.md#create) a new one.
  1. Select the target endpoint or [create](./endpoint/index.md#create) a new one. Make sure the [subnet](../concepts/network.md) specified for the target endpoint belongs to the same availability zone as the subnet for the source endpoint.
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


     * For [billable](../pricing.md) source-target pairs at the [GA](../../overview/concepts/launch-stages.md) stage, you can configure the amount of computing resources per VM in the **Runtime environment** settings section. Select one of the three suggested configurations. The VM resource configuration determines the performance of the data transfer [workers](../concepts/index.md#worker). A separate VM is allocated for each worker. For vCPU and RAM pricing policy, calculation examples, and cost optimization recommendations, see [Pricing policy](../pricing.md).

     * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}**: Specify the full path to each object to transfer. Only objects from this list will be transferred. If you have listed included tables or collections in the source endpoint settings, only objects that are on both these lists will be transfered. If you specify objects not listed among included tables or collections in the source endpoint settings, transfer activation will end with the `$table not found in source` error. This setting is not available for such sources as {{ KF }}, and {{ DS }}.

         Enter the full name of the object. Depending on the source type, use the appropriate naming convention:

         * {{ CH }}: `<database_name>.<table_path>`
         * {{ GP }}: `<schema_name>.<table_path>`
         * {{ MG }}: `<database_name>.<collection_path>`
         * {{ MY }}: `<database_name>.<table_path>`
         * {{ PG }}: `<schema_name>.<table_path>`
         * {{ ydb-short-name }}: table path
         * Oracle: `<schema_name>.<table_path>`.

         If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will end with an error. A running {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfer will terminate immediately; an inactive one will terminate as soon as activated.

     * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}**: [Data transformation](../concepts/data-transformation.md) rules. This setting only appears when the source and target are of different types.

        {% include [list-of-transformers](../../_includes/data-transfer/list-of-transformers.md) %}


    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a transfer:

    1. View a description of the CLI create transfer command:

        ```bash
        {{ yc-dt }} transfer create --help
        ```

    1. Specify the transfer parameters in the create command:

        ```bash
        {{ yc-dt }} transfer create <transfer_name> \
           --source-id=<source_endpoint_ID> \
           --target-id=<target_endpoint_ID> \
           --type=<transfer_type>
        ```

        Where:

        * `--source-id`: Source endpoint ID.
        * `--target-id`: Target endpoint ID.
        * `--type`: [Transfer type](../concepts/transfer-lifecycle.md#transfer-types):
            * `snapshot-only`: [Copy](../concepts/transfer-lifecycle.md#copy).
            * `increment-only`: [Replicate](../concepts/transfer-lifecycle.md#replication).
            * `snapshot-and-increment`: [Copy and replicate](../concepts/transfer-lifecycle.md#copy-and-replication).

        {% note info %}

        The transfer name must be unique within the folder. It may contain Latin letters, numbers, and hyphens. The name may be up to 63 characters long.

        {% endnote %}

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    To create a transfer:

    1. Create a configuration file with a description of your transfer.

       Here is an example of the configuration file structure:

       ```hcl
       resource "yandex_datatransfer_transfer" "<transer_name_in_{{ TF }}>" {
         folder_id   = "<folder_ID>"
         name        = "<transfer_name>"
         description = "<transfer_description>"
         source_id   = "<source_endpoint_ID>"
         target_id   = "<target_endpoint_ID>"
         type        = "<transfer_type>"
       }
       ```

       The available transfer types include:

       * `SNAPSHOT_ONLY`: _{{ dt-type-copy }}_
       * `INCREMENT_ONLY`: _{{ dt-type-repl }}_
       * `SNAPSHOT_AND_INCREMENT`: _{{ dt-type-copy-repl }}_

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-transfer }}).

    When created, `INCREMENT_ONLY` and `SNAPSHOT_AND_INCREMENT` transfers are activated and run automatically.
    If you want to activate a `SNAPSHOT_ONLY` transfer once it is created, add the `provisioner "local-exec"` section with the following transfer activation command to the configuration file:

    ```hcl
       provisioner "local-exec" {
          command = "yc --profile <profile> datatransfer transfer activate ${yandex_datatransfer_transfer.<transfer_Terraform_resource_name>.id
       }
    ```

    In this case, copying will only take place once at the time of transfer creation.

- API {#api}

    Use the [create](../api-ref/Transfer/create.md) API method and include the following information in the request:

    * ID of the folder where the transfer should be placed, in the `folderId` parameter.
    * Transfer name in the `name` parameter.
    * Source endpoint ID in the `sourceId` parameter.
    * Target endpoint ID in the `targetId` parameter.
    * Transfer type in the `type` parameter.

{% endlist %}

## Updating a transfer {#update}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Select a transfer and click ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** in the top panel.
    1. Edit the transfer parameters:
        * **{{ ui-key.yacloud.common.name }}**.
        * **{{ ui-key.yacloud.common.description }}**.
        * For the {{ dt-type-copy }} transfer type:

            * {% include [field periodic snapshot](../../_includes/data-transfer/fields/periodic-snapshot.md) %}

            * {% include [field incremental tables](../../_includes/data-transfer/fields/incremental-tables.md) %}

            * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}

        * For the {{ dt-type-repl }} transfer type:

            * {% include [field parallel repl](../../_includes/data-transfer/fields/parallel-repl.md) %}

        * For the {{ dt-type-copy-repl }} transfer type: {#update-copy-repl}

            * {% include [field parallel copy](../../_includes/data-transfer/fields/parallel-copy.md) %}


       * For the [billable](../pricing.md) source-target pairs at the [GA](../../overview/concepts/launch-stages.md) stage, you can edit the amount of computing resources per VM in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.runtime.title }}** settings section. Select one of the three suggested configurations. The VM resource configuration determines the performance of the data transfer [workers](../concepts/index.md#worker). A separate VM is allocated for each worker. For vCPU and RAM pricing policy, calculation examples, and cost optimization recommendations, see [Pricing policy](../pricing.md).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}**: Specify the full path to each object to transfer. Only objects from this list will be transferred. If you have listed included tables or collections in the source endpoint settings, only objects that are on both these lists will be transfered. If you specify objects not listed among included tables or collections in the source endpoint settings, transfer activation will end with the `$table not found in source` error. This setting is not available for such sources as {{ KF }}, and {{ DS }}.

            Adding new objects to {{ dt-type-copy-repl }} or {{ dt-type-repl }} transfers in the {{ dt-status-repl }} status will result in uploading data history for these objects or tables. If a table is large, uploading the history may take a long time. You cannot edit the list of objects for transfers in the {{ dt-status-copy }} status.

            Enter the full name of the object. Depending on the source type, use the appropriate naming convention:

            * {{ CH }}: `<database_name>.<table_path>`
            * {{ GP }}: `<schema_name>.<table_path>`
            * {{ MG }}: `<database_name>.<collection_path>`
            * {{ MY }}: `<database_name>.<table_path>`
            * {{ PG }}: `<schema_name>.<table_path>`
            * {{ ydb-short-name }}: table path
            * Oracle: `<schema_name>.<table_path>`.

            If the specified object is on the excluded table or collection list in the source endpoint settings, or the object name was entered incorrectly, the transfer will end with an error. A running {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfer will terminate immediately; an inactive one will terminate as soon as activated.

        * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}**: [Data transformation](../concepts/data-transformation.md) rules. This setting only appears when the source and target are of different types.

           {% include [list-of-transformers](../../_includes/data-transfer/list-of-transformers.md) %}


    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update the transfer settings:

    1. View a description of the update transfer CLI command:

        ```bash
        {{ yc-dt }} transfer update --help
        ```

    1. Run the following command with a list of settings to update:

        ```bash
        {{ yc-dt }} transfer update <transfer_ID> \
           --name=<transfer_name> \
           --description=<transfer_description>
        ```

        You can get the transfer ID with a [list of transfers in the folder](#list).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the transfer description.

      For information on creating a transfer like this, please review [Create transfer](#create).

  1. Edit the values in the `name` and the `description` fields (transfer name and description).
  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-transfer }}).

- API {#api}

    Use the [update](../api-ref/Transfer/update.md) API method and include the following in the request:

    * Transfer ID in the `transferId` parameter. To find out the ID, [get a list of transfers in the folder](#list).
    * Transfer name in the `name` parameter.
    * Transfer description in the `description` parameter.
    * List of transfer configuration fields to update in the `updateMask` parameter.

    {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

When updating a transfer, its settings are applied immediately. Editing {{ dt-type-copy-repl }} or {{ dt-type-repl }} transfer settings with the {{ dt-status-repl }} status will result in restarting the transfer.

## Activating a transfer {#activate}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the name of the transfer you need and select **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To activate a transfer, run this command:

    ```bash
    {{ yc-dt }} transfer activate <transfer_ID>
    ```

    You can get the transfer ID with a [list of transfers in the folder](#list).

- API {#api}

    Use the [activate](../api-ref/Transfer/activate.md) API method and provide the transfer ID in the `transferId` request parameter.

    To find out the transfer ID, [get a list of transfers in the folder](#list).

{% endlist %}


{% include [мобильное приложение](../../_includes/data-transfer/use-mobile-app.md) %}


## Deactivating a transfer {#deactivate}

During transfer deactivation:

* The replication slot on the source is disabled.
* Temporary data transfer logs are deleted.
* The target is brought into the aligned state:
    * The data schema objects of the source are transferred for the final stage.
    * Indexes are created.

{% list tabs group=instructions %}

- Management console {#console}

    1. Switch the source to <q>read-only</q>.
    1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the name of the transfer you need and select **{{ ui-key.yacloud.data-transfer.label_connector-operation-DEACTIVATE }}**.
    1. Wait for the transfer status to change to {{ dt-status-stopped }}.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To deactivate a transfer, run this command:

    ```bash
    {{ yc-dt }} transfer deactivate <transfer_ID>
    ```

    You can get the transfer ID with a [list of transfers in the folder](#list).

- API {#api}

    Use the [deactivate](../api-ref/Transfer/deactivate.md) API method and provide the transfer ID in the `transferId` request parameter.

    To find out the transfer ID, [get a list of transfers in the folder](#list).

{% endlist %}

{% note warning %}

Do not interrupt the deactivation of the transfer! If the process fails, the performance of the source and target is not guaranteed.

{% endnote %}

For more information, see [{#T}](../concepts/transfer-lifecycle.md).


{% include [мобильное приложение](../../_includes/data-transfer/use-mobile-app.md) %}


## Deleting a transfer {#delete}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ data-transfer-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
    1. If the transfer you need is active, [deactivate it](#deactivate).
    1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the name of the transfer you need and select **{{ ui-key.yacloud.common.remove }}**.
    1. Click **{{ ui-key.yacloud.common.remove }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete a transfer, run this command:

    ```bash
    {{ yc-dt }} transfer delete <transfer_ID>
    ```

    You can get the transfer ID with a [list of transfers in the folder](#list).

- {{ TF }} {#tf}

    {% include [terraform-delete](../../_includes/data-transfer/terraform-delete-transfer.md) %}

- API {#api}

    Use the [delete](../api-ref/Transfer/delete.md) API method and provide the transfer ID in the `transferId` request parameter.

    To find out the transfer ID, [get a list of transfers in the folder](#list).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
