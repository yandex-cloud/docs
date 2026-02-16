# Changing {{ CH }} settings at the server level

You can specify [{{ CH }} settings at the server level](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings) to configure the way databases or individual tables work in a {{ mch-name }} cluster. You can specify settings using several methods:

  * Using the [{{ yandex-cloud }} interfaces](#yandex-cloud-interfaces). This way you can only specify the {{ CH }} settings available in {{ yandex-cloud }}.
  * Using [SQL queries](#sql-queries). This way you can specify settings for MergeTree tables. You can:

    * Specify the settings when [creating a table](#set-settings-for-new-table).
    * [Specify the settings](#change-settings-of-existing-table) of an existing table.
    * [Restore the default settings](#reset-table-settings) of an existing table.

## Specifying {{ CH }} settings using the {{ yandex-cloud }} interfaces {#yandex-cloud-interfaces}

Changing some [server settings](../concepts/settings-list.md#server-level-settings) will restart {{ CH }} servers on the cluster hosts.

{% note info %}

You cannot directly change the [Max server memory usage]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max_server_memory_usage) value. {{ mch-name }} sets this value automatically depending on the amount of RAM available to {{ CH }} hosts. To change this setting, you need to [change the {{ CH }} host class](#change-resource-preset) first. For more information, see [Memory management](../concepts/memory-management.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   To configure {{ CH }}:

   1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
   1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
   1. Specify the [{{ CH }} settings](../concepts/settings-list.md#server-level-settings).
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To configure {{ CH }}:

   1. View the full list of settings for the cluster:

      ```bash
      {{ yc-mdb-ch }} cluster get <cluster_name_or_ID> --full
      ```

   1. View the description of the CLI command for updating the cluster configuration:

      ```bash
      {{ yc-mdb-ch }} cluster update-config --help
      ```

   1. Provide the arguments as needed:

      ```bash
      {{ yc-mdb-ch }} cluster update-config <cluster_name_or_ID> \
         --set <parameter_1_name>=<value_1>,...
      ```

- {{ TF }} {#tf}

   To configure {{ CH }}:

   1. Open the current {{ TF }} configuration file describing your infrastructure.

      For information on how to create such a file, see [Creating a cluster](cluster-create.md).

   1. In the {{ mch-name }} cluster description, under `clickhouse.config`, edit the parameters as follows:

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
              # General settings for getting data from Apache Kafka
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
              # GraphiteMergeTree engine settings for data thinning, aggregation, and rollup in Graphite.
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
      * `min_part_size`: Minimum size of a table data part, in bytes.
      * `min_part_size_ratio`: Ratio of the smallest data part size to the full table size.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

      * `updateMask`: Comma-separated list of settings you want to update.
      * `configSpec.clickhouse.config`: {{ CH }} server-level settings. For the list of possible parameters and their values, see the [method description](../api-ref/Cluster/update.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest).

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
   1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).
      * `config_spec.clickhouse.config`: {{ CH }} server-level settings. For the list of possible parameters and their values, see the [method description](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.clickhouse.v1.UpdateClusterRequest).

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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

         The `SHOW CREATE TABLE` output only includes settings overridden by the user. If a user-defined value matches the default value, this setting is also output.

         {% endnote %}

   {% endlist %}

## Specifying settings for MergeTree tables using SQL queries {#sql-queries}

### Changing settings when creating a MergeTree table {#set-settings-for-new-table}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. Create a table. To configure it, list its settings under `SETTINGS`, separated by commas:

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

         Here is an example of the query for the [merge_with_ttl_timeout](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#merge_with_ttl_timeout) and [merge_with_recompression_ttl_timeout](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout) settings:

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

      For more information about creating MergeTree tables, see [this {{ CH }} guide](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-creating-a-table).

   {% endlist %}

### Changing settings of an existing MergeTree table {#change-settings-of-existing-table}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. To change the settings for an existing table, run the following query:

         ```sql
         ALTER TABLE <table_name> MODIFY SETTING <setting_name> = <new_setting_value>;
         ```
         You can change multiple settings with a single query. To do this, list `<setting_name> = <new_setting_value>` pairs separated by commas.

   {% endlist %}

### Resetting a MergeTree table setting to default {#reset-table-settings}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. To reset a setting of an existing table to its default, run this query:

         ```sql
         ALTER TABLE <table_name> RESET SETTING <setting_name>;
         ```
         You can reset multiple settings to default with a single query. To do this, list the names of the settings separated by commas.

   {% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
