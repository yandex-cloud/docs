# Copying data from {{ mos-name }} to {{ mch-name }} using {{ data-transfer-full-name }}

{{ data-transfer-name }} enables you to transfer data from a {{ mos-name }} source cluster to {{ mch-name }}.

To transfer data:

1. [Prepare the source cluster](#prepare-source).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mos-name }} cluster: Use of computing resources and storage size (see [{{ mos-name }} pricing](../../../managed-opensearch/pricing.md)).
* {{ mch-name }} cluster: Use of computing resources allocated to hosts, storage and backup size (see [{{ mch-name }} pricing](../../../managed-clickhouse/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

Set up your data delivery infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mos-name }} source cluster](../../../managed-opensearch/operations/cluster-create.md#create-cluster) with any suitable configuration and publicly accessible hosts.
    1. In the same [availability zone](../../../overview/concepts/geo-scope.md), [create a {{ mch-name }} target cluster](../../../managed-clickhouse/operations/cluster-create.md#create-cluster) with any suitable configuration and publicly accessible hosts.

       To connect to the cluster via {{ websql-full-name }}, enable **{{ ui-key.yacloud.mdb.cluster.overview.label_access-websql-service }}** in the cluster settings.

    1. [Get an SSL certificate](../../../managed-opensearch/operations/connect.md#ssl-certificate) to connect to the {{ mos-name }} cluster.

    1. Make sure the [{{ mos-name }}](../../../managed-opensearch/operations/connect.md#security-groups) and [{{ mch-name }}](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) cluster security groups allow connecting from the internet.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [opensearch-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-clickhouse/blob/main/opensearch-to-clickhouse.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network).
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) and rules allowing connections to the {{ mos-name }} and {{ mch-name }} clusters.
        * {{ mos-name }} source cluster and its `admin` account.
        * {{ mch-name }} target cluster, its user account, and a database.
        * Target endpoint.
        * Transfer.

    1. In the `opensearch-to-clickhouse.tf` file, specify the following settings:

        * `source_admin_password`: {{ mos-name }} cluster `admin` password.
        * `mos_version`: {{ OS }} version.
        * `mch_db_name`: {{ mch-name }} cluster database name.
        * `mch_username`: {{ mch-name }} cluster user name.
        * `mch_user_password`: {{ mch-name }} cluster user password.
        * `source_endpoint_id`: Source endpoint ID.
        * `profile_name`: Name of your CLI profile.

           {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will show any errors found in your configuration files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare your test data {#prepare-data}

1. In the source cluster, create a test index named `people` and define its schema:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <user_name_in_source_cluster>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <user_name_in_source_cluster>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_mapping?pretty' \
         --data'
         {
               "properties": {
                  "name": {"type": "text"},
                  "age": {"type": "integer"}
               }
         }
         '
    ```

1. Populate the test index with data:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <user_name_in_source_cluster>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_doc/?pretty' \
         --data'
         {
               "name": "Alice",
               "age": "30"
         }
         ' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <user_name_in_source_cluster>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_doc/?pretty' \
         --data'
         {
               "name": "Robert",
               "age": "32"
         }
         '
    ```

1. Optionally, check the data in the test index:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <user_name_in_target_cluster>:<user_password_in_target_cluster> \
         --header 'Content-Type: application/json' \
         --request GET 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_search?pretty'
    ```

## Set up and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create) for your [pre-configured](#before-you-begin) {{ mos-name }} cluster using the following settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `OpenSearch`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchSource.connection.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}**: Select your {{ mos-name }} cluster from the list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}**: `admin`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}**: `admin` password.

1. Create a target endpoint and set up the transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `ClickHouse`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}**:
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.managed.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}**: Select the {{ mch-name }} cluster from the list.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}**: Enter the {{ mch-name }} cluster user name.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}**: Enter the {{ mch-name }} cluster user password.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}**: Enter the {{ mch-name }} cluster database name.

        1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}** type that will use the endpoints you created.
        1. [Activate](../../../data-transfer/operations/transfer.md#activate) the transfer.

    - {{ TF }} {#tf}

        1. In the `opensearch-to-clickhouse.tf` file, specify the following settings:

            * `source_endpoint_id`: Source endpoint ID.
            * `transfer_enabled`: Set to `1` for creating a target endpoint and transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will show any errors found in your configuration files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            The transfer will be activated automatically upon creation.

    {% endlist %}

## Test your transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Make sure the data from the source {{ mos-name }} cluster has been transferred to the {{ mch-name }} database:

    {% list tabs group=instructions %}

    - {{ websql-full-name }} {#websql}

      1. [Create a connection](../../../websql/operations/create-connection.md#connect-cluster) to the database in the {{ mch-name }} cluster.
      1. Make sure the database contains the `people` table populated with test data by [running the following query](../../../websql/operations/query-executor.md#execute-query) via the connection you created:

         ```sql
         SELECT * FROM people;
         ```

    - CLI {#cli}

      1. [Get an SSL certificate](../../../managed-clickhouse/operations/connect/index.md#get-ssl-cert) to connect to the {{ mch-name }} cluster.
      1. If you do not have `clickhouse-client`, [install it](../../../managed-clickhouse/operations/connect/clients.md#clickhouse-client).
      1. [Connect to the database](../../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) in the {{ mch-name }} cluster.
      1. Check that the database contains the `people` table populated with test data:

         ```sql
         SELECT * FROM people;
         ```

    {% endlist %}

## Delete the resources you created {#clear-out}

To reduce the consumption of resources, delete those you do not need:

1. [Delete the source endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
1. Delete other resources depending on how they were created:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
        1. [Delete the target endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
        1. [Delete the {{ mos-name }} cluster](../../../managed-opensearch/operations/cluster-delete.md).
        1. [Delete the {{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-delete.md).

            {{ websql-full-name }} will automatically delete the database connection in the {{ mch-name }} cluster.

        1. [Delete the subnet](../../../vpc/operations/subnet-delete.md).
        1. [Delete the network](../../../vpc/operations/network-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
