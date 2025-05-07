# Loading data from {{ objstorage-full-name }} to {{ ydb-full-name }} using {{ data-transfer-full-name }}


You can migrate data from {{ objstorage-name }} to the {{ ydb-name }} table using {{ data-transfer-name }}. To do this:

1. [Prepare the test data](#prepare-data).
1. [Prepare and activate your transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ objstorage-name }} bucket fee: Storing data and performing operations with it (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Per-transfer fee: Using computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).
* Fee for the {{ ydb-name }} database. The charge depends on the usage mode:

	* For the serverless mode, you pay for data operations and the amount of stored data.
	* For the dedicated instance mode, you pay for the use of computing resources, dedicated DBs, and disk space.
	
    Learn more about the [{{ ydb-name }} pricing](../../ydb/pricing/index.md) plans.


## Getting started {#before-you-begin}


Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration.

    1. If you selected {{ dd }} DB mode, [create](../../vpc/operations/security-group-create.md) and [configure](../../ydb/operations/connection.md#configuring-security-groups) a security group in the network hosting the DB.

    1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md).

    1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `s3-ydb-account` with the `storage.editor` and `ydb.editor` roles. The transfer will use it to access the bucket and database.

    1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for `s3-ydb-account`.

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
        * {{ ydb-name }} target cluster.
        * Target endpoint.
        * Transfer.

    1. In the `object-storage-to-ydb.tf` file, specify the values of the following variables:

        * `folder_id`: Cloud folder ID, same as in the provider settings.
        * `bucket_name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).

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

## Prepare and activate your transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/object-storage.md#endpoint-settings) of the `{{ objstorage-name }}` type with the following settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Object Storage`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}**: Bucket name in {{ objstorage-name }}.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}**: Public part of the service account static key. If you created your infrastructure with {{ TF }}, [copy the key value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}**: Private part of the service account static key. If you created your infrastructure with {{ TF }}, [copy the key value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}**: `https://{{ s3-storage-host }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}**: `{{ region-id }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}**: Comma (`,`).
    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}**: `table1`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` and specify field names and data types:

        * `Id`: `Int64`
        * `Name`: `UTF8`

    Leave the default values for the other properties.

1. Create a target endpoint and transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/yandex-database.md#endpoint-settings) of the `{{ ydb-short-name }}` type and specify the cluster connection settings in it:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-short-name }} database from the list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select the service account named `s3-ydb-account`.

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.

        1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

    - Using {{ TF }} {#tf}

        1. In the `object-storage-to-ydb.tf` file, specify the following settings:

            * `source_endpoint_id`: Source endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.

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

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with the DB you need.
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
    1. Select the database from the list.
    1. Navigate to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
    1. Make sure the {{ ydb-name }} database contains a table named `table1` with the test data.

- CLI {#cli}

    1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).

    1. Run this request:

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

### Test the replication process {#verify-replication}

1. [Upload](../../storage/operations/objects/upload.md#simple) the `demo_data2.csv` file to the {{ objstorage-name }} bucket.

1. Make sure the data from `demo_data2.csv` has been added to the target database:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder with the DB you need.
        1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
        1. Select the database from the list.
        1. Navigate to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
        1. Make sure `table1` now contains the new data.

    - CLI {#cli}

        1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).

        1. Run this request:

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

Before deleting the resources you created, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* [Transfer](../../data-transfer/operations/transfer.md#delete)
* [Source endpoint](../../data-transfer/operations/endpoint/index.md#delete)
* [Objects](../../storage/operations/objects/delete.md) from the bucket
* Delete the other resources depending on how they were created:

    {% list tabs group=instructions %}

    - Manually {#manual}

        * [Target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
        * [{{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
        * [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).

    - Using {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
