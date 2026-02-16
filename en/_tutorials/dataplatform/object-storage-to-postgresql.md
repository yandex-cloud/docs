# Migrating data from {{ objstorage-full-name }} to {{ mpg-full-name }} via {{ data-transfer-full-name }}


You can migrate data from {{ objstorage-full-name }} to the {{ mpg-name }} table using {{ data-transfer-name }}. To do this:

1. [Prepare your test data](#prepare-data).
1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ objstorage-name }} bucket: Use of storage, data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* {{ mpg-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}


Set up your infrastructure:

{% list tabs group=resources %}

- Manually {#manual}

    1. [Create a {{ mpg-name }}] target cluster(../../managed-postgresql/operations/cluster-create.md) using any suitable [base configuration](../../managed-postgresql/concepts/instance-types.md) and the following settings:

        * Public access to cluster hosts: Allowed.
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<user_password>`.

    
    1. If using security groups, make sure they are [configured correctly](../../managed-postgresql/operations/connect.md#configuring-security-groups) and allow connections to your cluster.


    1. [Create a {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md).

    
    1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `storage-viewer` with the `storage.viewer` role. The transfer will use it to access the bucket.
    1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the `storage-viewer` service account.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [objstorage-to-postgres.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-object-storage-to-postgresql/blob/main/objstorage-to-postgres.tf) configuration file to your current working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * Cluster access [security group](../../vpc/concepts/security-groups.md).
        * Service account for bucket operations, e.g., creation and access.
        * {{ lockbox-name }} secret for the service account static key required to configure the source endpoint.
        * {{ objstorage-name }} source bucket.
        * Target {{ mpg-name }} cluster.
        * Target endpoint.
        * Transfer.

    1. In the `objstorage-to-postgres.tf` file, specify the following:

        * `folder_id`: Cloud folder ID matching the one specified in your provider settings.
        * `bucket_name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).
        * `pg_password`: {{ PG }} user password.

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

1. On your local machine, create the `demo_data.csv` file and fill it with test data:

    ```csv
    1,Anna
    2,Robert
    3,Umar
    4,Algul
    5,Viktor
    ```

1. [Upload](../../storage/operations/objects/upload.md#simple) your prepared file to the {{ objstorage-name }} bucket.

## Set up the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/object-storage.md) of the `{{ objstorage-name }}` type with the following settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Object Storage`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}**: {{ objstorage-name }} bucket name.

    
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_access_key_id.title }}**: Public component of the service account’s static key. If you created your infrastructure using {{ TF }}, [copy the key’s value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.aws_secret_access_key.title }}**: Service account’s secret access key. If you created your infrastructure using {{ TF }}, [copy the key’s value from the {{ lockbox-name }} secret](../../lockbox/operations/secret-get-info.md#secret-contents).


    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}**: `https://{{ s3-storage-host }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}**: `{{ region-id }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}**: Comma (`,`).
    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}**: Name of the CSV file in the bucket, e.g., `demo_data.csv`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` and specify field names and data types:

        * `Id`: `Int64`
        * `Name`: `UTF8`

    Keep the default values for all other settings.

1. Create a target endpoint and set up the transfer:

    {% list tabs group=resources %}

    - Manually {#manual}

        1. Create a `{{ PG }}`-type [target endpoint](../../data-transfer/operations/endpoint/target/postgresql.md) and specify its cluster connection settings:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: Select the name of the {{ PG }} source cluster from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — `<user_password>`.

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**-type that will use the endpoints you created.

    - {{ TF }} {#tf}

        1. In the `objstorage-to-postgres.tf` file, specify the following variables:

            * `source_endpoint_id`: Source endpoint ID.
            * `transfer_enabled`: Set to `1` to create a transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. [Connect to the database in the target {{ mpg-name }} cluster](../../managed-postgresql/operations/connect.md).
1. Run this request:

    ```sql
    SELECT * FROM public."demo_data.csv";
    ```

    {% cut "Response example" %}

    ```sql
     __file_name  | __row_index | Id |  Name  
    --------------+-------------+----+--------
    demo_data.csv |           1 |  1 | Anna
    demo_data.csv |           2 |  2 | Robert
    demo_data.csv |           3 |  3 | Umar
    demo_data.csv |           4 |  4 | Algul
    demo_data.csv |           5 |  5 | Viktor
    ```

    {% endcut %}

Data successfully migrated.

## Delete the resources you created {#clear-out}

To reduce the consumption of resources, delete those you do not need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the objects](../../storage/operations/objects/delete.md) from the bucket.
1. Delete the other resources depending on how you created them:

    {% list tabs group=resources %}

    - Manually {#manual}

        1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
        1. [Delete the {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).
        1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
