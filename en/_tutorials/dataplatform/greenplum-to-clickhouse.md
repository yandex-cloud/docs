You can migrate a database from {{ GP }} to {{ CH }} using {{ data-transfer-full-name }}.

To transfer a database from {{ GP }} to {{ CH }}:

1. [Set up your transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Verify replication after reactivation](#example-check-copy).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mgp-name }} cluster fee: Covers the use of computational resources allocated to hosts and disk storage (see [{{ mgp-name }} pricing](../../managed-greenplum/pricing/index.md)).

* {{ mch-name }} cluster fee: Covers the use of computational resources allocated to hosts (including ZooKeeper hosts) and disk storage (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).

* Fee for public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).

* Transfer fee: Based on computational resource consumption and the total number of data rows transferred (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

In our example, we will create all required resources in {{ yandex-cloud }}. Set up the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mgp-full-name }} source cluster](../../managed-greenplum/operations/cluster-create.md#create-cluster) in any suitable configuration.

    1. [Create a {{ mch-full-name }} target cluster](../../managed-clickhouse/operations/cluster-create.md#create-cluster) with a database named `db1` using any suitable configuration.

    
    1. If using security groups, make sure they are configured correctly and allow inbound connections to the clusters.

        * [{{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
        * [{{ mgp-name }}](../../managed-greenplum/operations/connect.md#configuring-security-groups).


    1. Create a `{{ CH }}` [target endpoint](../../data-transfer/operations/endpoint/target/clickhouse.md). In the endpoint [settings](../../data-transfer/operations/endpoint/target/clickhouse.md#additional-settings), specify `Drop` or `Truncate` as the cleanup policy to prevent duplication of copied data.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [greenplum-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-greenplum-to-clickhouse/blob/main/greenplum-clickhouse.tf) configuration file to your current working directory.

        This file describes:

        * [Networks](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) where your clusters will be hosted.

        
        * [Security groups](../../vpc/concepts/security-groups.md) for cluster access.


        * {{ mgp-name }} source cluster.
        * {{ mch-name }} target cluster.
        * Target endpoint.

    1. In the `greenplum-clickhouse.tf` file, specify the following:

        * `mgp_password`: {{ GP }} admin password.
        * `mch_db`: {{ CH }} database name.
        * `mch_user`: {{ CH }} database user name.
        * `mch_password`: {{ CH }} database user password.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up your transfer {#prepare-transfer}

1. Create a `{{ GP }}` [source endpoint](../../data-transfer/operations/endpoint/source/greenplum.md) and specify its cluster connection settings.

1. [Create](../../data-transfer/operations/transfer.md#create) a [{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}](../../data-transfer/concepts/index.md#transfer-type) transfer that uses endpoints for the source and target.

    While real-time replication is not supported for this endpoint pair, you can configure regular copying while creating the transfer. To do this, in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.title }}** field under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}**, select **Regular** and specify the copy interval. The transfer will automatically activate after the specified interval.

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
1. To verify the data transfer, connect to the {{ mch-name }} target cluster and check whether the columns of the `x_tab` table in the `db1` database match those of the `x_tab` table in the source database:

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

## Test the copy function upon re-activation {#example-check-copy}

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

Some resources incur charges. To avoid paying for them, delete the resources you no longer need:

1. Make sure the transfer has the **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}** status and [delete](../../data-transfer/operations/transfer.md#delete) it.
1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
1. Delete other resources using the method matching their creation method:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Delete](../../managed-clickhouse/operations/cluster-delete.md) the {{ mch-name }} cluster.
        1. [Delete](../../managed-greenplum/operations/cluster-delete.md) the {{ mgp-name }} cluster.
        1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}

