# Transferring data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster](../../data-transfer/operations/prepare.md#source-ch).
1. Prepare the infrastructure:

   {% list tabs %}

   * Manually

      1. [Prepare the target cluster](../../data-transfer/operations/prepare.md#target-ch).

      1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

         * **Database type**: `ClickHouse`.
         * **Endpoint parameters** → **Connection settings**: `Custom installation`.

            Specify the parameters for connecting to the source cluster.

      1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

         * **Database type**: `ClickHouse`.
         * **Endpoint parameters** → **Connection settings**: `MDB cluster`.

            Select a target cluster from the list and specify the cluster connection settings.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy }}_ type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) it.

   * Using {{ TF }}

      1. If you don't have {{ TF }}, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
      1. Download the configuration file [data-transfer-ch-mch.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-ch-mch.tf) to the same working directory.

         This file describes:

         * [Network](../../vpc/concepts/network.md#network).
         * [Subnet](../../vpc/concepts/network.md#subnet).
         * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a cluster.
         * {{ CH }} source.
         * {{ mch-name }} target cluster.
         * Source endpoint.
         * Target endpoint.
         * Transfer.

      1. In the `data-transfer-ch-mch.tf` file, specify:

         * [Source endpoint parameters](../../data-transfer/operations/endpoint/source/clickhouse.md#on-premise).
            * `source_user` and `source_pwd`: The username and password to access the source.
            * `source_db_name`: Database name.
            * `source_host`: The FQDN or IP address of the {{ CH }} server.
            * `source_http_port` and `source_native_port`: The HTTP and {{ CH }} native interface connection ports.

         * Target cluster parameters also used as [target endpoint parameters](../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

            * `target_clickhouse_version`: {{ CH }} version.
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

1. Wait for the transfer status to change to {{ dt-status-finished }}.

   For more information about transfer statuses, see [Transfer lifecycle](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Delete the resources you created:

   {% list tabs %}

   * Manually created resources

      * [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
      * [Delete the completed transfer](../../data-transfer/operations/transfer.md#delete-transfer).
      * [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for the source and target.

   * Resources created using {{ TF }}

      1. In the terminal window, change to the directory containing the infrastructure plan.
      1. Delete the `data-transfer-ch-mch.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Confirm the update of resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `data-transfer-ch-mch.tf` configuration file will be deleted.

   {% endlist %}
