# Loading data from {{ objstorage-full-name }} to {{ ydb-full-name }} using {{ data-transfer-full-name }}



{% include [storage-preview-disclaimer](../../_includes/data-transfer/storage-preview-disclaimer.md) %}


You can migrate data from {{ objstorage-name }} to the {{ ydb-name }} table using {{ data-transfer-name }}. Proceed as follows:

1. [Prepare the test data](#prepare-data).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ objstorage-name }} bucket: Use of storage, data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* {{ ydb-name }} database (see [{{ ydb-name }} pricing](../../ydb/pricing/index.md)). Its pricing is based on deployment mode:

	* In serverless mode, you pay for data operations and storage volume, including stored backups.
  	* In dedicated instance mode, you pay for the use of computing resources allocated to the database, storage size, and backups.


## Getting started {#before-you-begin}


Set up the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) with your preferred configuration.

    1. If you selected {{ dd }} DB mode, [create](../../vpc/operations/security-group-create.md) and [configure](../../ydb/operations/connection.md#configuring-security-groups) a security group in the network hosting the DB.

    1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md).

    
    1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `s3-ydb-account` with the `storage.editor` and `ydb.editor` roles. The transfer will use it to access the bucket and database.

    1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the `s3-ydb-account` service account.


- Using {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [object-storage-to-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-ydb/blob/main/object-storage-to-ydb.tf) configuration file to the same working directory.

        This file describes:

        * Service account to use when working with the {{ ydb-name }} bucket and database.
        * {{ lockbox-name }} secret which will store the static key of the service account to configure the source endpoint.
        * Source {{ objstorage-name }} bucket.
        * Target {{ ydb-name }} cluster.
        * Target endpoint.
        * Transfer.

    1. In the `object-storage-to-ydb.tf` file, specify the values of the following variables:

        * `folder_id`: Cloud folder ID, same as in the provider settings.
        * `bucket_name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare your test data {#prepare-data}

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

## Set up and activate the transfer {#prepare-transfer}

1. Create an `{{ objstorage-name }}`-type [source endpoint](../../data-transfer/operations/endpoint/source/object-storage.md#endpoint-settings) with the following settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Object Storage`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}**: {{ objstorage-name }} bucket name.

        
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}**: Public part of the service account static key. If you created your infrastructure using {{ TF }}, [copy the key value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}**: Private part of the service account’s static key. If you created your infrastructure using {{ TF }}, [copy the key value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).


    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}**: `https://{{ s3-storage-host }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}**: `{{ region-id }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}**: Comma (`,`).
    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}**: `table1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` and specify the following field names and data types:

        * `Id`: `Int64`
        * `Name`: `UTF8`

    Keep the default values for all other settings.

1. Create a target endpoint and set up the transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/yandex-database.md#endpoint-settings) of the `{{ ydb-short-name }}` type and specify the cluster connection settings in it:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-short-name }} database from the list.

            
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select the `s3-ydb-account` service account.


        1. [Create](../../data-transfer/operations/transfer.md#create) a **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**-type transfer configured to use the new endpoints.

        1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - Using {{ TF }} {#tf}

        1. In the `object-storage-to-ydb.tf` file, specify the following settings:

            * `source_endpoint_id`: Source endpoint ID.
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

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your database.
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
    1. Select your database from the list.
    1. Navigate to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
    1. Make sure the {{ ydb-name }} database contains a table named `table1` with the test data.

- CLI {#cli}

    1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).

    1. Run this query:

        ```sql
        SELECT * FROM table1;
        ```

        {% cut "Response example" %}

        ```sql
        Id |   Name   |   __file_name    | __row_index 
        ---+----------+------------------+-------------
         1 | "Anna"   | "demo_data1.csv" | 1 
         2 | "Robert" | "demo_data1.csv" | 2 
         3 | "Umar"   | "demo_data1.csv" | 3 
         4 | "Algul"  | "demo_data1.csv" | 4 
         5 | "Viktor" | "demo_data1.csv" | 5 
        ```

        {% endcut %}

{% endlist %}

### Test replication {#verify-replication}

1. [Upload](../../storage/operations/objects/upload.md#simple) the `demo_data2.csv` file to the {{ objstorage-name }} bucket.

1. Make sure the data from `demo_data2.csv` has been added to the target database:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder containing your database.
        1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
        1. Select your database from the list.
        1. Navigate to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
        1. Make sure `table1` now contains the new data.

    - CLI {#cli}

        1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).

        1. Run this query:

            ```sql
                SELECT * FROM table1;
            ```

            {% cut "Response example" %}

            ```sql
            Id |   Name   |   __file_name    | __row_index 
            ---+----------+------------------+-------------
             1 | "Anna"   | "demo_data1.csv" | 1 
             2 | "Robert" | "demo_data1.csv" | 2 
             3 | "Umar"   | "demo_data1.csv" | 3 
             4 | "Algul"  | "demo_data1.csv" | 4 
             5 | "Viktor" | "demo_data1.csv" | 5 
             6 | "Maria"  | "demo_data2.csv" | 1 
             7 | "Alex"   | "demo_data2.csv" | 2 
            ```

            {% endcut %}

    {% endlist %}

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

To reduce the consumption of resources you do not need, delete them:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the objects](../../storage/operations/objects/delete.md) from the bucket.
1. Delete other resources using the same method used for their creation:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
        1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
        1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).

    - Using {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
