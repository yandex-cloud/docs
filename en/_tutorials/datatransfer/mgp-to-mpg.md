You can migrate a database from {{ GP }} to the {{ PG }} cluster using {{ data-transfer-full-name }}.

To transfer a database from {{ GP }} to {{ PG }}:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Check the copy function upon re-activation](#example-check-copy).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

For clarity, we will create all required resources in {{ yandex-cloud }}. Prepare the infrastructure:

{% list tabs %}

* Manually

   1. [Create a source {{ mgp-full-name }} cluster](../../managed-greenplum/operations/cluster-create.md#create-cluster) of any suitable configuration with the `gp-user` admin user name and hosts in the public domain.

   1. [Create a {{ mpg-full-name }} target cluster](../../managed-postgresql/operations/cluster-create.md#create-cluster) in any applicable configuration with publicly available hosts. When creating a cluster, specify:

      * **Username**: `pg-user`.
      * **Database name**: `db1`.

   
   1. If you are using security groups in your clusters, make sure they have been set up correctly and allow connection to clusters:

      * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups).
      * [{{ mgp-name }}](../../managed-greenplum/operations/connect.md#configuring-security-groups).



* Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [greenplum-postgresql.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/greenplum-postgresql.tf) configuration file to the same working directory.

      This file describes:

      * [Networks](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) for hosting the clusters.
      * [Security groups](../../vpc/concepts/security-groups.md) to connect to clusters.
      * {{ mgp-name }} source cluster.
      * {{ mpg-name }} target cluster.
      * Target endpoint.
      * Transfer.

   1. In the file `greenplum-postgresql.tf`, specify the {{ GP }} and {{ PG }} administrator passwords.
   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
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

1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/greenplum.md) of the `{{ GP }}` type and specify the cluster connection parameters in it:

   * **Connection type**: `Managed Service for Greenplum cluster`.
   * **Cluster**: `<{{ GP }} source cluster name>` from the drop-down list.
   * **Database**: `postgres`.
   * **User**: `gp-user`.
   * **Password**: `<user password>`.
   * **Auxiliary object schema**: `public`.

1. Create a target endpoint and a transfer.

{% list tabs %}

* Manually

   1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it.

      * **Connection type**: `Managed Service for PostgreSQL cluster`.
      * **Cluster**: `<{{ PG }} target cluster name>` from the drop-down list.
      * **Database**: `db1`.
      * **Password**: `pg-user`.
      * **Password**: `<user password>`.

   1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with a _{{ dt-type-copy }}_ type that will use the created endpoints.

      Replication is not available for this endpoint pair, but you can set up regular copying when creating a transfer. To do this, in the **Transfer parameters** **Copy** field, select **Regular** and specify the copy interval. This will activate a transfer automatically after the specified time interval.

      {% note warning %}

      Before configuring regular copy, please make sure that the [target endpoint parameters](../../data-transfer/operations/endpoint/target/postgresql#additional-settings) include either a `DROP` or a `TRUNCATE` cleanup policy. Otherwise, data on the target will be duplicated.

      {% endnote %}

* Using {{ TF }}

   1. Specify the variables in the file `greenplum-postgresql.tf`:

      * `gp_source_endpoint_id`: ID of the source endpoint.
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

1. [Connect to the {{ mgp-name }} cluster](../../managed-greenplum/operations/connect.md), create a table called `x_tab`, and populate it with data:

   ```sql
   CREATE TABLE x_tab
   (
       id NUMERIC,
       name CHARACTER(5)
   );
   CREATE INDEX ON x_tab (id);
   INSERT INTO x_tab (id, name) VALUES
   (40, 'User1'),
   (41, 'User2'),
   (42, 'User3'),
   (43, 'User4'),
   (44, 'User5');
   ```

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to {{ dt-status-finished }}.
1. To verify that the data has transferred correctly, connect to the {{ mpg-name }} target cluster and make sure that the columns of the `x_tab` table in the `db1` database match those of the source database `x_tab` table:

   ```sql
   SELECT id, name FROM db1.public.x_tab;
   ```

   ```text
   ┌─id─┬─name──┐
   │ 40 │ User1 │
   │ 41 │ User2 │
   │ 42 │ User3 │
   │ 43 │ User4 │
   │ 44 │ User5 │
   └────┴───────┘
   ```

## Check the copy function upon re-activation {#example-check-copy}

1. In the [target endpoint parameters](../../data-transfer/operations/endpoint/target/postgresql#additional-settings), select either a `DROP` or a `TRUNCATE` cleanup policy.
1. [Connect to the {{ mgp-name }} cluster](../../managed-greenplum/operations/connect.md).
1. In the `x_tab` table, delete the row where ID is `41` and update the one where ID is `42`:

   ```sql
   DELETE FROM x_tab WHERE id = 41;
   UPDATE x_tab SET name = 'Key3' WHERE id = 42;
   ```

1. [Re-activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to {{ dt-status-finished }}.
1. Make sure that you see the changes in the `x_tab` table on the {{ PG }} target:

   ```sql
   SELECT id, name FROM db1.public.x_tab;
   ```

   ```text
   ┌─id─┬─name──┐
   │ 42 │ Key3  │
   │ 40 │ User1 │
   │ 43 │ User4 │
   │ 44 │ User5 │
   └────┴───────┘
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* Make sure the transfer has the {{ dt-status-finished }} status and [delete](../../data-transfer/operations/transfer.md#delete) it.
* [Delete both the source endpoint and the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
* Delete the clusters:

   {% list tabs %}

   * Manually

      
      * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
      * [{{ mgp-name }}](../../managed-greenplum/operations/cluster-delete.md).


      * Using {{ TF }}

         If you created your resources using {{ TF }}:

         1. In the terminal window, switch to the directory containing the infrastructure plan.
         1. Delete the `greenplum-postgresql.tf` configuration file.
         1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point to them.

         1. Confirm the resources have been updated.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            All the resources described in the `greenplum-postgresql.tf` configuration file will be deleted.

   {% endlist %}
