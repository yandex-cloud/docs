# Loading data from {{ MY }} to {{ objstorage-full-name }} using {{ data-transfer-full-name }}


{{ data-transfer-name }} enables you to transfer data from a {{ mmy-name }} source cluster to {{ objstorage-full-name }}.

To transfer data:

1. [Prepare the source cluster](#prepare-source).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mmy-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* {{ objstorage-name }} bucket: use of storage, data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md) of any suitable configuration.
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
        * [Security group](../../vpc/concepts/security-groups.md) and the rule required for connecting to the {{ mmy-name }} cluster.
        * {{ mmy-name }} source cluster.
        * Service account with the `editor`, `storage.editor`, and `storage.uploader` roles.
        * {{ objstorage-name }} bucket.
        * Source endpoint.
        * Transfer.

    1. In the `data-transfer-mmy-objs.tf` file, specify the following:

        * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) for the new resources.
        * `sa_name`: Name of the service account for creating a bucket and for use in the target endpoint.
        * `bucket_name`: {{ objstorage-name }} bucket name.
        * {{ mmy-name }} source cluster parameters to use for the [source endpoint](../../data-transfer/operations/endpoint/source/mysql.md#managed-service):

            * `source_mysql_version`: {{ MY }} version.
            * `source_db_name`: Database name.
            * `source_user` and `source_password`: Database owner username and password.
        * `transfer_enabled`: Set to `0` to ensure that no transfer is created before you [manually create the target endpoint](#prepare-transfer).

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the source cluster {#prepare-source}

1. If you created the infrastructure manually, [set up your source cluster](../../data-transfer/operations/prepare.md#source-my).

1. [Connect to the {{ mmy-name }} source cluster](../../managed-mysql/operations/connect/index.md).

1. Populate the database with test data. In this example, we will use a table containing information from car sensors.

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

## Set up and activate the transfer {#prepare-transfer}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Object Storage`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageEndpoint.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.title }}**:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}**: Specify the {{ objstorage-name }} bucket name.

          
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}**: Select an existing service account or create a new one with the `storage.uploader` role.


        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.bucket_layout.title }}**: `measurements`.

1. Create a source endpoint and transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}**:

              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**:
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

                   Select your source cluster from the list and specify its connection settings.

              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.exclude_tables.title }}**: Regular expressions for the tables you want to transfer and for those you want to ignore. These parameters are optional.

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_** type that will use the endpoints you created.
        1. [Activate](../../data-transfer/operations/transfer.md#activate) the transfer.

    - {{ TF }} {#tf}

        1. In the `data-transfer-mmy-objs.tf` file, specify the following variables:

            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.
            * `include_tables_regex`, `exclude_tables_regex`: Regular expressions for the tables you want to transfer and for those you want to ignore. These variables are optional.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            The transfer will be activated automatically upon creation.

    {% endlist %}

## Test your transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Make sure the data has been transferred from the {{ mmy-name }} source cluster to the {{ objstorage-name }} bucket:

    1. In the [management console]({{ link-console-main }}), select the folder containing your bucket.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Select the bucket from the list.
    1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_files }}** tab.
    1. Make sure the {{ objstorage-name }} bucket contains the `measurements` directory with the `<source_cluster_database_name>_measurements` object with test data.

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

To reduce the consumption of resources, delete those you do not need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
1. Delete the other resources depending on how you created them:

   {% list tabs group=instructions %}

   - Manually {#manual}

       1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
       1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
       1. [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).

       
       1. If you created a service account when creating the target endpoint, [delete it](../../iam/operations/sa/delete.md).


   - {{ TF }} {#tf}

       {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}
