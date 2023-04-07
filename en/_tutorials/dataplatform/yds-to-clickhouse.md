# Saving a {{ yds-full-name }} data stream in {{ mch-full-name }}

With {{ data-transfer-name }}, you can deliver data from a [{{ yds-name }} data stream](../../data-streams/concepts/glossary.md#stream-concepts) to {{ mch-name }}.

To transfer data:

1. [Prepare a {{ yds-name }} data stream](#prepare-source).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need these resources, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

* Manually

   1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration.
   1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with any suitable configuration.
   1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

      * **Database type**: `{{ CH }}`.
      * **Endpoint parameters**:

         * **Connection settings**:

            * **Connection settings**: `{{ mch-name }} cluster`.

               * **{{ mch-name }} cluster**: Select the source cluster from the list.

            * **Database**: Enter the name of the database.
            * **User** and **Password**: Enter the name and password of the user who has access to the database, for example, the database owner.

* Using {{ TF }}

   1. If you don't have {{ TF }}, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).

   1. Download the configuration file [data-transfer-yds-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-yds-mch.tf) to the same working directory.

      This file describes:

      * {{ ydb-name }} database.
      * Service account with the `yds.editor` role.
      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security group](../../vpc/concepts/security-groups.md) and rules required to connect to the {{ mch-name }} cluster from the internet.
      * {{ mch-name }} target cluster.
      * Target endpoint.
      * Transfer.

   1. Specify in the file `data-transfer-yds-mch.tf`:

      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create resources in.
      * `sa_name`: The name of the service account to be used in endpoints.
      * `source_db_name`: {{ ydb-name }} database name.
      * `target_db_name`: {{ CH }} database name.
      * `target_user` and `target_password`: {{ CH }} database owner username and password.
      * `transfer_enabled`: Set `0` to ensure that no transfer is created before [a source endpoint is created manually](#prepare-transfer).

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
    "datetime":"2022-06-05 17:27:00",
    "latitude":55.70329032,
    "longitude":37.65472196,
    "altitude":427.5,
    "speed":0,
    "battery_voltage":"23.5",
    "cabin_temperature":17,
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

      * **Advanced settings** → **Conversion rules**:

         * **Data format**: `JSON`.
         * **Data schema**: You can specify a schema in two ways:
            * `Field list`.

               Set a list of topic fields manually:

               | Name | Type | Key |
               | :-- | :-- | :--- |
               | `device_id` | `STRING` | Yes |
               | `datetime` | `DATETIME` |  |
               | `latitude` | `DOUBLE` |  |
               | `longitude` | `DOUBLE` |  |
               | `altitude` | `DOUBLE` |  |
               | `speed` | `DOUBLE` |  |
               | `battery_voltage` | `ANY` |
               | `cabin_temperature` | `DOUBLE` |
               | `fuel_level` | `ANY` |

            * `JSON specification`.

               Create and upload the `json_schema.json` file in JSON format:

               {% cut "json_schema.json" %}

               ```json
               [
                   {
                       "name": "device_id",
                       "type": "string",
                       "key": true
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

1. Create a transfer:

   {% list tabs %}

   * Manually

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the {{ dt-type-repl }} type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) it.

   * Using {{ TF }}

      1. Specify the variables in the file `data-transfer-yds-mch.tf`:

         * `source_endpoint_id`: ID of the source endpoint.
         * `transfer_enabled`: Set `1` to enable transfer creation.

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

1. [Send a new message to the data stream](../../data-streams/operations/aws-cli/send.md) {{ yds-name }}:

   ```json
   {
       "device_id":"rhibbh3y08qmz3sdbrbu",
       "datetime":"2022-06-06 09:49:54",
       "latitude":55.71294467,
       "longitude":37.66542005,
       "altitude":429.13,
       "speed":55.5,
       "battery_voltage":null,
       "cabin_temperature":18,
       "fuel_level":32
   }
   ```

1. Make sure that the data from the {{ yds-name }} data stream has been moved to the {{ mch-name }} cluster database:

   1. [Connect to the {{ mch-name }} target cluster](../../managed-clickhouse/operations/connect.md).
   1. Check that the {{ CH }} database contains a table with the name of the [created {{ yds-name }} data stream](#prepare-source) with the same columns as the [data schema in the source endpoint](#prepare-transfer) and the sent test data.

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [disable the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. Delete the resources depending on how they were created:

   {% list tabs %}

   * Manually

      * [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
      * [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
      * [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).

   * Using {{ TF }}

      1. In the terminal window, change to the directory containing the infrastructure plan.
      1. Delete the configuration file `data-transfer-yds-mch.tf`.
      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the update of resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the configuration file `data-transfer-yds-mch.tf` will be deleted.

   {% endlist %}

1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
