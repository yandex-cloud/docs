# Loading data from {{ objstorage-full-name }} to {{ mgp-full-name }} using {{ data-transfer-full-name }}


You can migrate data from {{ objstorage-name }} to the {{ mgp-name }} table using {{ data-transfer-name }}. To do this:

1. [Prepare the test data](#prepare-data).
1. [Create a database in the target cluster](#prepare-data).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Prepare the infrastructure:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a {{ mgp-name }} target cluster](../../managed-greenplum/operations/cluster-create.md) in any applicable configuration with publicly available hosts and the following settings:

         * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `user1`.
         * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<user_password>`.

      
      1. If using security groups in your cluster, make sure they are [configured correctly](../../managed-greenplum/operations/connect.md#configuring-security-groups) and allow connecting to it.


      1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md).

      1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `storage-viewer` with the `storage.viewer` role. The transfer will use it to access the bucket.

      1. [Create a static access key](../../iam/operations/sa/create-access-key.md) for the `storage-viewer` service account.

   - Using {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the [object-storage-to-greenplum.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-greenplum/blob/main/object-storage-to-greenplum.tf) configuration file to the same working directory.

         This file describes:

         * [Network](../../vpc/concepts/network.md#network).
         * [Subnet](../../vpc/concepts/network.md#subnet).
         * [Security group](../../vpc/concepts/security-groups.md) required to connect to a cluster.
         * Service account to be used to create and access the bucket.
         * {{ lockbox-name }} secret which will store the static key of the service account to configure the source endpoint.
         * {{ objstorage-name }} source bucket.
         * {{ mgp-name }} target cluster.
         * Transfer.

      1. In the `object-storage-to-greenplum.tf` file, specify the values for these variables:

         * `folder_id`: Cloud folder ID, the same one specified in the provider settings.
         * `bucket_name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).
         * `gp_version`: {{ GP }} version.
         * `gp_password`: {{ GP }} user password.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. [Enable](../../managed-greenplum/operations/update.md#change-additional-settings) the **{{ ui-key.yacloud.mdb.forms.additional-field-datatransfer }}** option in the target cluster.

## Prepare the test data {#prepare-data}

1. Prepare two CSV files with test data:

   * `demo_data1.csv`:

      ```csv
      1,Anna
      2,Robert
      3,Umar
      4,Algul
      5,Viktor
      ```

   * `demo_data2.csv`:

      ```csv
      6,Maria
      7,Alex
      ```

1. [Upload](../../storage/operations/objects/upload.md#simple) the `demo_data1.csv` file to the {{ objstorage-name }} bucket.

## Create a database in the target cluster {#prepare-data}

1. [Connect to the auxiliary `postgres` database](../../managed-greenplum/operations/connect.md) of the {{ mgp-name }} target cluster as `user1`.

1. Create the `db1` database:

   ```sql
   CREATE DATABASE db1;
   ```

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/object-storage.md#objstorage-name) of the `{{ objstorage-name }}` type with the following settings:

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Object Storage`.
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}**: Bucket name in {{ objstorage-name }}.
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}**: Public part of the service account static key. If you created your infrastructure with {{ TF }}, [copy the key value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}**: Private part of the service account static key. If you created your infrastructure with {{ TF }}, [copy the key value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}**: `https://storage.yandexcloud.net`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}**: `ru-central1`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}**: Comma mark (`,`).
   * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}**: `table1`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` and specify field names and data types:

      * `Id`: `Int64`
      * `Name`: `UTF8`

   Leave the default values for the other parameters.

1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/greenplum.md#gp) of the `{{ GP }}` type and specify the cluster connection parameters in it:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}**: `<name_of_{{ GP }}_target_cluster>` from the drop-down list.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: `db1`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: `user1`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: `<user_password>`.

1. Create and activate the transfer:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.

      1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

   - Using {{ TF }} {#tf}

      1. In the `object-storage-to-greenplum.tf` file, specify the variables:

         * `source_endpoint_id`: Source endpoint ID.
         * `target_endpoint_id`: Target endpoint ID.
         * `transfer_enabled`: Set to `1` to enable transfer creation.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      1. The transfer will be activated automatically. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

   {% endlist %}

## Test the transfer {#verify-transfer}

Check the transfer performance by testing the copy and replication processes.

### Test the copy process {#verify-copy}

1. [Connect to the `db1` database](../../managed-greenplum/operations/connect.md) in the {{ mgp-name }} target cluster.

1. Run the following query:

   ```sql
   SELECT * FROM public.table1;
   ```

   {% cut "Response example" %}

   ```sql
     __file_name  | __row_index | Id |  Name
   ---------------+-------------+----+--------
   demo_data1.csv |           1 |  1 | Anna
   demo_data1.csv |           2 |  2 | Robert
   demo_data1.csv |           3 |  3 | Umar
   demo_data1.csv |           4 |  4 | Algul
   demo_data1.csv |           5 |  5 | Viktor
   ```

   {% endcut %}

### Test the replication process {#verify-replication}

1. [Upload](../../storage/operations/objects/upload.md#simple) the `demo_data2.csv` file to the {{ objstorage-name }} bucket.

1. Make sure the data from the `demo_data2.csv` file has been added to the target database:

   1. [Connect to the `db1` database](../../managed-greenplum/operations/connect.md) in the {{ mgp-name }} target cluster.

   1. Run the following query:

      ```sql
      SELECT * FROM public.table1;
      ```

      {% cut "Response example" %}

      ```sql
        __file_name  | __row_index | Id |  Name
      ---------------+-------------+----+--------
      demo_data1.csv |           1 |  1 | Anna
      demo_data1.csv |           2 |  2 | Robert
      demo_data1.csv |           3 |  3 | Umar
      demo_data1.csv |           4 |  4 | Algul
      demo_data1.csv |           5 |  5 | Viktor
      demo_data2.csv |           1 |  6 | Maria
      demo_data2.csv |           2 |  7 | Alex
      ```

      {% endcut %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* [Transfer](../../data-transfer/operations/transfer.md#delete).
* [Source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
* [Target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
* Delete the other resources depending on how they were created:

   {% list tabs group=instructions %}

   - Manually {#manual}

      * [{{ mgp-name }} cluster](../../managed-greenplum/operations/cluster-delete.md).
      * [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).

   - Using {{ TF }} {#tf}

      1. Delete all objects from the bucket.
      1. In the terminal window, go to the directory containing the infrastructure plan.
      1. Delete the `object-storage-to-greenplum.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `object-storage-to-greenplum.tf` configuration file will be deleted.

   {% endlist %}
