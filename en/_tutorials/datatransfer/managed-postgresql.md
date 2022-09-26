# Transferring data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster](../../data-transfer/operations/prepare.md#source-pg).
1. Prepare the infrastructure:

   {% list tabs %}

   * Manually

      1. Create a [{{ mpg-name }} target cluster](../../managed-postgresql/operations/cluster-create.md) with any suitable configuration. In this case:

         * The {{ PG }} version must be the same or higher than the version in the source cluster. Migration with a {{ PG }} version downgrade is impossible.
         * When creating a cluster, specify the same database name as in the source cluster.
         * Enable the same [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) as in the source cluster.
      1. [Prepare the target cluster](../../data-transfer/operations/prepare.md#target-pg).
      1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

         * **Database type**: `{{ PG }}`.
         * **Endpoint parameters** → **Connection settings**: `Custom installation`.

         Specify the parameters for connecting to the source cluster.

      1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

         * **Database type**: `{{ PG }}`.
         * **Endpoint parameters** → **Connection settings**: `MDB cluster`.

         Specify the ID of the target cluster.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy-repl }}_ type that will use the created endpoints.
      1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate).

         {% note warning %}

         Abstain from making any changes to the data schema in the source and target clusters when the data transfer is running. For more information, see [{#T}](../../data-transfer/operations/db-actions.md).

         {% endnote %}

   * Using {{ TF }}

      1. If you don't have {{ TF }}, {% if audience != "internal" %}[install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}install and configure it{% endif %}.
      1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and {% if audience != "internal" %}[specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}specify the parameter values{% endif %}.
      1. Download the configuration file [data-transfer-pgsql-mpg.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-migration-pgsql-mpg/data-transfer-pgsql-mpg.tf) to the same working directory.

         This file describes:

         * {% if audience != "internal" %}[Network](../../vpc/concepts/network.md#network){% else %}Network{% endif %}.
         * {% if audience != "internal" %}[Subnet](../../vpc/concepts/network.md#subnet){% else %}Subnet{% endif %}.
         * {% if audience != "internal" %}[Security groups](../../vpc/concepts/security-groups.md){% else %}Security groups{% endif %} and the rule required to connect to a cluster.
         * {{ mpg-name }} target cluster.
         * Source endpoint.
         * Target endpoint.
         * Transfer.

      1. Specify the following in `data-transfer-pgsql-mpg.tf`:

         * [Source endpoint parameters](../../data-transfer/operations/endpoint/source/postgresql.md#on-premise).
         * `pg-extensions`: List of [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) in the source cluster.
         * Target cluster parameters also used as [target endpoint parameters](../../data-transfer/operations/endpoint/target/postgresql.md#managed-service):

            * `target_mysql_version`: {{ PG }} version, must be the same as or higher than the version in the source cluster.
            * `target_user` and `target_password`: Username and password of the database owner.

      1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

         Once created, a transfer is activated automatically.

   {% endlist %}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.
1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.
1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

   For more information about transfer statuses, see [Transfer lifecycle](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Delete the resources you created:

   {% list tabs %}

   * Manually created resources

      * [Delete a {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).
      * [Delete the stopped transfer](../../data-transfer/operations/transfer.md#delete-transfer).
      * [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for the source and target.

   * Resources created using {{ TF }}

      1. In the terminal window, change to the directory containing the infrastructure plan.
      1. Delete the configuration file `data-transfer-pgsql-mpg.tf`.
      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the update of resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the configuration file `data-transfer-pgsql-mpg.tf` will be deleted.

   {% endlist %}
