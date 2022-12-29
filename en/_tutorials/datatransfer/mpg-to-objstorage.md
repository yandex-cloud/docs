You can migrate a database from {{ mpg-full-name }} to {{ objstorage-full-name }} using {{ data-transfer-full-name }}. To do this:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Check the copy function upon re-activation](#example-check-copy).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

Prepare the infrastructure:

{% list tabs %}

* Manually

   1. Create a source {{ mpg-name }} cluster in any applicable [configuration](../../managed-postgresql/concepts/instance-types.md) with publicly available hosts and the following settings:
      * Database name: `db1`.
      * Username: `pg-user`.
      * Password: `<password for the source>`.

   1. Make sure that the [cluster's security group](../../managed-postgresql/operations/connect.md#configuring-security-groups) has been set up correctly and allows connecting to the cluster:

   1. [Create a {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md).

   1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `storage-sa` with the `storage.uploader` role. The transfer will use it to access the bucket.

* Using {{ TF }}

   1. If you don't have {{ TF }}, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
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

   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

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

   * Bucket: `<Name of the previously created bucket>`
   * Service account: `service-sa`.
   * Output format: `CSV`.
   * Compression format: `UNCOMPRESSED`.
   * Directory name: `from_PostgreSQL`.

1. Create a source endpoint and a transfer.

{% list tabs %}

* Manually

   1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

      * **Connection type**: `Managed Service for PostgreSQL cluster`.
      * **Cluster**: `<{{ PG }} source cluster name>` from the drop-down list.
      * **Database**: `db1`.
      * **Password**: `pg-user`.
      * **Password**: `<user password>`.

   1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy }}_ type that will use the created endpoints.

* Using {{ TF }}

   1. In the `postgresql-to-objstorage.tf` file, specify the variables:

      * `objstorage_endpoint_id`: ID of the target endpoint.
      * `transfer_enabled`: Set `1` to enable transfer creation.

   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Activate the transfer {#activate-transfer}

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to _{{ dt-status-finished }}_.

1. Make sure that the {{ objstorage-name }} bucket now includes the `public_x_tab.csv` file with the data from the `x_tab` table.

## Check the copy function upon re-activation {#example-check-copy}

1. [Connect to the {{ mpg-name }} cluster](../../managed-postgresql/operations/connect.md), delete the row with the ID of `41`, and edit the row with the ID `42` in the `x_tab` table:

   ```sql
   DELETE FROM x_tab WHERE id = 41;
   UPDATE x_tab SET name = 'Key3' WHERE id = 42;
   ```

1. [Re-activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to _{{ dt-status-finished }}_.
1. Make sure that the changes now show up in the `public_x_tab.csv` file in the target cluster.

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

* Make sure that the transfer is in the _{{ dt-status-finished }}_ status.
* [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
* Delete the transfer, source endpoint, cluster, and bucket:

   {% list tabs %}

   * Manually

      * [Transfer](../../data-transfer/operations/transfer.md#delete).
      * [Source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
      * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
      * [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).

   * Using {{ TF }}

      1. In the terminal window, change to the directory containing the infrastructure plan.
      1. Delete the `postgresql-to-objstorage.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the update of resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `postgresql-to-objstorage.tf` configuration file will be deleted.

   {% endlist %}
