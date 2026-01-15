# Transferring data using {{ data-transfer-full-name }} {#data-transfer}

To transfer a database from {{ MY }} to {{ mmy-name }}:

1. [Start the data transfer](#start-transfer).
1. [Complete your data transfer](#finish-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mmy-name }} cluster: Computing resources allocated to hosts, storage and backup size (see [{{ mmy-name }} pricing](../../../managed-mysql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Each transfer: Use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Start the data transfer {#start-transfer}

1. [Set up the source cluster](../../../data-transfer/operations/prepare.md#source-my).
1. Set up your infrastructure and start the data transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. Create a [{{ mmy-name }} target cluster](../../../managed-mysql/operations/cluster-create.md) with your preferred configuration. For this operation, the following requirements apply:

            * The {{ MY }} version must be the same as or higher than in the source cluster.

                Data transfer with a major {{ MY }} version upgrade is possible but not guaranteed. For more information, see [this {{ MY }} article](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

                Migration to an earlier {{ MY }} version is [not supported](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

            * [SQL mode](../../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

        1. [Set up the target cluster](../../../data-transfer/operations/prepare.md#target-my).

        1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.on_premise.title }}`

                Configure the source cluster connection settings.

        1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`

                Select your target cluster from the list and specify its connection settings.

        1. [Create](../../../data-transfer/operations/transfer.md#create) a _{{ dt-type-copy-repl }}_-type transfer configured to use the new endpoints.
        1. [Activate](../../../data-transfer/operations/transfer.md#activate) the transfer.

            {% note warning %}

            Do not make any data schema changes in the source or target cluster during the transfer. For more information, see [{#T}](../../../data-transfer/operations/db-actions.md).

            {% endnote %}

    - {{ TF }} {#tf}

        1. [Prepare the source cluster](../../../data-transfer/operations/prepare.md#source-my).

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [data-transfer-mysql-mmy.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-mysql-to-cloud/blob/main/data-transfer-mysql-mmy.tf) configuration file to the same working directory.

            This file describes:

            * [Network](../../../vpc/concepts/network.md#network).
            * [Subnet](../../../vpc/concepts/network.md#subnet).
            * [Security group](../../../vpc/concepts/security-groups.md) and the rule permitting access to the cluster.
            * {{ mmy-name }} target cluster.
            * Source endpoint.
            * Target endpoint.
            * Transfer.

        1. In the `data-transfer-mysql-mmy.tf` file, specify the following:

            * [Source endpoint parameters](../../../data-transfer/operations/endpoint/source/mysql.md#on-premise).
            * [Target endpoint settings](../../../data-transfer/operations/endpoint/target/mysql.md#managed-service) inherited from the target cluster configuration:

                * `target_mysql_version`: {{ MY }} version. Make sure it is the same as or higher than in the source cluster.
                * `target_sql_mode`: [SQL mode](../../../managed-mysql/concepts/settings-list.md#setting-sql-mode). It must be the same as in the source cluster.
                * `target_db_name`: Database name.
                * `target_user` and `target_password`: Database owner username and password.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

            The transfer will activate automatically upon creation.

    {% endlist %}

## Complete your data transfer {#finish-transfer}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to <q>read-only</q> mode and move the workload to the target cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait until the **Maximum data transfer delay** value drops to zero. This indicates that the target cluster now contains all changes made in the source cluster after the data copy completed.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

    For more information about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

## Delete the resources you created {#clear-out}

To reduce the consumption of resources you do not need, delete them:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the {{ mmy-name }} cluster](../../../managed-mysql/operations/cluster-delete.md).
    1. [Delete the stopped transfer](../../../data-transfer/operations/transfer.md#delete).
    1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}


For a real example of {{ MY }} database migration using {{ data-transfer-name }}, see [Syncing data from using {{ data-transfer-full-name }}](../../../tutorials/dataplatform/sync-mysql.md).

