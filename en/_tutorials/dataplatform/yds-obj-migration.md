

With {{ data-transfer-name }}, you can transfer data from a [{{ yds-name }}-enabled stream](../../data-streams/concepts/glossary.md#stream-concepts) to an {{ objstorage-full-name }} bucket.

1. [Set up a stream in {{ yds-name }}](#prepare-source).
1. [Set up and activate your transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for the {{ ydb-name }} database. The charge depends on the usage mode:

	* For the serverless mode, you pay for data operations and the amount of stored data.
	* For the dedicated instance mode, you pay for the use of computing resources, dedicated DBs, and disk space.
	
    Learn more about the [{{ ydb-name }} pricing](../../ydb/pricing/index.md) plans.

* {{ yds-name }} fee. The fee depends on the pricing mode:

	* Based on allocated resources: You pay for the number of units of written data and resources allocated for data streaming.
	* Based on actual use:
		* If the DB operates in serverless mode, the data stream is charged under the [{{ ydb-short-name }} serverless mode pricing policy](../../ydb/pricing/serverless.md).

		* If the DB operates in dedicated instance mode, the data stream is not charged separately (you only pay for the DB, see the [pricing policy](../../ydb/pricing/dedicated)).

    Learn more about the [{{ yds-name }} pricing](../../data-streams/pricing.md) plans.

* {{ objstorage-name }} bucket fee: Storing data and performing operations with it (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration.

    1. [Create a bucket in {{ objstorage-full-name }}](../../storage/operations/buckets/create.md).

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-transfer-yds-obj.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-yds-to-object-storage/blob/main/data-transfer-yds-obj.tf) configuration file to the same working directory.

        This file describes:

        * Database: {{ ydb-name }}.
        * Service account with the `yds.editor`, `storage.editor`, and `storage.uploader` roles.
        * Bucket in {{ objstorage-name }}.
        * Transfer.

    1. Specify the following in the `data-transfer-yds-obj.tf` file:

        * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) where you will create the resources.
        * `sa_name`: Name of the service account for creating a bucket and for use in endpoints.
        * `source_db_name`: {{ ydb-name }} database name.
        * `bucket_name`: Bucket name in {{ objstorage-name }}.

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up a {{ yds-name }}-enabled stream {#prepare-source}

1. [Create a {{ yds-name }}-enabled stream](../../data-streams/operations/aws-cli/create.md).

1. [Send test data to the data stream](../../data-streams/operations/aws-cli/send.md). Use data from the vehicle sensors in JSON format as a message:

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

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}**: Select the {{ ydb-name }} database from the list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}**: Specify the name of the {{ yds-name }}-enabled stream.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}**: Select or create a service account with the `yds.editor` role.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.advanced_settings.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**: `JSON`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`:

                Create and upload a `json_schema.json` data schema file:

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

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}**: Enter the name of the bucket in {{ objstorage-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}**: Select or create a service account with the `storage.uploader` role.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}**: Select `JSON` or `CSV` if you have enabled **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}** in the advanced settings for the source endpoint.

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}** type that will use the created endpoints.
        1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

    - {{ TF }} {#tf}

        1. In the `data-transfer-yds-obj.tf` file, uncomment the following:

            * Variables:

                * `source_endpoint_id`, and set it to the endpoint ID value for the source.
                * `target_endpoint_id`, and set it to the endpoint ID value for the target.

            * `yandex_datatransfer_transfer` resource.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Once created, your transfer will be activated automatically.

    {% endlist %}

## Test your transfer {#verify-transfer}

1. Wait until the transfer status switches to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Make sure the data from the {{ yds-name }}-enabled stream has been moved to the {{ objstorage-name }} bucket:

    1. In the [management console]({{ link-console-main }}), select the folder the bucket is in.
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Select the bucket from the list.
    1. Make sure the bucket contains the `<stream_name>_0.raw` file (`.json` or `.csv`, depending on the selected output format) with the test data.

1. [Send a new message to the {{ yds-name }}-enabled stream](../../data-streams/operations/aws-cli/send.md):

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

1. Make sure the following data has been added to the {{ objstorage-name }} bucket:

    1. In the [management console]({{ link-console-main }}), select the folder the bucket is in.
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Select the bucket from the list.
    1. Make sure the bucket now contains the `<stream_name>_0-1_1.raw` file (`.json` or `.csv`, depending on the selected output format) with the new data.

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources you created, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.
1. [Delete](../../storage/operations/objects/delete.md) the objects from the {{ objstorage-name }} bucket:

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
    * [Delete the bucket in {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
    * If you created any service accounts when setting up your endpoints, [delete them](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
