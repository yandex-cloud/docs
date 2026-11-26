# Migrating data using {{ data-transfer-full-name }} {#data-transfer}


### Getting started {#before-you-begin-dt}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


#### Required paid resources {#paid-resources-dt}

* {{ mpg-name }} cluster: computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../../managed-postgresql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Each transfer: use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


### Transfer the data {#transfer-data}

1. [Prepare the source cluster](../../../data-transfer/operations/prepare.md#source-pg).
1. Set up the infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. Create a [{{ mpg-name }} target cluster](../../../managed-postgresql/operations/cluster-create.md) with your preferred configuration. Enable the same [{{ PG }} extensions](../../../managed-postgresql/operations/extensions/cluster-extensions.md) as in the source cluster.
        1. [Prepare the target cluster](../../../data-transfer/operations/prepare.md#target-pg).
        1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create) with the following settings:

             * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
             * Name the endpoint.
             * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `PostgreSQL`.
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.title }}**:

                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.connection.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.on_premise.title }}`.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.host.title }}**: Specify the IP address or FQDN of the source cluster's master host.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}**: Specify the port number for connection to the source cluster.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the database name.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: Specify the database user name.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: Enter the user password.

        1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create) with the following settings:

             * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
             * Name the endpoint.
             * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ PG }}`.
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.title }}**:

                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.connection.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
                 * **Managed DB cluster**: Select the target cluster from the list.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the database name.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: Specify the database user name.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: Enter the user password.

        1. [Create](../../../data-transfer/operations/transfer.md#create) a _{{ dt-type-copy-repl }}_-type transfer and configure it to use the previously created endpoints.
        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).

            {% note warning %}

            Do not make any schema changes in the source or target cluster during the transfer. For details, see [{#T}](../../../data-transfer/operations/db-actions.md).

            {% endnote %}

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [data-transfer-pgsql-mpg.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-postgresql-to-cloud/blob/main/data-transfer-pgsql-mpg.tf) configuration file to your current working directory.

            This file describes:

            * [Network](../../../vpc/concepts/network.md#network).
            * [Subnet](../../../vpc/concepts/network.md#subnet).
            * [Security group](../../../vpc/concepts/security-groups.md) and the rule allowing cluster connections.
            * {{ mpg-name }} target cluster.
            * Source endpoint.
            * Target endpoint.
            * Transfer.

        1. In `data-transfer-pgsql-mpg.tf`, specify the following:

            * [Source endpoint settings](../../../data-transfer/operations/endpoint/source/postgresql.md#on-premise).
            * `pg-extensions`: List of [{{ PG }} extensions](../../../managed-postgresql/operations/extensions/cluster-extensions.md) in the source cluster.
            * [Target endpoint settings](../../../data-transfer/operations/endpoint/target/postgresql.md#managed-service) inherited from the target cluster configuration:

                * `target_pgsql_version`: {{ PG }} version. This version must be the same or higher than the version in the source cluster.
                * `target_user` and `target_password`: Database owner username and password.

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

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Stop all writes to the source cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to drop to zero. This means that all changes made in the source cluster after the initial data copy have been transferred to the target cluster.
1. Transfer the workload over to the target cluster.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

    For more information about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).


### Delete the resources you created {#clear-out-dt}

To reduce resource usage, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually created resources {#manual}

    1. Once the transfer is stopped, [delete it](../../../data-transfer/operations/transfer.md#delete).
    1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
    1. [Delete the {{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-delete.md).

- Resources created with {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
