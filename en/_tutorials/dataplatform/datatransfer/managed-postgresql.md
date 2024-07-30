# Migrating data using {{ data-transfer-full-name }} {#data-transfer}


1. [Prepare the source cluster](../../../data-transfer/operations/prepare.md#source-pg).
1. Prepare the infrastructure:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. Create a [{{ mpg-name }} target cluster](../../../managed-postgresql/operations/cluster-create.md) in any suitable configuration. Note that:

         * The {{ PG }} version must be the same or higher than the version in the source cluster. You cannot perform migration while downgrading {{ PG }} version.
         * When creating a cluster, specify the same database name as in the source cluster.
         * Enable the same [{{ PG }} extensions](../../../managed-postgresql/operations/extensions/cluster-extensions.md) as in the source cluster.
      1. [Prepare the target cluster](../../../data-transfer/operations/prepare.md#target-pg).
      1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

         * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `PostgreSQL`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.on_premise.title }}`

         Specify the parameters for connecting to the source cluster.

      1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

         * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ PG }}`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.

         Specify the ID of the target cluster.

      1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy-repl }}_ type that will use the created endpoints.
      1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).

         {% note warning %}

         Abstain from making any changes to the data schema in the source and target clusters when the data transfer is running. For more information, see [{#T}](../../../data-transfer/operations/db-actions.md).

         {% endnote %}

   - {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the [data-transfer-pgsql-mpg.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-postgresql-to-cloud/blob/main/data-transfer-pgsql-mpg.tf) configuration file to the same working directory.

         This file describes:

         * [Network](../../../vpc/concepts/network.md#network).
         * [Subnet](../../../vpc/concepts/network.md#subnet).
         * [Security group](../../../vpc/concepts/security-groups.md) and the rule required to connect to a cluster.
         * {{ mpg-name }} target cluster.
         * Source endpoint.
         * Target endpoint.
         * Transfer.

      1. Specify the following in `data-transfer-pgsql-mpg.tf`:

         * [Source endpoint parameters](../../../data-transfer/operations/endpoint/source/postgresql.md#on-premise).
         * `pg-extensions`: List of [{{ PG }} extensions](../../../managed-postgresql/operations/extensions/cluster-extensions.md) in the source cluster.
         * Target cluster parameters also used as [target endpoint parameters](../../../data-transfer/operations/endpoint/target/postgresql.md#managed-service):

            * `target_mysql_version`: {{ PG }} version, must be the same as or higher than the version in the source cluster.
            * `target_user` and `target_password`: Database owner username and password.

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

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to read-only.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

   For more information about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Transfer the load to the target cluster.
1. Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

   {% list tabs group=instructions %}

   - Manually created resources {#manual}

      * [Delete the {{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-delete.md).
      * [Delete the stopped transfer](../../../data-transfer/operations/transfer.md#delete).
      * [Delete endpoints](../../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.

   - Resources created with {{ TF }} {#tf}

      1. In the terminal window, go to the directory containing the infrastructure plan.
      1. Delete the `data-transfer-pgsql-mpg.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Confirm updating the resources.

         {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `data-transfer-pgsql-mpg.tf` configuration file will be deleted.

   {% endlist %}
