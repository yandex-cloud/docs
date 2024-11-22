# Migrating data from {{ mmy-full-name }} to {{ mgp-full-name }} using {{ data-transfer-full-name }}


You can set up data transfer from {{ mmy-name }} to {{ mgp-name }} databases using {{ data-transfer-name }}. To do this:

1. [Prepare the test data](#prepare-data).
1. [Create a database in the target cluster](#prepare-data).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md#create-cluster) in any [availability zone](../../overview/concepts/geo-scope.md) with publicly available hosts in any suitable configuration and the following settings:

      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `mmy_db`
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mmy_user`
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<source_password>`

   1. [Grant](../../managed-mysql/operations/grant.md#grant-privilege) `mmy_user` the `REPLICATION CLIENT` and `REPLICATION SLAVE` administrative privileges.

      For more information about administrative privileges, see the [settings description](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges).

   1. In the same availability zone, [create a {{ mgp-name }} target cluster](../../managed-greenplum/operations/cluster-create.md#create-cluster) in any suitable configuration with publicly available hosts and the following settings:

      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mgp_user`
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<target_password>`
      * **{{ ui-key.yacloud.mdb.forms.additional-field-datatransfer }}**: Enabled

   1. Make sure that the cluster security groups are set up correctly and allow connecting to them:

      * [{{ mmy-name }}](../../managed-mysql/operations/connect.md#configure-security-groups).
      * [{{ mgp-name }}](../../managed-greenplum/operations/connect.md#configuring-security-groups).

- Using {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [mmy-to-mgp.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-greenplum/blob/main/mmy-to-mgp.tf) configuration file to the same working directory.

      This file describes:

      * [Networks](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) for hosting the clusters.
      * [Security groups](../../vpc/concepts/security-groups.md) for making cluster connections.
      * {{ mmy-name }} source cluster.
      * {{ mgp-name }} target cluster.
      * Source endpoint.
      * Transfer.

   1. In the `mmy-to-mgp.tf` file, specify:

      * {{ MY }} and {{ GP }} versions
      * {{ MY }} and {{ GP }} user passwords

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

1. [Connect to the `mmy_db` database](../../managed-mysql/operations/connect.md) in the {{ mmy-name }} source cluster.

1. Create a simple table named `x_tab`:

   ```sql
   CREATE TABLE table1 (
   id int NOT NULL,
   name varchar (10),
   PRIMARY KEY (id)
   )
   ```

1. Populate the table with data:

   ```sql
   INSERT INTO table1 VALUES
   (1, 'Name1'),
   (2, 'Name2'),
   (3, 'Name3')
   ```

## Create a database in the target cluster {#prepare-data}

1. [Connect to the auxiliary `postgres` database](../../managed-greenplum/operations/connect.md) of the {{ mgp-name }} target cluster as `mgp_user`.

1. Create a database named `mgp_db`:

   ```sql
   CREATE DATABASE mgp_db;
   ```

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/greenplum.md) of the `{{ GP }}` type and specify the cluster connection parameters in it:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}**: `<name_of_{{ GP }}_target_cluster>` from the drop-down list.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: `mgp_db`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: `mgp_user`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: `<user_password>`.

1. Create a source endpoint and a transfer.

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/mysql.md) of the `{{ MY }}` type and specify the cluster connection parameters in it:

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}**: `<name_of_{{ MY }}_source_cluster>` from the drop-down list.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `mmy_db`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: `mmy_user`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: `<user_password>`.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.

      1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

   - Using {{ TF }} {#tf}

      1. In the `mmy-to-mgp.tf` file, specify the values for these parameters:

         * `target_endpoint_id`: ID of the target endpoint.
         * `transfer_enabled`: Set to `1` to enable transfer creation.

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

1. [Connect to the `mgp_db` database](../../managed-greenplum/operations/connect.md) in the {{ mgp-name }} target cluster.

1. Run the following query:

   ```sql
   SELECT * FROM mmy_db.table1;
   ```

### Test the replication process {#verify-replication}

1. [Connect to the {{ mmy-name }} source cluster database](../../managed-mysql/operations/connect.md).

1. Add data to `table1`:

   ```sql
   INSERT INTO table1 VALUES
   (4, 'Name4');
   ```

1. Make sure the new row has been added to the target database:

   1. [Connect to the {{ mgp-name }} target cluster database](../../managed-greenplum/operations/connect.md).
   1. Run the following query:

      ```sql
      SELECT * FROM mmy_db.table1;
      ```

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

   * [Transfer](../../data-transfer/operations/transfer.md#delete)
   * [Endpoints](../../data-transfer/operations/endpoint/index.md#delete)
   * [{{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md)
   * [{{ mgp-name }} cluster](../../managed-greenplum/operations/cluster-delete.md)

- Using {{ TF }} {#tf}

   If you created your resources using {{ TF }}:

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `mmy-to-mgp.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `mmy-to-mgp.tf` configuration file will be deleted.

{% endlist %}

