# Transferring data using {{ data-transfer-full-name }} {#data-transfer}

To transfer a database from {{ MY }} to {{ mmy-name }}:

1. [Start a data transfer](#start-transfer).
1. [Complete the data transfer](#finish-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Start a data transfer {#start-transfer}

1. [Prepare the source cluster](../../data-transfer/operations/prepare.md#source-my).
1. Prepare the infrastructure and start the data transfer:

   {% list tabs %}

   * Manually

      1. Create a [{{ mmy-name }} target cluster](../../managed-mysql/operations/cluster-create.md) with any suitable configuration. In this case:

         * The {{ MY }} version must be the same or higher than the version in the source cluster.

            Transferring data with an increase in the {{ MY }} major version is possible, but not guaranteed. For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

            You [cannot](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html) perform migration while downgrading {{ MY }} version.

         * [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

      1. [Prepare the target cluster](../../data-transfer/operations/prepare.md#target-my).

      1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

         * **Data base type**: `MySQL`.
         * **Endpoint parameters** → **Connection settings**: `Custom installation`.

            Specify the parameters for connecting to the source cluster.

      1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

         * **Data base type**: `MySQL`.
         * **Endpoint parameters** → **Connection settings**: `MDB cluster`.

            Select a target cluster from the list and specify its connection settings.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with a _{{ dt-type-copy-repl }}_ type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

         {% note warning %}

         Abstain from making any changes to the data schema in the source and target clusters when the data transfer is running. For more information, see [{#T}](../../data-transfer/operations/db-actions.md).

         {% endnote %}

   * Using {{ TF }}

      1. [Prepare the source cluster](../../data-transfer/operations/prepare.md#source-my).
      1. If you do not have {{ TF }} yet, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
      1. Download the configuration file [data-transfer-mysql-mmy.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-migration-mysql-mmy/data-transfer-mysql-mmy.tf) to the same working directory.

         This file describes:

         * [Network](../../vpc/concepts/network.md#network).
         * [Subnet](../../vpc/concepts/network.md#subnet).
         * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a cluster.
         * {{ mmy-name }} target cluster.
         * Source endpoint.
         * Target endpoint.
         * Transfer.

      1. Specify in the file `data-transfer-mysql-mmy.tf`:

         * [Source endpoint parameters](../../data-transfer/operations/endpoint/source/mysql.md#on-premise).
         * Target cluster parameters also used as [target endpoint parameters](../../data-transfer/operations/endpoint/target/mysql.md#managed-service):

            * `target_mysql_version`: {{ MY }} version must be the same or higher than the version in the source cluster.
            * `target_sql_mode`: [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.
            * `target_db_name`: Database name.
            * `target_user` and `target_password`: Database owner username and password.

      1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

         Once created, your transfer will be activated automatically.

   {% endlist %}

## Complete the data transfer {#finish-transfer}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.
1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery** metric to decrease to zero. This means that all changes that occurred in the source cluster after data was copied are transferred to the target cluster.
1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

   For more information about transfer statuses, see [Transfer lifecycle](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs %}

* Manually

   * [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).
   * [Delete the stopped transfer](../../data-transfer/operations/transfer.md#delete).
   * [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both source and target.

* Using {{ TF }}

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-mysql-mmy.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the configuration file `data-transfer-mysql-mmy.tf` will be deleted.

{% endlist %}


For a real example of {{ MY }} database migration using {{ data-transfer-name }}, see [Syncing MySQL data using {{ data-transfer-full-name }}](../../tutorials/dataplatform/sync-mysql.md).

