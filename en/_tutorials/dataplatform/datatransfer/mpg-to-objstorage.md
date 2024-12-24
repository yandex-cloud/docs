

You can migrate a database from {{ mpg-full-name }} to {{ objstorage-full-name }} using {{ data-transfer-full-name }}. To do this:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Check the copy function upon re-activation](#example-check-copy).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. Create a source {{ mpg-name }} cluster in any applicable [configuration](../../../managed-postgresql/concepts/instance-types.md) with publicly available hosts and the following settings:
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<source_password>`.


    1. If using [security groups](../../../managed-postgresql/operations/connect.md#configuring-security-groups) in your cluster, make sure they are configured correctly and allow connecting to the cluster.


    1. [Create an {{ objstorage-full-name }} bucket](../../../storage/operations/buckets/create.md).

    1. [Create a service account](../../../iam/operations/sa/create.md#create-sa) named `storage-sa` with the `storage.uploader` role. The transfer will use it to access the bucket.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [postgresql-to-objstorage.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-postgresql-to-object-storage/blob/main/postgresql-to-objstorage.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network).
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) required to connect to a cluster.
        * {{ mpg-name }} source cluster.
        * Service account to be used to create and access the bucket.
        * {{ objstorage-name }} target bucket.
        * Source endpoint.
        * Transfer.

    1. Specify the following in the `postgresql-to-objstorage.tf` file:
        * {{ PG }} user password.
        * Bucket name consistent with the [naming conventions](../../../storage/concepts/bucket.md#naming).

    1. Check that the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up the transfer {#prepare-transfer}

1. [Connect to the {{ mpg-name }} cluster](../../../managed-postgresql/operations/connect.md), create a table named `x_tab` in the `db1` database and populate it with data:

     ```sql
     CREATE TABLE x_tab
     (
         id NUMERIC PRIMARY KEY,
         name CHAR(5)
     );
     INSERT INTO x_tab (id, name) VALUES
       (40, 'User1'),
       (41, 'User2'),
       (42, 'User3'),
       (43, 'User4'),
       (44, 'User5');
     ```

1. [Create a target endpoint](../../../data-transfer/operations/endpoint/target/object-storage.md) of the `{{ objstorage-name }}` type with the following settings:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}**: `<name_of_previously_created_bucket>`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}**: `storage-sa`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}**: `UNCOMPRESSED`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout.title }}**: `from_PostgreSQL`.

1. Create a source endpoint and a transfer.

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a source endpoint](../../../data-transfer/operations/endpoint/source/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<{{ PG }}_source_cluster_name>` from the drop-down list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `<user_password>`.

    1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_** type that will use the created endpoints.

- {{ TF }} {#tf}

    1. In the `postgresql-to-objstorage.tf` file, specify these variables:

        * `objstorage_endpoint_id`: Target endpoint ID.
        * `transfer_enabled`: `1` to create a transfer.

    1. Check that the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.

1. Make sure the {{ objstorage-name }} bucket now contains the `public_x_tab.csv` table with the `x_tab` table data.

## Check the copy function upon re-activation {#example-check-copy}

1. [Connect to the {{ mpg-name }} cluster](../../../managed-postgresql/operations/connect.md) and, in the `x_tab` table, delete the row with the `41` ID and edit the row with the `42` ID:

    ```sql
    DELETE FROM x_tab WHERE id = 41;
    UPDATE x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. [Reactivate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.
1. Make sure you can see the changes in the target `public_x_tab.csv` table.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* Make sure the transfer status is **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.
* [Delete the target endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
* Delete the transfer, source endpoint, cluster, and bucket:

    {% list tabs group=instructions %}

    - Manually {#manual}

        * [Transfer](../../../data-transfer/operations/transfer.md#delete).
        * [Source endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
        * [{{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).
        * [{{ objstorage-name }} bucket](../../../storage/operations/buckets/delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
