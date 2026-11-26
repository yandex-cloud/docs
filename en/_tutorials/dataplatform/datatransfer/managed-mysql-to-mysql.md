# Migrating data via {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the database on the source cluster](../../../data-transfer/operations/prepare.md#source-my).
1. [Prepare the database on the target cluster](../../../data-transfer/operations/prepare.md#target-my).
1. Create endpoints and set up a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
            * Name the endpoint.
            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.
                * **Managed DB cluster**: Select a source cluster from the list.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the database name in the target cluster.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the database.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: Enter the user password.

        1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
            * Name the endpoint.
            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.title }}**:

                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.connection.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.on_premise.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.host.title }}**: Specify the IP address or FQDN of your target host.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.port.title }}**: Specify the port number for connection to the target cluster.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the database name for your on-premise installation.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the database.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: Enter the user password.

        1. [Create](../../../data-transfer/operations/transfer.md#create) a _{{ dt-type-copy-repl }}_-type transfer and configure it to use the previously created endpoints.

        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [data-transfer-mmy-mysql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-cloud-mysql-to-on-premise/blob/main/data-transfer-mmy-mysql.tf) file, which contains the transfer and endpoint configuration, to your current working directory.

        1. In the configuration file, specify the following:

            * [Source endpoint settings](../../../data-transfer/operations/endpoint/source/mysql.md#managed-service).
            * [Target endpoint settings](../../../data-transfer/operations/endpoint/target/mysql.md#on-premise).

        1. Validate your {{ TF }} configuration using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

            Once created, the transfer becomes active automatically.

    {% endlist %}

    {% note warning %}

    Do not make any schema changes in the source or target cluster during the transfer. For details, see [{#T}](../../../data-transfer/operations/db-actions.md).

    {% endnote %}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to "read-only" mode and transfer the workload to the target cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to drop to zero. This means that all changes made in the source cluster after the initial data copy have been transferred to the target cluster.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

    For more information about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

