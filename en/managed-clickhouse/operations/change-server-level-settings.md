# Changing {{ CH }} settings at the server level

You can specify [{{ CH }} settings at the server level](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings) to configure the way the databases or individual tables work in a {{ mch-name }} cluster. You can specify settings in several ways:

  * Using the [{{ yandex-cloud }} interfaces](#yandex-cloud-interfaces). This way you can specify only the {{ CH }} settings available in {{ yandex-cloud }}.
  * Using [SQL queries](#sql-queries). This way you can specify settings for MergeTree tables. You can:

    * Specify the settings when [creating a table](#set-settings-for-new-table).
    * [Specify the settings](#change-settings-of-existing-table) of an existing table.
    * [Restore the default settings](#reset-table-settings) of an existing table.

## Specifying {{ CH }} settings using the {{ yandex-cloud }} interfaces {#yandex-cloud-interfaces}

Changing some [server settings](../concepts/settings-list.md#server-level-settings) will restart {{ CH }} servers on the cluster hosts.

{% note info %}

You cannot directly update the [Max server memory usage]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max_server_memory_usage) value. {{ mch-name }} sets this value automatically depending on the amount of RAM available to {{ CH }} hosts. To edit this setting, you first need to [change the {{ CH }} host class](#change-resource-preset). For more information, see [Memory management](../concepts/memory-management.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   To configure {{ CH }}:

   1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
   1. Specify the [{{ CH }}](../concepts/settings-list.md#server-level-settings) settings.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To configure {{ CH }}:

   1. View the full list of settings specified for the cluster:

      ```bash
      {{ yc-mdb-ch }} cluster get <cluster_name_or_ID> --full
      ```

   1. View the description of the CLI command to update the cluster configuration:

      ```bash
      {{ yc-mdb-ch }} cluster update-config --help
      ```

   1. Set the required parameter values:

      ```bash
      {{ yc-mdb-ch }} cluster update-config <cluster_name_or_ID> \
         --set <parameter_1_name>=<value_1>,...
      ```

- {{ TF }} {#tf}

   To configure {{ CH }}:

   1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

   1. In the {{ mch-name }} cluster description, under `clickhouse.config`, change the values of the following parameters:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
        ...
        clickhouse {
          ...

          config {
            # General DBMS settings
            ...

            merge_tree {
              # MergeTree engine settings
              ...
            }

            kafka {
              # General settings to get data from Apache Kafka
              ...
            }

            kafka_topic {
              # Settings for an individual Apache Kafka topic
              ...
            }

            rabbit_mq {
              # Settings for getting data from {{ RMQ }}
              username = "<username>"
              password = "<password>"
            }

            compression {
              # Data compression settings
              method              = "<compression_method>"
              min_part_size       = <data_part_size>
              min_part_size_ratio = <size_ratio>
            }

            graphite_rollup {
              # GraphiteMergeTree engine settings for thinning, aggregating, and averaging (rollup) Graphite data.
              ...
            }
          }
          ...
        }
        ...
      }
      ```

      Where:
      * `method`: Compression method, `LZ4` or `ZSTD`.
      * `min_part_size`: Minimum size of a table data part, bytes.
      * `min_part_size_ratio`: Smallest table data part to the full table size ratio.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
         --data '{
                    "updateMask": "configSpec.clickhouse.config.<setting_1>,...,configSpec.clickhouse.config.<setting_N>",
                    "configSpec": {
                       "clickhouse": {
                          "config": {
                             "<setting_1>": "<value_1>",
                             "<setting_2>": "<value_2>",
                             ...
                             "<setting_N>": "<value_N>"
                          }
                       }
                    }
                 }'
      ```

      Where:

      * `updateMask`: List of parameters to update as a single string, separated by commas.
      * `configSpec.clickhouse.config`: {{ CH }} server-level settings. For the list of possible parameters and their values, see the [method description](../api-ref/Cluster/update.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest).

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
   1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                   "paths": [
                      "configSpec.clickhouse.config.<setting_1>",
                      "configSpec.clickhouse.config.<setting_2>",
                      ...
                      "configSpec.clickhouse.config.<setting_N>"
                   ]
                },
                "config_spec": {
                   "clickhouse": {
                      "config": {
                         "<setting_1>": "<value_1>",
                         "<setting_2>": "<value_2>",
                         ...
                         "<setting_N>": "<value_N>"
                      }
                   }
                }
             }' \
         {{ api-host-mdb }}:{{ port-https }} \
         yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.
      * `config_spec.clickhouse.config`: {{ CH }} server-level settings. For the list of possible parameters and their values, see the [method description](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest).

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Checking MergeTree table settings {#check-current-settings}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. To view all table-level settings, run the following query:

         ```sql
         SHOW CREATE TABLE <table_name>;
         ```

         {% note warning %}

         The `SHOW CREATE TABLE` output only includes settings overridden by the user. If a user-defined value matches the default value, this setting is also displayed in the output.

         {% endnote %}

   {% endlist %}

## Specifying settings for MergeTree tables using SQL queries {#sql-queries}

### Changing settings when creating a MergeTree table {#set-settings-for-new-table}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. Create a table. To specify its settings, list them in the `SETTINGS` parameter, separated by commas:

         ```sql
         CREATE TABLE <table_name>
            (
            <table_column_description>
            )
            ENGINE = MergeTree
            PRIMARY KEY (<column_or_group_of_columns>)
            SETTINGS
            <setting_name> = <setting_value>,
            <setting_name> = <setting_value>;
         ```

         Example query for the [merge_with_ttl_timeout](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#merge_with_ttl_timeout) and [merge_with_recompression_ttl_timeout](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout) settings:

         ```sql
         CREATE TABLE <table_name>
            (
            user_id UInt32,
            message String,
            )
            ENGINE = MergeTree
            PRIMARY KEY (user_id)
            SETTINGS merge_with_ttl_timeout = 15000,
            merge_with_recompression_ttl_timeout = 15000;
         ```

      For more information about creating MergeTree tables, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-creating-a-table).

   {% endlist %}

### Changing the settings of an existing MergeTree table {#change-settings-of-existing-table}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. To change the settings for an existing table, run the following query:

         ```sql
         ALTER TABLE <table_name> MODIFY SETTING <setting_name> = <new_setting_value>;
         ```
         You can change multiple settings in a single query. To do this, list the `<setting_name> = <new_setting_value>` pairs separated by commas.

   {% endlist %}

### Restoring the default settings of a MergeTree table {#reset-table-settings}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. To restore a default setting value of an existing table, run the following query:

         ```sql
         ALTER TABLE <table_name> RESET SETTING <setting_name>;
         ```
         You can restore multiple default settings in a single query. To do this, list the names of the settings separated by commas.

   {% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
