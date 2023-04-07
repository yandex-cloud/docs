# Delivering data from {{ mmy-full-name }} to {{ objstorage-full-name }} using {{ data-transfer-full-name }}

With {{ data-transfer-name }}, you can transfer data from a {{ mmy-name }} source cluster to {{ objstorage-name }} object storage.

To transfer data:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need these resources, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

* Manually

   1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md) with any suitable configuration.
   1. [Create a bucket in {{ objstorage-name }}](../../storage/operations/buckets/create.md).

* Using {{ TF }}

   1. If you don't have {{ TF }}, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the configuration file [data-transfer-mmy-objs.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mmy-objs.tf) to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a {{ mmy-name }} cluster.
      * {{ mmy-name }} source cluster.
      * A service account with the `editor`, `storage.editor`, and `storage.uploader` roles.
      * An {{ objstorage-name }} bucket
      * Source endpoint.
      * Transfer.

   1. Specify in the `data-transfer-mmy-objs.tf` file:

      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create resources in.
      * `sa_name`: Name of the service account to create a bucket in and use in the target endpoint.
      * `bucket_name`: {{ objstorage-name }} bucket name.
      * Parameters of the {{ mmy-name }} source cluster that are also used as the [source endpoint parameters](../../data-transfer/operations/endpoint/source/mysql.md#managed-service):

         * `source_mysql_version`: {{ MY }} version.
         * `source_db_name`: Database name.
         * `source_user` and `source_password`: Database owner username and password.
      * `transfer_enabled`: Set `0` to ensure that no transfer is created before [creating a target endpoint manually](#prepare-transfer).

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

## Prepare the source cluster {#prepare-source}

1. If you created the infrastructure manually, [prepare the source cluster](../../data-transfer/operations/prepare.md#source-my).

1. [Connect to the {{ mmy-name }} source cluster](../../managed-mysql/operations/connect.md).

1. Add test data to the database. As an example, we'll use a table with information transmitted by car sensors.

   Create a table:

   ```sql
   CREATE TABLE measurements (
       device_id varchar(200) NOT NULL,
       datetime timestamp NOT NULL,
       latitude real NOT NULL,
       longitude real NOT NULL,
       altitude real NOT NULL,
       speed real NOT NULL,
       battery_voltage real,
       cabin_temperature real NOT NULL,
       fuel_level real,
       PRIMARY KEY (device_id)
   );
   ```

   Populate the table with data:

   ```sql
   INSERT INTO measurements VALUES
       ('iv9a94th6rztooxh5ur2', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
       ('rhibbh3y08qmz3sdbrbu', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
   ```

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **Database type**: `{{ objstorage-name }}`.
   * **Endpoint parameters**:

      * **Connection settings**:

         * **Bucket**: Specify the name of the {{ objstorage-name }} bucket.
         * **Service account**: Select or create a service account with the `storage.uploader` role.

      * **Directory name**: `measurements`.

1. Create a source endpoint and transfer:

   {% list tabs %}

   * Manually

      1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

         * **Database type**: `{{ MY }}`.
         * **Endpoint parameters**:

            * **Connection settings**:
               * **Connection settings**: `{{ mmy-name }} cluster`.

                  Select a source cluster from the list and specify the cluster connection settings.

            * (Optional) **List of included tables**, **List of excluded tables**: Specify regular expressions for tables to be transferred and those that shouldn't be transferred.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy }}_ type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) it.

   * Using {{ TF }}

      1. In the `data-transfer-mmy-objs.tf` file, specify the variables:

         * `target_endpoint_id`: ID of the target endpoint.
         * `transfer_enabled`: Set `1` to enable transfer creation.
         * (Optional) `include_tables_regex`, `exclude_tables_regex`: Regular expressions for the tables to be transferred and those not to be transferred.

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

1. Wait for the transfer status to change to {{ dt-status-finished }}.
1. Make sure the data has been moved from the {{ mmy-name }} source cluster to the {{ objstorage-name }} bucket:

   1. In the [management console]({{ link-console-main }}), select the folder where the desired bucket is located.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Select the bucket from the list.
   1. Go to the **Objects** tab.
   1. Check that the {{ objstorage-name }} bucket contains the `measurements` folder with the `<source cluster DB name>_measurements` object with the test data.

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [disable the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).

Delete the other resources, depending on the method used to create them:

{% list tabs %}

* Manually

   1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
   1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
   1. [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).
   1. If you created the service account along with the target endpoint, [delete it](../../iam/operations/sa/delete.md).

* Using {{ TF }}

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-mmy-objs.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `data-transfer-mmy-objs.tf` configuration file will be deleted.

{% endlist %}
