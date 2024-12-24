You can migrate a database from {{ GP }} to {{ CH }} using {{ data-transfer-full-name }}.

To transfer a database from {{ GP }} to {{ CH }}:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Check the copy function upon re-activation](#example-check-copy).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

For clarity, we will create all required resources in {{ yandex-cloud }}. Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mgp-full-name }} source cluster](../../managed-greenplum/operations/cluster-create.md#create-cluster) in any suitable configuration.

    1. [Create a {{ mch-full-name }} target cluster](../../managed-clickhouse/operations/cluster-create.md#create-cluster) in any suitable configuration with a database named `db1`.


    1. If you are using security groups in clusters, make sure they are set up correctly and allow connecting to the clusters:

        * [{{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
        * [{{ mgp-name }}](../../managed-greenplum/operations/connect.md#configuring-security-groups).


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [greenplum-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-greenplum-to-clickhouse/blob/main/greenplum-clickhouse.tf) configuration file to the same working directory.

        This file describes:

        * [Networks](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) for hosting the clusters.


        * [Security groups](../../vpc/concepts/security-groups.md) for connecting to clusters.


        * {{ mgp-name }} source cluster.
        * {{ mch-name }} target cluster.

    1. In the `greenplum-clickhouse.tf` file, specify the passwords of the {{ GP }} and {{ CH }} admin user.
    1. Check that the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up the transfer {#prepare-transfer}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/greenplum.md) of the `{{ GP }}` type, and specify the cluster connection settings in it.

1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/clickhouse.md) of the `ClickHouse` type.

1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the [{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}](../../data-transfer/concepts/index.md#transfer-type) type that will use the created endpoints.

    Replication is not available for this endpoint pair, but you can set up regular copying when creating a transfer. To do this, in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}** field under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.title }}**, select **Regular** and specify the copy interval. This will activate a transfer automatically after the specified time interval.

    {% note warning %}

    Before configuring regular copying, make sure the [target endpoint parameters](../../data-transfer/operations/endpoint/target/clickhouse#additional-settings) idicate either a `Drop` or a `Truncate` cleanup policy. Otherwise, data on the target will be duplicated.

    {% endnote %}

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
1. To check that the data was transferred correctly, connect to the {{ mch-name }} target cluster and make sure that the columns of the `x_tab` table in the `db1` database match those of the `x_tab` table in the source database:

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

1. [Connect to the {{ mgp-name }} cluster](../../managed-greenplum/operations/connect.md); in the `x_tab` table, delete one row and update one:

    ```sql
    DELETE FROM x_tab WHERE id = 41;
    UPDATE x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. [Reactivate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Check the changes in the `x_tab` table of the {{ CH }} target:

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

* Make sure the transfer has the **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}** status and [delete](../../data-transfer/operations/transfer.md#delete) it.
* [Delete both the source endpoint and the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
* Delete the clusters:

    {% list tabs group=instructions %}

    - Manually {#manual}

        * [{{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).
        * [{{ mgp-name }}](../../managed-greenplum/operations/cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}

