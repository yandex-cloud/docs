# Transferring data using {{ data-transfer-full-name }} {#data-transfer}

1. [Set up the source cluster database](../../../data-transfer/operations/prepare.md#source-my).
1. [Set up the target cluster database](../../../data-transfer/operations/prepare.md#target-my).
1. Create endpoints and a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

                Specify the source cluster ID.

        1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create):

            * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MySQL`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.on_premise.title }}`.
                
                Configure the target cluster connection settings.

        1. [Create](../../../data-transfer/operations/transfer.md#create) a _{{ dt-type-copy-repl }}_-type transfer configured to use the new endpoints.

        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [data-transfer-mmy-mysql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-cloud-mysql-to-on-premise/blob/main/data-transfer-mmy-mysql.tf) file with the transfer and endpoint configuration file to the same working directory.

        1. Specify the following in the configuration file:

            * [Source endpoint parameters](../../../data-transfer/operations/endpoint/source/mysql.md#managed-service).
            * [Target endpoint parameters](../../../data-transfer/operations/endpoint/target/mysql.md#on-premise).

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

    {% note warning %}

    Avoid changing the data schema in either the source or target cluster while the transfer is in progress. For more information, see [{#T}](../../../data-transfer/operations/db-actions.md).

    {% endnote %}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to "read-only" mode and move the workload to the target cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait until the **Maximum data transfer delay** value drops to zero. This indicates that the target cluster now contains all changes made in the source cluster after the data copy completed.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate-transfer) the transfer and wait for its status to change to {{ dt-status-stopped }}.

    For more information about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. To reduce the consumption of resources you do not need, delete them:

    {% list tabs group=instructions %}

    - Manually {#manual}

      1. [Ensure the transfer is stopped, then delete it](../../../data-transfer/operations/transfer.md#delete).
      1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).

    - {{ TF }} {#tf}

      {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
