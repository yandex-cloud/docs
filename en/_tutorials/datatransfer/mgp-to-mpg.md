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

   1. [Create a {{ mgp-full-name }} source cluster](../../managed-greenplum/operations/cluster-create.md#create-cluster) in any suitable configuration with the `gp-user` admin username and public hosts.

   1. [Create a {{ mpg-full-name }} target cluster](../../managed-postgresql/operations/cluster-create.md#create-cluster) in any suitable configuration with publicly available hosts. When creating a cluster, specify:

      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`

   
   1. If you are using security groups in clusters, make sure they are set up correctly and allow connecting to the clusters:

      * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups).
      * [{{ mgp-name }}](../../managed-greenplum/operations/connect.md#configuring-security-groups).


* Using {{ TF }}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [greenplum-postgresql.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/greenplum-postgresql.tf) configuration file to the same working directory.

      This file describes:

      * [Networks](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) for hosting the clusters.
      * [Security groups](../../vpc/concepts/security-groups.md) to connect to clusters.
      * {{ mgp-name }} source cluster.
      * {{ mpg-name }} target cluster.
      * Target endpoint.
      * Transfer.

   1. In the `greenplum-postgresql.tf` file, specify the {{ GP }} and {{ PG }} administrator passwords.
   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/greenplum.md) of the `{{ GP }}` type and specify the cluster connection parameters in it:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}**: `<name_of_{{ GP }}_source_cluster>` from the drop-down list.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: `postgres`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: `gp-user`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: `<user_password>`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.service_schema.title }}**: `public`.

1. Create a target endpoint and a transfer:

    {% list tabs %}

    * Manually

        1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}**: `Yandex Managed Service for PostgreSQL cluster`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<name_of_{{ PG }}_target_cluster>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}**: `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}**: `<user_password>`.

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_** type that will use the created endpoints.

            Replication is not available for this endpoint pair, but you can set up regular copying when creating a transfer. To do this, in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}** field under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.title }}**, select **Regular** and specify the copy interval. This will activate a transfer automatically after the specified time interval.

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

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Activate the transfer {#activate-transfer}

1. [Connect to the {{ mgp-name }} cluster](../../managed-greenplum/operations/connect.md), create a table named `x_tab`, and populate it with data:

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

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
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

1. In the [target endpoint parameters](../../data-transfer/operations/endpoint/target/postgresql#additional-settings) select either a `DROP` or a `TRUNCATE` cleanup policy.
1. [Connect to the {{ mgp-name }} cluster](../../managed-greenplum/operations/connect.md).
1. In the `x_tab` table, delete the row with the `41` ID and update the one with the `42` ID:

   ```sql
   DELETE FROM x_tab WHERE id = 41;
   UPDATE x_tab SET name = 'Key3' WHERE id = 42;
   ```

1. [Reactivate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
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

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* Make sure the transfer has the **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}** status and [delete](../../data-transfer/operations/transfer.md#delete) it.
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

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Confirm updating the resources.

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            All the resources described in the `greenplum-postgresql.tf` configuration file will be deleted.

   {% endlist %}
