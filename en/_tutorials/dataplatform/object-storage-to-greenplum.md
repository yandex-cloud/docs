# Loading data from {{ objstorage-full-name }} to {{ mgp-full-name }} using {{ data-transfer-full-name }}


{% include [storage-preview-disclaimer](../../_includes/data-transfer/storage-preview-disclaimer.md) %}


You can migrate data from {{ objstorage-name }} to the {{ GP }} table in {{ mgp-name }} using {{ data-transfer-name }}. Proceed as follows:

1. [Prepare the test data](#prepare-data).
1. [Create a database in the target cluster](#prepare-data).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ objstorage-name }} bucket: Use of storage, data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* {{ mgp-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mgp-name }} pricing](../../managed-greenplum/pricing/index.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}


1. Set up the infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a {{ GP }} target cluster](../../managed-greenplum/operations/cluster-create.md) of any suitable configuration with publicly available hosts and the following settings:

            * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `user1`.
            * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<user_password>`.

        
        1. If using security groups, make sure they are [configured correctly](../../managed-greenplum/operations/connect.md#configuring-security-groups) and allow connections to your cluster.


        1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md).

        
        1. [Create a service account](../../iam/operations/sa/create.md#create-sa) `storage-viewer` with the `storage.viewer` role. The transfer will use it to access the bucket.

        1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the `storage-viewer` service account.


    - Using {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [object-storage-to-greenplum.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-greenplum/blob/main/object-storage-to-greenplum.tf) configuration file to the same working directory.

            This file describes:

            * [Network](../../vpc/concepts/network.md#network).
            * [Subnet](../../vpc/concepts/network.md#subnet).
            * Cluster access [security group](../../vpc/concepts/security-groups.md).
            * Service account for bucket operations, e.g., creation and access.
            * {{ lockbox-name }} secret for the service account static key required to configure the source endpoint.
            * Source {{ objstorage-name }} bucket.
            * {{ GP }} target cluster in {{ mgp-name }}.
            * Transfer.

        1. In the `object-storage-to-greenplum.tf` file, specify the values of the following variables:

            * `folder_id`: Cloud folder ID, same as in the provider settings.
            * `bucket_name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).
            * `gp_version`: {{ GP }} version.
            * `gp_password`: {{ GP }} password.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

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

1. [Connect](../../managed-greenplum/operations/connect.md) to the auxiliary `postgres` database in the {{ GP }} target cluster as `user1`.

1. Create a database named `db1`:

    ```sql
    CREATE DATABASE db1;
    ```

## Prepare and activate your transfer {#prepare-transfer}

1. Create an `{{ objstorage-name }}`-type [source endpoint](../../data-transfer/operations/endpoint/source/object-storage.md#objstorage-name) with the following settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Object Storage`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}**: {{ objstorage-name }} bucket name.

    
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}**: Public part of the service account static key. If you created your infrastructure using {{ TF }}, [copy the key value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}**: Private part of the service account’s static key. If you created your infrastructure using {{ TF }}, [copy the key value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).


    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}**: `https://storage.yandexcloud.net`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}**: `ru-central1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}**: Comma (`,`).
    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}**: `table1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` and specify the following field names and data types:

        * `Id`: `Int64`
        * `Name`: `UTF8`

    Leave the default values for the other properties.

1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/greenplum.md#gp) of the `{{ GP }}` type and specify the cluster connection settings in it:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}**: `<target_{{ GP }}_cluster_name>` from the drop-down list
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: `db1`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: `user1`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: `<user_password>`.

1. Create and activate your transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create](../../data-transfer/operations/transfer.md#create) a **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**-type transfer configured to use the new endpoints.

        1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - Using {{ TF }} {#tf}

        1. In the `object-storage-to-greenplum.tf` file, specify these variables:

            * `source_endpoint_id`: Source endpoint ID.
            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        1. The transfer will activate automatically upon creation. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    {% endlist %}

## Test your transfer {#verify-transfer}

Make sure the transfer works correctly by testing copying and replication.

### Test copying {#verify-copy}

1. [Connect](../../managed-greenplum/operations/connect.md) to the `db1` database in the {{ GP }} target cluster.

1. Run this query:

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

### Test replication {#verify-replication}

1. [Upload](../../storage/operations/objects/upload.md#simple) the `demo_data2.csv` file to the {{ objstorage-name }} bucket.

1. Verify that the data from `demo_data2.csv` has been loaded into the target database:

    1. [Connect](../../managed-greenplum/operations/connect.md) to the `db1` database in the {{ GP }} target cluster.

    1. Run this query:

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

To reduce the consumption of resources you do not need, delete them:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the objects](../../storage/operations/objects/delete.md) from the bucket.
1. Delete other resources using the same method used for their creation:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Delete the {{ GP }} cluster](../../managed-greenplum/operations/cluster-delete.md).
        1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).

    - Using {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
