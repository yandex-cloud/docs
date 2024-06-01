# Migrating data from {{ objstorage-name }} to a {{ mmy-full-name }} cluster using {{ data-transfer-full-name }}


With {{ data-transfer-name }}, you can transfer data from an {{ objstorage-name }} object storage to a {{ mmy-name }} target cluster.

To transfer data:

1. [Prepare the test data](#prepare-data).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs group=resources %}

- Manually {#manual}

   1. [Create an {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md).

   1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `storage-viewer` with the `storage.viewer` role. The transfer will use it to access the bucket.
   1. [Create a static access key](../../iam/operations/sa/create-access-key.md) for the `storage-viewer` service account.

   1. [Create a {{ mmy-name }} target cluster](../../managed-mysql/operations/cluster-create.md) in any suitable configuration with the following settings:

      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mmy-user`
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<user_password>`

   1. [Assign the {{ MY }} user](../../managed-mysql/operations/grant.md#grant-role) the `ALL_PRIVILEGES` role for the source database.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [data-transfer-objs-mmy.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-mysql/tree/master/data-transfer-objs-mmy.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a {{ mmy-name }} cluster.
      * Service account to be used to create and access the bucket.
      * {{ lockbox-name }} secret which will store the static key of the service account to configure the source endpoint.
      * {{ objstorage-name }} source bucket.
      * {{ mmy-name }} target cluster.
      * Target endpoint.
      * Transfer.

   1. Specify in the `data-transfer-objs-mmy.tf` file:

      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create resources in.
      * `bucket_name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).
      * `mmy_password`: {{ MY }} user password.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the test data {#prepare-data}

1. Create a `data.csv` text file on the running instance and fill it with test data. As an example, we will use the readings returned by car sensors:

   ```csv
   1;99101;2022-06-05 17:27:00;55.70329032;37.65472196;427.5;52.3;23.5;17.;52.
   2;95106;2022-06-06 09:49:54;55.71294467;37.66542005;429.13;55.5;21.;18.;32.
   3;117890;2023-06-07 06:21:29;55.71294467;37.66542005;429.13;56.2;20.;18.7;45.
   4;99101;2022-06-07 08:15:32;55.29194467;37.66542005;429.13;59.1;21.;18.;20.
   ```

1. [Upload](../../storage/operations/objects/upload.md#simple) the file to the previously created {{ objstorage-name }} bucket.

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create) with the following settings:

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Object Storage`.
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}**: Bucket name in {{ objstorage-name }}.
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}**: Public part of the service account static key. If you created your infrastructure using {{ TF }}, [copy the key value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}**: Private part of the service account static key. If you created your infrastructure using {{ TF }}, [copy the key value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}**: `https://{{ s3-storage-host }}`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}**: `ru-central1`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}**: Semicolon mark (`;`).
   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}**: `measurements`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageResultTable.add_system_cols.title }}**: Disable the option.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` and specify field names and data types:

      * `id`: `INT64`, **Key** property
      * `device_id`: `INT32`
      * `datetime`: `DATETIME`

         {% note info %}

         The target endpoint writes `DATETIME` type data in the UTC+0 time zone.

         {% endnote %}

      * `latitude`: `DOUBLE`
      * `longitude`: `DOUBLE`
      * `altitude`: `DOUBLE`
      * `speed`: `DOUBLE`
      * `battery_voltage`: `DOUBLE`
      * `cabin_temperature`: `DOUBLE`
      * `fuel_level`: `DOUBLE`

   Leave the default values for the other parameters.

1. Create an endpoint for the target and the transfer:

   {% list tabs group=resources %}

   - Manually {#manual}

      1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/postgresql.md):

         * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`.
         * **Endpoint parameters**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**:
               * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

                  Select a source cluster from the list and specify its connection settings.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

   - {{ TF }} {#tf}

      1. In the `data-transfer-objs-mmy.tf` file, specify the following variables:

         * `source_endpoint_id`: ID of the source endpoint.
         * `transfer_enabled`: Set to `1` to enable transfer creation.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure for the transfer:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         Once created, your transfer will be activated automatically.

   {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.
1. [Connect to the {{ mmy-name }} target cluster database](../../managed-mysql/operations/connect.md).
1. To make sure the data was successfully transferred, run the following query:

   ```sql
   SELECT * FROM db1.measurements;
   ```

   {% cut "Response example" %}

   ```text
    id | device_id |     datetime        |  latitude | longitude | altitude | speed | battery_voltage | cabin_temperature | fuel_level
   ----------------+---------------------+-----------+-----------+----------+-------+-----------------+-------------------+----------+
     1 |     99101 | 2022-06-05T17:27:00 | 55.703289 |  37.66542 |   427.50 | 52.29 |            23.5 |              17.0 |     52.0 |
     2 |     95106 | 2022-06-06T09:49:54 | 55.712944 |  37.66542 |   429.13 | 55.50 |            21.0 |              18.0 |     32.0 |
     3 |    117890 | 2023-06-07T06:21:29 | 55.712944 |  37.66542 |   429.13 | 56.20 |            20.0 |              18.7 |     45.0 |
     4 |     99101 | 2022-06-05 17:27:00 | 55.291944 |  37.66542 |   429.13 | 59.09 |            21.0 |              18.0 |     20.0 |
   ```

   {% endcut %}

1. Create the `data2.csv` text file containing new data:

   ```csv
   7;95106;2022-06-07 09:54:32;47.71294467;37.66542005;429.13;62.2;21.;20.4;27.
   9;117890;2022-06-07 11:56:27;52.71294467;37.66542005;429.13;65.5;19.;19.;38.
   10;117890;2022-06-07 12:36:27;57.71294467;37.66542005;429.13;72.1;19.;20.;25.
   11;99101;2022-06-07 15:22:27;59.71294467;37.66542005;429.13;35.5;19.;18.;12.
   ```

1. Upload the file to the {{ objstorage-name }} bucket for transfer.
1. Make sure the new data is added to the `db1.measurements` table of the {{ MY }} target database.

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).

Delete the other resources depending on how they were created:

{% list tabs group=resources %}

- Manually {#manual}

   1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
   1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
   1. [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).
   1. If you created a service account together with the target endpoint, [delete it](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-objs-mmy.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `data-transfer-objs-mmy.tf` configuration file will be deleted.

{% endlist %}
