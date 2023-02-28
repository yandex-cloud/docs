With {{ data-transfer-name }}, you can move data from a [{{ yds-name }} data stream](../../data-streams/concepts/glossary.md#stream-concepts) to an {{ objstorage-name }} bucket.

1. [Prepare a {{ yds-name }} data stream](#prepare-source).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

* Manually

   1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration.

   1. [Create a bucket in {{ objstorage-name }}](../../storage/operations/buckets/create.md).

* Using {{ TF }}

   1. If you don't have {{ TF }}, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the configuration file [data-transfer-yds-obj.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-yds-obj.tf) to the same working directory.

      This file describes:

      * {{ ydb-name }} database.
      * A service account with the `yds.editor`, `storage.editor`, and `storage.uploader` roles.
      * Bucket in {{ objstorage-name }}.
      * Transfer.

   1. In the `data-transfer-yds-obj.tf` file, specify:

      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create resources in.
      * `sa_name`: Name of the service account to create a bucket in and use in endpoints.
      * `source_db_name`: {{ ydb-name }} database name.
      * `bucket_name`: {{ objstorage-name }} bucket name.

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

## Prepare a {{ yds-name }} data stream {#prepare-source}

1. [Create a {{ yds-name }} data stream](../../data-streams/operations/aws-cli/create.md).

1. [Send test data to the data stream](../../data-streams/operations/aws-cli/send.md). Use data from the vehicle's sensors in JSON format as a message:

```json
{
    "device_id":"iv9a94th6rztooxh5ur2",
    "datetime":"2020-06-05 17:27:00",
    "latitude":"55.70329032",
    "longitude":"37.65472196",
    "altitude":"427.5",
    "speed":"0",
    "battery_voltage":"23.5",
    "cabin_temperature":"17",
    "fuel_level":null
}
```

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **Database type**: `{{ yds-full-name }}`.
   * **Endpoint parameters**:

      * **Connection settings**:

         * **Database**: Select a {{ ydb-name }} database from the list.
         * **Data stream**: Specify the name of the {{ yds-name }} data stream.
         * **Service account**: Select or create a service account with the `yds.editor` role.

      * (optional) **Advanced settings** → **Conversions rules**:

         * **Data format**: `JSON`.
         * **Data schema** — `JSON specification`:

            Create and upload the `json_schema.json` file in JSON format:

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

   * **Database type**: `{{ objstorage-name }}`.
   * **Endpoint parameters**:

      * **Connection settings**:

         * **Bucket**: Specify the name of the bucket {{ objstorage-name }}.
         * **Service account**: Select or create a service account with the `storage.uploader` role.

      * **Output format**: Select `JSON` or `CSV` if you have enabled **Conversion rules** in the source endpoint settings.

1. Create a transfer:

   {% list tabs %}

   * Manually

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-repl }}_ type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) it.

   * Using {{ TF }}

      1. In the `data-transfer-yds-obj.tf` file, uncomment:

         * Variables:

            * `source_endpoint_id` and set it to the value of the endpoint ID for the source.
            * `target_endpoint_id` and set it to the value of the endpoint ID for the target.

         * `yandex_datatransfer_transfer` resource.

      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         Once created, a transfer is activated automatically.

   {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to {{ dt-status-repl }}.

1. Make sure that the data from the {{ yds-name }} stream has been moved to the bucket {{ objstorage-name }}:

   1. In the [management console]({{ link-console-main }}), select the folder where the bucket is located.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Select the bucket from the list.
   1. Check that the bucket includes the file `<stream name>_0.raw` (`.json` or `.csv`, depending on the selected output format) with the test data.

1. Send a new message [to a {{ yds-name }} stream](../../data-streams/operations/aws-cli/send.md):

   ```json
   {
       "device_id": "rhibbh3y08qmz3sdbrbu",
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

1. Make sure that the following data has been added to the {{ objstorage-name }} bucket:

   1. In the [management console]({{ link-console-main }}), select the folder where the bucket is located.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Select the bucket from the list.
   1. Make sure that the file `<stream name>_0.raw` (`.json` or `.csv`, depending on the selected output format) has been added to the bucket and includes the new data.

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [disable the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

If you no longer need these resources, delete them:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for the source and target.
1. [Delete](../../storage/operations/objects/delete.md) the objects from the {{ objstorage-name }} bucket:

Delete the other resources, depending on the method used to create them:

{% list tabs %}

* Manually

   * [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
   * [Delete the bucket in {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
   * If you created service accounts when creating endpoints, [delete them](../../iam/operations/sa/delete.md).

* Using {{ TF }}

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the configuration file `data-transfer-yds-obj.tf`.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources defined in the `data-transfer-yds-obj.tf` configuration file will be deleted.

{% endlist %}
