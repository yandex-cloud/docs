# Loading data from {{ MY }} to {{ objstorage-full-name }} using {{ data-transfer-full-name }}


With {{ data-transfer-name }}, you can transfer data from a {{ mmy-name }} source cluster to {{ objstorage-full-name }} object storage.

To transfer data:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare and activate your transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mmy-name }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* {{ objstorage-name }} bucket fee: storing data and performing operations with it (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Per-transfer fee: using computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md) in any suitable configuration.
    1. [Create a bucket in {{ objstorage-full-name }}](../../storage/operations/buckets/create.md).

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-transfer-mmy-objs.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-object-storage/blob/main/data-transfer-mmy-objs.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Security group](../../vpc/concepts/security-groups.md) and the rule required to connect to a {{ mmy-name }} cluster.
        * Source {{ mmy-name }} cluster.
        * Service account with the `editor`, `storage.editor`, and `storage.uploader` roles.
        * {{ objstorage-name }} bucket.
        * Source endpoint.
        * Transfer.

    1. Specify the following in the `data-transfer-mmy-objs.tf` file:

        * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create the resources in.
        * `sa_name`: Name of the service account for creating a bucket and for use in the target endpoint.
        * `bucket_name`: Bucket name in {{ objstorage-name }}.
        * The {{ mmy-name }} source cluster parameters that will be used as the [source endpoint parameters](../../data-transfer/operations/endpoint/source/mysql.md#managed-service):

            * `source_mysql_version`: {{ MY }} version.
            * `source_db_name`: Database name.
            * `source_user` and `source_password`: Name and user password of the database owner.
        * `transfer_enabled`: Set `0` to ensure that no transfer is created before [creating a target endpoint manually](#prepare-transfer).

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

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
        ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
    ```

## Prepare and activate your transfer {#prepare-transfer}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Object Storage`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageEndpoint.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.title }}**:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}**: Enter the name of the {{ objstorage-name }} bucket.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}**: Select or create a service account with the `storage.uploader` role.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout.title }}**: `measurements`.

1. Create a source endpoint and transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}**:

              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**:
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

                   Select a source cluster from the list and specify its connection settings.

              * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.exclude_tables.title }}**: Specify regular expressions for tables both subject and not subject to transfer.

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_** type that will use the created endpoints.
        1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

    - {{ TF }} {#tf}

        1. In the `data-transfer-mmy-objs.tf` file, specify these variables:

            * `target_endpoint_id`: ID of the target endpoint.
            * `transfer_enabled`: Set to `1` to create a transfer.
            * (Optional) `include_tables_regex`, `exclude_tables_regex`: Regular expressions for tables both subject and not subject to transfer.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Once created, your transfer will be activated automatically.

    {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Make sure the data has been moved from the {{ mmy-name }} source cluster to the {{ objstorage-name }} bucket:

    1. In the [management console]({{ link-console-main }}), select the folder where the bucket is located.
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Select the bucket from the list.
    1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_files }}** tab.
    1. Make sure that the {{ objstorage-name }} bucket contains the `measurements` directory with the `<source_cluster_database_name>_measurements` object with test data.

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources you created, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
    1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
    1. [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).
    1. If you had created a service account when creating the target endpoint, [delete it](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
