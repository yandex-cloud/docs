# Migrating data using {{ data-transfer-full-name }}

With {{ data-transfer-name }}, you can transfer your database from a third-party {{ CH }} source cluster to a {{ mch-name }} target cluster.

This method enables you to:

* Copy the database without interrupting user service.
* Eliminate the need for an intermediate VM or public internet access to your {{ mch-name }} target cluster.

You can also use this method to transfer data between two {{ mch-name }} clusters. For a successful transfer, specify the listening ports `8443` and `9440` on the source endpoint and add an [SSL certificate](../../../managed-clickhouse/operations/connect/index.md#get-ssl-cert).

For more information, see [{#T}](../../../data-transfer/concepts/use-cases.md).


## Getting started {#before-you-begin}

[Enable inbound internet connections to the source cluster](../../../data-transfer/concepts/network.md#source-external).

### Required paid resources {#paid-resources}

* {{ mch-name }} cluster: Use of computing resources allocated to hosts, storage and backup size (see [{{ mch-name }} pricing](../../../managed-clickhouse/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Each transfer: Use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Transferring data {#data-transfer}

1. [Prepare the source cluster](../../../data-transfer/operations/prepare.md#source-ch).
1. Set up the infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a security group](../../../vpc/operations/security-group-create.md) and [configure it](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

        1. [Create a {{ mch-name }} target cluster](../../../managed-clickhouse/operations/cluster-create.md) with the computing and storage capacity matching the source database’s environment.

            When creating a cluster, specify the security group you created earlier.

            The source and target database names must be the same.

            To connect to the cluster via [{{ websql-full-name }}](../../../websql/concepts/index.md), enable **{{ ui-key.yacloud.mdb.cluster.overview.label_access-websql-service }}** in the cluster settings.

        1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `ClickHouse`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.on_premise.title }}`.

                Specify the source cluster connection settings.

        1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `ClickHouse`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`.

                Select your target cluster from the list and specify its connection settings.

        1. Create a _{{ dt-type-copy }}_-type [transfer](../../../data-transfer/operations/transfer.md#create), configure it to use the previously created endpoints, then [activate](../../../data-transfer/operations/transfer.md#activate) it.

    - Using {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [data-transfer-ch-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-clickhouse-to-cloud/blob/main/data-transfer-ch-mch.tf) configuration file to the same working directory.

            This file describes:

            * [Network](../../../vpc/concepts/network.md#network).
            * [Subnet](../../../vpc/concepts/network.md#subnet).
            * [Security group](../../../vpc/concepts/security-groups.md) and the rule required for connecting to a cluster.
            * {{ mch-name }} target cluster.
            * Source endpoint.
            * Target endpoint.
            * Transfer.

        1. In the `data-transfer-ch-mch.tf` file, specify the following:

            * [Source endpoint parameters](../../../data-transfer/operations/endpoint/source/clickhouse.md#on-premise):
                * `source_user` and `source_pwd`: Username and password to access the source database.
                * `source_db_name`: Database name.
                * `source_host`: {{ CH }} server IP address or FQDN.
                * `source_shard`: Shard name.
                * `source_http_port` and `source_native_port`: HTTP and {{ CH }} native interface ports.

            * Target cluster parameters used as [target endpoint parameters](../../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

                * `target_clickhouse_version`: {{ CH }} version.
                * `target_user` and `target_password`: Database owner username and password.

            * [{{ yandex-cloud }} CLI](../../../cli/) parameters for automating cluster activation:

                * `profile_name`: {{ yandex-cloud }} CLI profile name.

                    {% include [cli-install](../../../_includes/cli-install.md) %}

        1. Optionally, to enable connections via [{{ websql-full-name }}](../../../websql/concepts/index.md), add the `access` section to the cluster resource:

            ```hcl
            access {
                web_sql = true
            }
            ```

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will show any errors found in your configuration files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

            Once created, your transfer will be activated automatically.

    {% endlist %}

## Test your transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Check that the data has been transferred from the source {{ CH }} cluster to the {{ mch-name }} database:

    {% list tabs group=instructions %}
    
    
    - {{ websql-full-name }} {#websql}

        1. [Create a connection](../../../websql/operations/create-connection.md#connect-cluster) to the database in the {{ mch-name }} cluster.
        1. Check that the database contains all tables from the source cluster by [running the following query](../../../websql/operations/query-executor.md#execute-query) via the connection you created:

            ```sql
            SHOW TABLES FROM <DB_name>;
            ```

        1. Check that the tables contain the same data as the source cluster tables by [running the following query](../../../websql/operations/query-executor.md#execute-query) against them:

            ```sql
            SELECT * FROM <DB_name>.<table_name>;
            ```


    - CLI {#cli}

        1. [Get an SSL certificate](../../../managed-clickhouse/operations/connect/index.md#get-ssl-cert) to connect to the {{ mch-name }} cluster.      
        1. [Connect to the database](../../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) in the {{ mch-name }} cluster via `clickhouse-client`.
        1. Check that the database contains all tables from the source cluster:

            ```sql
            SHOW TABLES FROM <DB_name>;
            ```
 
        1. Check that the tables contain the same data as the source cluster tables:

            ```sql
            SELECT * FROM <DB_name>.<table_name>;
            ```

    {% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Delete the {{ mch-name }}](../../../managed-clickhouse/operations/cluster-delete.md) cluster.
  1. [Delete the completed transfer](../../../data-transfer/operations/transfer.md#delete).
  1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).

- Using {{ TF }} {#tf}

  {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
