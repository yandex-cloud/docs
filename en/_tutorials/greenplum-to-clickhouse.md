You can migrate a database from {{ GP }} to {{ CH }} using {{ data-transfer-full-name }}.

To transfer a database from {{ GP }} to {{ CH }}:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Check the copy function upon re-activation](#example-check-copy).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

For clarity, we will create all required resources in {{ yandex-cloud }}. Prepare the infrastructure:

{% list tabs %}

* Manually

   1. [Create a {{ mgp-full-name }} source cluster](../managed-greenplum/operations/cluster-create.md#create-cluster) of any suitable configuration.

   1. [Create a {{ mch-full-name }} target cluster](../managed-clickhouse/operations/cluster-create.md#create-cluster) with any configuration with a database called `db1`.

   
   1. If you are using security groups in your clusters, make sure they have been set up correctly and allow connection to clusters:

      * [{{ mch-name }}](../managed-clickhouse/operations/connect.md#configuring-security-groups).
      * [{{ mgp-name }}](../managed-greenplum/operations/connect.md#configuring-security-groups).

      {% include [preview-pp.md](../_includes/preview-pp.md) %}


* Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install and configure it](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download the [file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [greenplum-clickhouse.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/greenplum-clickhouse/greenplum-clickhouse.tf) configuration file to the same working directory.

      This file describes:

      * [Networks](../vpc/concepts/network.md#network) and [subnets](../vpc/concepts/network.md#subnet) for hosting the clusters.

      
      * [Security groups](../vpc/concepts/security-groups.md) for connecting to clusters.


      * {{ mgp-name }} source cluster
      * {{ mch-name }} target cluster.

   1. In the `greenplum-clickhouse.tf` configuration file, specify the {{ GP }} and {{ CH }} administrator passwords.
   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider's resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up the transfer {#prepare-transfer}

1. [Create a source endpoint](../data-transfer/operations/endpoint/source/greenplum.md) with the `{{ GP }}` type, and specify the cluster connection settings in it.

1. [Create a target endpoint](../data-transfer/operations/endpoint/target/clickhouse.md) with the `{{ CH }}` type.

1. [Create a transfer](../data-transfer/operations/transfer.md#create) with a [{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}](../data-transfer/concepts/index.md#transfer-type) type that will use the created endpoints.

   Replication is not available for this endpoint pair, but you can set up regular copying when creating a transfer. To do this, in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}** field under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.title }}**, select **Regular** and specify the copy interval. This will activate a transfer automatically after the specified time interval.

   {% note warning %}

   Before configuring regular copy, please make sure that the [target endpoint parameters](../data-transfer/operations/endpoint/target/clickhouse#additional-settings) include either a `Drop` or a `Truncate` cleanup policy. Otherwise, data on the target will be duplicated.

   {% endnote %}

## Activate the transfer {#activate-transfer}

1. [Connect to the {{ mgp-name }} cluster](../managed-greenplum/operations/connect.md), create a table called `x_tab`, and populate it with data:

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

1. [Activate the transfer](../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. To verify that the data has transferred correctly, connect to the {{ mch-name }} target cluster and make sure that the columns of the `x_tab` table in the `db1` database match those of the source database `x_tab` table:

   ```sql
   SELECT id, name FROM db1.x_tab;
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

1. [Connect to the {{ mgp-name }} cluster](../managed-greenplum/operations/connect.md), drop a single row in the `x_tab` table and update another:

   ```sql
   DELETE FROM x_tab WHERE id = 41;
   UPDATE x_tab SET name = 'Key3' WHERE id = 42;
   ```

1. [Re-activate the transfer](../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Make sure that you see the changes in the `x_tab` table on the {{ CH }} target:

   ```sql
   SELECT id, name FROM db1.x_tab;
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

* Make sure the transfer has the **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}** status and [delete](../data-transfer/operations/transfer.md#delete) it.
* [Delete both the source endpoint and the target endpoint](../data-transfer/operations/endpoint/index.md#delete).
* Delete the clusters:

   {% list tabs %}

   * Manually

      * [{{ mch-name }}](../managed-clickhouse/operations/cluster-delete.md).
      * [{{ mgp-name }}](../managed-greenplum/operations/cluster-delete.md).

   * Using {{ TF }}

      If you created your resources using {{ TF }}:

      1. In the terminal window, switch to the directory containing the infrastructure plan.
      1. Delete the `greenplum-clickhouse.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the resources have been updated.

         {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `greenplum-clickhouse.tf` configuration file will be deleted.

   {% endlist %}

