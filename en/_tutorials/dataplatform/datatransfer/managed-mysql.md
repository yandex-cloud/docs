# Migrating data via {{ data-transfer-full-name }} {#data-transfer}



To migrate a database from {{ MY }} to {{ mmy-name }} using {{ data-transfer-full-name }}:

1. [Start the data transfer](#start-transfer).
1. [Complete the data transfer](#finish-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

* {{ mmy-name }} cluster: computing resources allocated to hosts, storage and backup size (see [{{ mmy-name }} pricing](../../../managed-mysql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Each transfer: use of computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Start the data transfer {#start-transfer}

1. [Prepare the source cluster](../../../data-transfer/operations/prepare.md#source-my).
1. Prepare the infrastructure and start the data transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. Create a [target {{ mmy-name }} cluster](../../../managed-mysql/operations/cluster-create.md) with your preferred configuration. In this case, the following applies:

            * The {{ MY }} version must be the same or higher than the version in the source cluster.

                Data transfer with a major {{ MY }} version upgrade is possible but not guaranteed. For more information, see [this {{ MY }} guide](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

                Migration with a {{ MY }} version downgrade is [not supported](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

            * [SQL mode](../../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

        1. [Prepare the target cluster](../../../data-transfer/operations/prepare.md#target-my).

        1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
            * Name the endpoint.
            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.on_premise.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.host.title }}**: Specify the IP address or FQDN of your target host.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.port.title }}**: Specify the port number for connection to the source cluster.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the database name for your on-premise installation.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the database.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: Enter the user password.

        1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
            * Name the endpoint.
            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.title }}**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.connection.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
                * **Managed DB cluster**: Select the target cluster from the list.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the database name in the target cluster.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the database.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: Enter the user password.

        1. [Create](../../../data-transfer/operations/transfer.md#create) a _{{ dt-type-copy-repl }}_-type transfer and configure it to use the previously created endpoints.
        1. [Activate](../../../data-transfer/operations/transfer.md#activate) the transfer.

            {% note warning %}

            Do not make any schema changes in the source or target cluster during the transfer. For details, see [{#T}](../../../data-transfer/operations/db-actions.md).

            {% endnote %}

    - {{ TF }} {#tf}

        1. [Prepare the source cluster](../../../data-transfer/operations/prepare.md#source-my).

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [data-transfer-mysql-mmy.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-mysql-to-cloud/blob/main/data-transfer-mysql-mmy.tf) configuration file to your current working directory.

            This file describes:

            * [Network](../../../vpc/concepts/network.md#network).
            * [Subnet](../../../vpc/concepts/network.md#subnet).
            * [Security group](../../../vpc/concepts/security-groups.md) and the rule allowing inbound cluster connections.
            * {{ mmy-name }} target cluster.
            * Source endpoint.
            * Target endpoint.
            * Transfer.

        1. In `data-transfer-mysql-mmy.tf`, specify the following:

            * [Source endpoint settings](../../../data-transfer/operations/endpoint/source/mysql.md#on-premise).
            * [Target endpoint settings](../../../data-transfer/operations/endpoint/target/mysql.md#managed-service) inherited from the target cluster configuration:

                * `target_mysql_version`: {{ MY }} version. This version must be the same or higher than the version in the source cluster.
                * `target_sql_mode`: [SQL mode](../../../managed-mysql/concepts/settings-list.md#setting-sql-mode). It must be the same as in the source cluster.
                * `target_db_name`: Database name.
                * `target_user` and `target_password`: Username and password of the database owner.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

            Once created, the transfer becomes active automatically.

    {% endlist %}

## Complete the data transfer {#finish-transfer}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to <q>read-only</q> mode and transfer the workload to the target cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to drop to zero. This means that all changes made in the source cluster after the initial data copy have been transferred to the target cluster.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

    For more information about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

## Delete the resources you created {#clear-out}


Some resources are not free of charge. Delete the resources you no longer need, so you will not be charged for them:


{% list tabs group=instructions %}

- Manually {#manual}

    1. Once the transfer is stopped, [delete it](../../../data-transfer/operations/transfer.md#delete).
    1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
    1. [Delete the {{ mmy-name }} cluster](../../../managed-mysql/operations/cluster-delete.md).

    
    1. If static public IP addresses were used for accessing the cluster hosts, release and [delete them](../../../vpc/operations/address-delete.md).


- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}


For a real example of {{ MY }} database migration using {{ data-transfer-name }}, see [Syncing MySQL data using {{ data-transfer-full-name }}](../../../tutorials/dataplatform/sync-mysql.md).
