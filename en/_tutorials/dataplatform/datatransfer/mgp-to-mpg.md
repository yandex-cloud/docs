You can migrate a database from {{ GP }} to the {{ PG }} cluster using {{ data-transfer-full-name }}.

To transfer a database from {{ GP }} to {{ PG }}:

1. [Set up the transfer](#prepare-transfer).
1. [Activate the transfer](#activate-transfer).
1. [Test copying after reactivation](#example-check-copy).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mgp-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mgp-name }} pricing](../../../managed-greenplum/pricing/index.md)).
* {{ mpg-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../../managed-postgresql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

In our example, we will create all required resources in {{ yandex-cloud }}. Set up the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    {% include [public-access](../../../_includes/mdb/note-public-access.md) %}

    1. [Create a {{ GP }} source cluster](../../../managed-greenplum/operations/cluster-create.md#create-cluster) in any suitable configuration with the `gp-user` admin username and public hosts.

    1. [Create a {{ mpg-full-name }} target cluster](../../../managed-postgresql/operations/cluster-create.md#create-cluster) using any suitable configuration with publicly accessible hosts. When creating a cluster, specify:

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.

    
    1. If using security groups, make sure they are configured correctly and allow inbound connections to the clusters:

        * [{{ mpg-name }}](../../../managed-postgresql/operations/connect.md#configuring-security-groups).
        * [{{ mgp-name }}](../../../managed-greenplum/operations/connect.md#configuring-security-groups).


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [greenplum-postgresql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-greenplum-to-postgresql/blob/main/greenplum-postgresql.tf) configuration file to the same working directory.

        This file describes:

        * [Networks](../../../vpc/concepts/network.md#network) and [subnets](../../../vpc/concepts/network.md#subnet) that will host your clusters.
        * [Security groups](../../../vpc/concepts/security-groups.md) to connect to clusters.
        * {{ GP }} source cluster in {{ mgp-name }}.
        * {{ mpg-name }} target cluster.
        * Target endpoint.
        * Transfer.

    1. In the `greenplum-postgresql.tf` file, specify the admin user passwords and {{ GP }} and {{ PG }} versions.
    1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use its resources and data sources.
    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up the transfer {#prepare-transfer}

1. [Create a `{{ GP }}`-type source endpoint](../../../data-transfer/operations/endpoint/source/greenplum.md) and configure it using the following settings:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}**: `<{{ GP }}_source_cluster_name>` from the drop-down list
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: `postgres`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: `gp-user`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: `<user_password>`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.service_schema.title }}**: `public`.

1. Create a target endpoint and a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a `{{ PG }}` target endpoint](../../../data-transfer/operations/endpoint/target/postgresql.md) with these cluster connection settings:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `Yandex Managed Service for PostgreSQL cluster`
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<{{ PG }}_target_cluster_name>` from the drop-down list.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `<user_password>`.

        1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**-type that will use the endpoints you created.

            While real-time replication is not supported for this endpoint pair, you can configure regular copying while creating the transfer. To do this, in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}** field under **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.title }}**, select **Regular** and specify the copy interval. The transfer will automatically activate after the specified interval.

            {% note warning %}

            Before setting up regular copying, verify that the [target endpoint](../../../data-transfer/operations/endpoint/target/postgresql.md#additional-settings) is configured with a `DROP` or `TRUNCATE` cleanup policy to prevent data duplication.

            {% endnote %}

    - {{ TF }} {#tf}

        1. In the `greenplum-postgresql.tf` file, specify the following variables:

            * `gp_source_endpoint_id`: Source endpoint ID.
            * `transfer_enabled`: Set to `1` to create a transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Activate the transfer {#activate-transfer}

1. [Connect to the {{ GP }} cluster](../../../managed-greenplum/operations/connect.md), create a table named `x_tab`, and populate it with data:

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

1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. To check that the data was transferred correctly, connect to the {{ mpg-name }} target cluster and make sure that the columns of the `x_tab` table in the `db1` database match those of the `x_tab` table in the source database:

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

## Verify that the copy operation works upon reactivation {#example-check-copy}

1. In the [target endpoint parameters](../../../data-transfer/operations/endpoint/target/postgresql.md#additional-settings), select either `DROP` or `TRUNCATE` as cleanup policy.
1. [Connect to the {{ GP }} cluster](../../../managed-greenplum/operations/connect.md).
1. In the `x_tab` table, delete the row with the `41` ID and update the one with the `42` ID:

    ```sql
    DELETE FROM x_tab WHERE id = 41;
    UPDATE x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. [Reactivate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Check the changes in the `x_tab` table of the {{ PG }} target:

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

To reduce the consumption of resources, delete those you do not need:

1. Make sure the transfer status is **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**, upon which you can [delete](../../../data-transfer/operations/transfer.md#delete) the transfer.
1. [Delete both the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
1. Delete the other resources depending on how you created them:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Delete the {{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-delete.md).
        1. [Delete the {{ mgp-name }} cluster](../../../managed-greenplum/operations/cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
