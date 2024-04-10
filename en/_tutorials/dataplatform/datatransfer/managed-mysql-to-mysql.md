# Transferring data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster database](../../../data-transfer/operations/prepare.md#source-my).
1. [Prepare the target cluster database](../../../data-transfer/operations/prepare.md#target-my).
1. Set up the endpoints and transfer:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create):

         * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MYSQL }}`
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`

            Specify the source cluster ID.

      1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create):

         * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MYSQL }}`
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.on_premise.title }}`

            Specify the target cluster connection settings.

      1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy-repl }}_ type that will use the created endpoints.

      1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).

   - {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the transfer and the [data-transfer-mmy-mysql.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-cloud-mysql-to-on-premise/blob/main/data-transfer-mmy-mysql.tf) endpoint configuration file to the same working directory.

      1. Specify the following in the configuration file:

         * [Source endpoint parameters](../../../data-transfer/operations/endpoint/source/mysql.md#managed-service).
         * [Target endpoint parameters](../../../data-transfer/operations/endpoint/target/mysql.md#on-premise).

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

   {% note warning %}

   Avoid any changes to the data schema in the source and target clusters during the transfer operation. For more information, see [{#T}](../../../data-transfer/operations/db-actions.md).

   {% endnote %}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to "read-only" mode and transfer the load to the target cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to decrease to zero. This means that all changes that occurred in the source cluster after data was copied are transferred to the target cluster.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate-transfer) the transfer and wait for its status to change to {{ dt-status-stopped }}.

   For more information about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Delete the endpoints and the transfer you created:

   {% list tabs group=instructions %}

   - Manually {#manual}

      If you created your endpoints and transfer manually:

      1. [Delete the stopped transfer](../../../data-transfer/operations/transfer.md#delete).
      1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).

   - {{ TF }} {#tf}

      If you used {{ TF }} to create your endpoints and transfer:

      1. In the command line, go to the folder that houses the current {{ TF }} configuration file with an infrastructure plan.
      1. Delete the `data-transfer-mmy-mysql.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Confirm updating the resources.

         {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `data-transfer-mmy-mysql.tf` configuration file will be deleted.

   {% endlist %}
