## Delivering data from {{ mpg-full-name }} to {{ mos-full-name }} using {{ data-transfer-full-name }}

You can migrate a database from {{ mpg-full-name }} to {{ mos-full-name }} using {{ data-transfer-full-name }}. To do this:

1. [Set up your transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mpg-name }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ mpg-name }} pricing](../../../managed-postgresql/pricing.md)).
* {{ mos-name }} cluster fee: Using computing resources allocated to hosts (including hosts with the `MANAGER` role) and disk space (see [{{ mos-name }} pricing](../../../managed-opensearch/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Per-transfer fee: Using computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. Create a source {{ mpg-name }} cluster in any applicable [configuration](../../../managed-postgresql/concepts/instance-types.md) with publicly available hosts and the following settings:
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `pg-user`.
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<source_password>`.

    1. [Create a {{ mos-name }}](../../../managed-opensearch/operations/cluster-create.md) target cluster in any suitable configuration with publicly available hosts.

    1. [Get an SSL certificate](../../../managed-opensearch/operations/connect.md#ssl-certificate) to connect to the {{ mos-name }} target cluster.

    1. Configure security groups for connection to the [{{ mpg-name }}](../../../managed-postgresql/operations/connect.md#configuring-security-groups) source cluster and the [{{ mos-name }}](../../../managed-opensearch/operations/connect#configuring-security-groups) target cluster.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [postgresql-to-opensearch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-postgresql-to-opensearch/blob/main/postgresql-to-opensearch.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network).
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) for connection to clusters.
        * {{ mpg-name }} source cluster.
        * {{ mos-name }} target cluster.
        * Source endpoint.
        * Transfer.

    1. In the `postgresql-to-opensearch.tf` file, specify the values of the following variables:

        * `folder_id`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
        * `pg_password`: {{ PG }} user password.
        * `mos_version`: {{ OS }} version.
        * `mos_password`: {{ OS }} user password.
        * `profile_name`: Your YC CLI profile name.

           {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Set up your transfer {#prepare-transfer}

1. [Connect to the {{ mpg-name }} cluster](../../../managed-postgresql/operations/connect.md), create a table named `x_tab` in the `db1` database and populate it with data:

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

1. [Create a target endpoint](../../../data-transfer/operations/endpoint/target/opensearch.md) with the following parameters:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}**: Select a {{ mos-name }} cluster from the list.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}**: `admin`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}**: `<user_password>`.

1. Create a source endpoint and transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

      1. [Create a source endpoint](../../../data-transfer/operations/endpoint/source/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<{{ PG }}_source_cluster_name>` from the drop-down list.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `<user_password>`.

      1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_** type that will use the created endpoints.

      1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).

    - {{ TF }} {#tf}

      1. In the `postgresql-to-opensearch.tf` file, specify the values of the following variables:

          * `target_endpoint_id`: Target endpoint ID.
          * `transfer_enabled`: `1` to create a transfer.

      1. Make sure the {{ TF }} configuration files are correct using this command:

          ```bash
          terraform validate
          ```

          If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure:

          {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

          Once created, your transfer will be activated automatically.

    {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Connect to the target cluster using [{{ OS }} Dashboards](../../../managed-opensearch/operations/connect.md#dashboards).
1. Select the `Global` tenant.
1. Create a new index template named `public.x_tab`:

    1. Open the control panel by clicking ![os-dashboards-sandwich](../../../_assets/console-icons/bars.svg).
    1. Under **Management**, select **Stack Management**.
    1. Go to the **Index Patterns** section and click **Create index pattern**.
    1. In the **Index pattern name** field, specify `public.x_tab` and click **Next step**.
    1. Click **Create index pattern**.

1. Open the control panel by clicking ![os-dashboards-sandwich](../../../_assets/console-icons/bars.svg).
1. Under **OpenSearch Dashboards**, select **Discover**.
1. The dashboard that opens should contain data from the {{ mpg-name }} database.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

[Delete the target endpoint](../../../data-transfer/operations/endpoint/index.md#delete).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the {{ mos-name }} cluster](../../../managed-opensearch/operations/cluster-delete.md).
    1. [Delete the {{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-delete.md).
    1. [Delete the source endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
    1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}

