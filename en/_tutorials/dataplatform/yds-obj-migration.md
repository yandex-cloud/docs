

With {{ data-transfer-name }}, you can transfer data from a [stream in {{ yds-name }}](../../data-streams/concepts/glossary.md#stream-concepts) to a {{ objstorage-full-name }} bucket.

1. [Set up a data stream in {{ yds-name }}](#prepare-source).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ ydb-name }} database (see [{{ ydb-name }} pricing](../../ydb/pricing/index.md)). Its cost depends on the deployment mode:

	* In serverless mode, you pay for data operations and storage volume, including stored backups.
  	* In dedicated instance mode, you pay for the use of computing resources allocated to the database, storage size, and backups.

* {{ yds-name }} (see [{{ yds-name }} pricing](../../data-streams/pricing.md)). The cost depends on the pricing model:

    * [Based on allocated resources](../../data-streams/pricing.md#rules): You pay a fixed hourly rate for the established throughput limit and message retention period, and additionally for the number of units of actually written data.
    * [On-demand](../../data-streams/pricing.md#on-demand): You pay for the performed read/write operations, the amount of read or written data, and the actual storage used for messages that are still within their retention period.

* {{ objstorage-name }} bucket: Use of storage, data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) of your preferred configuration.

    1. [Create a bucket in {{ objstorage-full-name }}](../../storage/operations/buckets/create.md).

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-transfer-yds-obj.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-yds-to-object-storage/blob/main/data-transfer-yds-obj.tf) configuration file to the same working directory.

        This file describes:

        * {{ ydb-name }} database.
        * Service account with the `yds.editor`, `storage.editor`, and `storage.uploader` roles.
        * Bucket in {{ objstorage-name }}.
        * Transfer.

    1. In the `data-transfer-yds-obj.tf` file, specify the following:

        * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) for the new resources.
        * `sa_name`: Name of the service account for creating a bucket and for use in endpoints.
        * `source_db_name`: {{ ydb-name }} database name.
        * `bucket_name`: {{ objstorage-name }} bucket name.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up a data stream in {{ yds-name }} {#prepare-source}

1. [Create a data stream in {{ yds-name }}](../../data-streams/operations/aws-cli/create.md).

1. [Send test data to this stream](../../data-streams/operations/aws-cli/send.md). Use the car sensor data in JSON format as the message:

```json
{
    "device_id":"iv9a94th6rzt********",
    "datetime":"2020-06-05T17:27:00",
    "latitude":"55.70329032",
    "longitude":"37.65472196",
    "altitude":"427.5",
    "speed":"0",
    "battery_voltage":"23.5",
    "cabin_temperature":"17",
    "fuel_level":null
}
```

## Set up and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ yds-full-name }}`.
    * **Endpoint settings**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.connection.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}**: Select your {{ ydb-name }} database from the list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}**: Specify the name of the stream in {{ yds-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}**: Select an existing service account or create a new one with the `yds.editor` role.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.advanced_settings.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**: `JSON`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`:

                Create and upload a data schema file in JSON format, `json_schema.json`:

                {% cut "json_schema.json" %}

                ```json
                [
                    {
                        "name": "device_id",
                        "type": "string"
                    },
                    {
                        "name": "datetime",
                        "type": "datetime"
                    },
                    {
                        "name": "latitude",
                        "type": "double"
                    },
                    {
                        "name": "longitude",
                        "type": "double"
                    },
                    {
                        "name": "altitude",
                        "type": "double"
                    },
                    {
                        "name": "speed",
                        "type": "double"
                    },
                    {
                        "name": "battery_voltage",
                        "type": "any"
                    },
                    {
                        "name": "cabin_temperature",
                        "type": "double"
                    },
                    {
                        "name": "fuel_level",
                        "type": "any"
                    }
                ]
                ```

                {% endcut %}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ objstorage-name }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageEndpoint.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}**: Enter the {{ objstorage-name }} bucket name.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}**: Select an existing service account or create a new one with the `storage.uploader` role.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}**: Select `JSON` or `CSV` if you have enabled **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}** in the advanced settings for the source endpoint.

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}** type that will use the endpoints you created.
        1. [Activate](../../data-transfer/operations/transfer.md#activate) the transfer.

    - {{ TF }} {#tf}

        1. In the `data-transfer-yds-obj.tf` file, uncomment the following:

            * Variables:

                * `source_endpoint_id`, and set it to the source endpoint ID.
                * `target_endpoint_id`, and set it to the target endpoint ID.

            * `yandex_datatransfer_transfer` resource.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            The transfer will be activated automatically upon creation.

    {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Make sure the data from the stream in {{ yds-name }} has moved to the {{ objstorage-name }} bucket:

    1. In the [management console]({{ link-console-main }}), select the folder with the bucket.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Select the bucket from the list.
    1. Make sure the bucket contains the `<stream_name>_0.raw` file (`.json` or `.csv`, depending on the selected output format) with the test data.

1. [Send a new message to your stream in {{ yds-name }}](../../data-streams/operations/aws-cli/send.md):

    ```json
    {
        "device_id": "rhibbh3y08qm********",
        "datetime": "2020-06-06 09:49:54",
        "latitude": 55.71294467,
        "longitude": 37.66542005,
        "altitude": 429.13,
        "speed": 55.5,
        "battery_voltage": null,
        "cabin_temperature": 18,
        "fuel_level": 32
    }
    ```

1. Make sure the {{ objstorage-name }} bucket contains the new data:

    1. In the [management console]({{ link-console-main }}), select the folder with the bucket.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Select the bucket from the list.
    1. Make sure the bucket now contains the `<stream_name>_0-1_1.raw` file (`.json` or `.csv`, depending on the selected output format) with the new data.

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

To reduce the consumption of resources, delete those you do not need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete](../../data-transfer/operations/endpoint/index.md#delete) the source and target endpoints.
1. [Delete the objects](../../storage/operations/objects/delete.md) from the {{ objstorage-name }} bucket.
1. Delete the other resources depending on how you created them:

   {% list tabs group=instructions %}

   - Manually {#manual}

       1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
       1. [Delete the bucket in {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
       1. If you created any service accounts when setting up your endpoints, [delete them](../../iam/operations/sa/delete.md).

   - {{ TF }} {#tf}

       {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}
