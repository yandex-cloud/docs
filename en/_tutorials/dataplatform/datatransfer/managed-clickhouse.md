# Migrating data using {{ data-transfer-full-name }}

With {{ data-transfer-name }}, you can transfer your database from a third-party {{ CH }} source cluster to a {{ mch-name }} target cluster.

This method allows you to:

* Copy the database without interrupting user service.
* Go without creating an intermediate VM or granting online access to your {{ mch-name }} target cluster.

You can also use this method to transfer data between two {{ mch-name }} clusters. For a successful transfer, specify the `8443` and `9440` ports in the source endpoint and add the [SSL certificate](../../../managed-clickhouse/operations/connect/index.md#get-ssl-cert).

To learn more, see [{#T}](../../../data-transfer/concepts/use-cases.md).


## Getting started {#before-you-begin}

[Allow connecting to the source cluster from the internet](../../../data-transfer/concepts/network.md#source-external).

### Required paid resources {#paid-resources}

The support cost includes:

* {{ mch-name }} cluster fee: Using computing resources allocated to hosts (including ZooKeeper hosts) and disk space (see [{{ mch-name }} pricing](../../../managed-clickhouse/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Transfer fee: Use of computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Transferring data {#data-transfer}

1. [Prepare the source cluster](../../../data-transfer/operations/prepare.md#source-ch).
1. Set up your infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a security group](../../../vpc/operations/security-group-create.md) and [configure it](../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

        1. [Create a {{ mch-name }} target cluster](../../../managed-clickhouse/operations/cluster-create.md) with the computing capacity and storage size appropriate for the environment where the copied database is deployed.

            When creating a cluster, specify the security group prepared earlier.

            The database name in the target cluster must be the same as the source database name.

            If you are going to connect to the cluster via [{{ websql-full-name }}](../../../websql/concepts/index.md), enable **{{ ui-key.yacloud.mdb.cluster.overview.label_access-websql-service }}** in the cluster settings.

        1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `ClickHouse`
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.on_premise.title }}`

                Specify the parameters for connecting to the source cluster.

        1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `ClickHouse`
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`

                Select a target cluster from the list and specify its connection settings.

        1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy }}_ type that will use the created endpoints and [activate](../../../data-transfer/operations/transfer.md#activate) it.

    - Using {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [data-transfer-ch-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-clickhouse-to-cloud/blob/main/data-transfer-ch-mch.tf) configuration file to the same working directory.

            This file describes:

            * [Network](../../../vpc/concepts/network.md#network).
            * [Subnet](../../../vpc/concepts/network.md#subnet).
            * [Security group](../../../vpc/concepts/security-groups.md) and the rule required to connect to a cluster.
            * {{ mch-name }} target cluster.
            * Source endpoint.
            * Target endpoint.
            * Transfer.

        1. Specify the following in the `data-transfer-ch-mch.tf` file:

            * [Source endpoint parameters](../../../data-transfer/operations/endpoint/source/clickhouse.md#on-premise):
                * `source_user` and `source_pwd`: Username and password to access the source.
                * `source_db_name`: Database name.
                * `source_host`: FQDN or IP address of the {{ CH }} server.
                * `source_shard`: Shard name.
                * `source_http_port` and `source_native_port`: HTTP and {{ CH }} native interface connection ports.

            * Target cluster parameters also used as [target endpoint parameters](../../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

                * `target_clickhouse_version`: {{ CH }} version.
                * `target_user` and `target_password`: Name and user password of the database owner.

            * [{{ yandex-cloud }} CLI](../../../cli/) parameters to activate the cluster automatically:

                * `profile_name`: Name of your {{ yandex-cloud }} CLI profile.

                    {% include [cli-install](../../../_includes/cli-install.md) %}

        1. (Optional) If you are going to connect to the cluster via [{{ websql-full-name }}](../../../websql/concepts/index.md), add the `access` section to the cluster resource:

            ```hcl
            access {
                web_sql = true
            }
            ```

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

            Once created, your transfer will be activated automatically.

    {% endlist %}

## Test your transfer {#verify-transfer}

1. Wait until the transfer status switches to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Make sure the data from the source {{ CH }} cluster has been moved to the {{ mch-name }} database:

    {% list tabs group=instructions %}
    
    
    - {{ websql-full-name }} {#websql}

        1. [Create a connection](../../../websql/operations/create-connection.md#connect-cluster) to the {{ mch-name }} cluster database.
        1. Make sure the DB contains the tables from the source cluster. To do this, [run this query](../../../websql/operations/query-executor.md#execute-query) to the database via the connection you created:

            ```sql
            SHOW TABLES FROM <DB_name>;
            ```

        1. Make sure the tables contain data from the source cluster tables. To do this, [run this query](../../../websql/operations/query-executor.md#execute-query) to the table via the connection you created:

            ```sql
            SELECT * FROM <DB_name>.<table_name>;
            ```


    - CLI {#cli}

        1. [Get an SSL certificate](../../../managed-clickhouse/operations/connect/index.md#get-ssl-cert) to connect to the {{ mch-name }} cluster.      
        1. [Connect to the database](../../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) in the {{ mch-name }} cluster using `clickhouse-client`.
        1. Make sure the DB contains the tables from the source cluster:

            ```sql
            SHOW TABLES FROM <DB_name>;
            ```
 
        1. Make sure the tables contain data from the source cluster tables:

            ```sql
            SELECT * FROM <DB_name>.<table_name>;
            ```

    {% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

  * [Delete the {{ mch-name }}](../../../managed-clickhouse/operations/cluster-delete.md) cluster.
  * [Delete the completed transfer](../../../data-transfer/operations/transfer.md#delete).
  * [Delete the endpoints](../../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.

- Using {{ TF }} {#tf}

  {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
