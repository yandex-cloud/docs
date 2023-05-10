You can migrate a database from {{ mpg-full-name }} to {{ objstorage-full-name }} using {{ data-transfer-full-name }}. To do this:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Check the copy function upon re-activation](#example-check-copy).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

* Manually

   1. Create a source {{ mpg-name }} cluster in any applicable [configuration](../../managed-postgresql/concepts/instance-types.md) with publicly available hosts and the following settings:
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<password for the source>`.

   
   1. If you are using [security groups](../../managed-postgresql/operations/connect.md#configuring-security-groups) in your cluster, make sure they have been set up correctly and allow connecting to the cluster:

      {% include [preview-pp.md](../../_includes/preview-pp.md) %}


   1. [Create a {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md).

   1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `storage-sa` with the `storage.uploader` role. The transfer will use it to access the bucket.

* Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [postgresql-to-objstorage.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/postgresql-to-objstorage.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security group](../../vpc/concepts/security-groups.md) required to connect to a cluster.
      * {{ mpg-name }} source cluster.
      * Service account to be used to create and access the bucket.
      * Target {{ objstorage-name }} bucket.
      * Source endpoint.
      * Transfer.

   1. In the `postgresql-to-objstorage.tf` file, specify:
      * {{ PG }} user password.
      * Bucket name meeting the [naming conventions](../../storage/concepts/bucket.md#naming).

   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up the transfer {#prepare-transfer}

1. [Connect to the {{ mpg-name }} cluster](../../managed-postgresql/operations/connect.md), create a table called `x_tab` in the `db1` database, and populate it with data:

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

1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/object-storage.md) of the `{{ objstorage-name }}` type with the following settings:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket.title }}**: `<name of the created bucket>`
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}**: `storage-sa`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}**: `CSV`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}**: `UNCOMPRESSED`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket_layout.title }}**: `from_PostgreSQL`.

1. Create a source endpoint and a transfer.

{% list tabs %}

* Manually

   1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<{{ PG }} source cluster name>` from the drop-down list.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}**: `db1`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}**: `pg-user`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}**: `<user password>`.

   1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with a **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_** type that will use the created endpoints.

* Using {{ TF }}

   1. In the `postgresql-to-objstorage.tf` file, specify the variables:

      * `objstorage_endpoint_id`: ID of the target endpoint.
      * `transfer_enabled`: Set `1` to enable transfer creation.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.

1. Make sure that the {{ objstorage-name }} bucket now includes the `public_x_tab.csv` file with the data from the `x_tab` table.

## Check the copy function upon re-activation {#example-check-copy}

1. [Connect to the {{ mpg-name }} cluster](../../managed-postgresql/operations/connect.md) and, in the `x_tab` table, delete the row where ID equals `41`, and edit the row where ID is `42`:

   ```sql
   DELETE FROM x_tab WHERE id = 41;
   UPDATE x_tab SET name = 'Key3' WHERE id = 42;
   ```

1. [Reactivate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.
1. Make sure that the changes now show up in the `public_x_tab.csv` file in the target cluster.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* Make sure the transfer status is **_{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}_**.
* [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
* Delete the transfer, source endpoint, cluster, and bucket:

   {% list tabs %}

   * Manually

      * [Transfer](../../data-transfer/operations/transfer.md#delete).
      * [Source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
      * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
      * [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).

   * Using {{ TF }}

      1. In the terminal window, switch to the directory containing the infrastructure plan.
      1. Delete the `postgresql-to-objstorage.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the resources have been updated.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `postgresql-to-objstorage.tf` configuration file will be deleted.

   {% endlist %}
