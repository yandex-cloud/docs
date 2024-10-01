{% list tabs group=instructions %}

- Management console {#console}

   To configure {{ CH }}:

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
   1. Specify the [{{ CH }} settings](../../../managed-clickhouse/concepts/settings-list.md#server-level-settings).
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

   {% include [cli-install](../../cli-install.md) %}

   {% include [default-catalogue](../../default-catalogue.md) %}

   To configure {{ CH }}:

   1. View the full list of settings specified for the cluster:

      ```bash
      {{ yc-mdb-ch }} cluster get <cluster_name_or_ID> --full
      ```

   1. View a description of the update cluster configuration CLI command:

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

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](../../../managed-clickhouse/operations/cluster-create.md).

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

      {% include [terraform-validate](../terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](terraform/timeouts.md) %}

- API {#api}

   To configure {{ CH }}, use the [update](../../../managed-clickhouse/api-ref/Cluster/update.md) REST API method for the [Cluster](../../../managed-clickhouse/api-ref/Cluster/index.md) resource or the [ClusterService/Update](../../../managed-clickhouse/api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).
   * Required values in the `configSpec.clickhouse.config` parameter.
   * List of settings to update, in the `updateMask` parameter.

   {% include [Note API updateMask](../../note-api-updatemask.md) %}

{% endlist %}
