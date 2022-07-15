# Transferring data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster database](../../data-transfer/operations/prepare.md#source-my).
1. [Prepare the target cluster database](../../data-transfer/operations/prepare.md#target-my).
1. Set up the endpoints and transfer:

   {% list tabs %}

   * Manually

      1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

         * **Database type**: `{{ MY }}`.
         * **Connection settings**: `MDB cluster`.

            Specify the source cluster ID.

      1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

         * **Database type**: `{{ MY }}`.
         * **Connection settings**: `Custom installation`.

            Specify the target cluster connection settings.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy-repl }}_ type that will use the created endpoints.

      1. [Activate](../../data-transfer/operations/transfer.md#activate) it.

   * Using {{ TF }}

      1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
      1. Download the transfer and endpoint configuration file called [data-transfer-mmy-mysql.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mmy-mysql.tf) to the same working directory.

      1. Specify the following in the configuration file:

         * [Source endpoint parameters](../../data-transfer/operations/endpoint/source/mysql.md#managed-service).
         * [Target endpoint parameters](../../data-transfer/operations/endpoint/target/mysql.md#on-premise).

      1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
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

   {% note warning %}

   Avoid any changes to the data schema in the source and target clusters during the transfer operation. For more information, see [{#T}](../../data-transfer/operations/db-actions.md).

   {% endnote %}

1. Wait for the transfer to change to the **Incremented** status.
1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.
1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery, [s]** metric to decrease to zero. This means that all changes that occurred in the source cluster after data was copied are transferred to the target cluster.
1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate-transfer) the transfer and wait its status to change to **Stopped**.

   To learn more about the transfer lifecycle, see the [{{ data-transfer-full-name }} documentation](../../data-transfer/concepts/transfer-lifecycle.md).

1. Delete the endpoints and the transfer you created:

   {% list tabs %}

   * Manually

      If you created your endpoints and transfer manually:

      1. [Delete](../../data-transfer/operations/transfer.md#delete-transfer) the stopped transfer.
      1. [Delete endpoints for the source and target](../../data-transfer/operations/endpoint/index.md#delete).

   * Using {{ TF }}

      If you used {{ TF }} to create your endpoints and transfer:

      1. In the command line, go to the folder with the current {{ TF }} configuration file with an infrastructure plan.
      1. Delete the `data-transfer-mmy-mysql.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the update of resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `data-transfer-mmy-mysql.tf` configuration file will be deleted.

   {% endlist %}
