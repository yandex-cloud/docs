# {{ kafka-ui }} for {{ KF }}

To work with {{ mkf-name }} clusters, you can use {{ kafka-ui }}. It will help you track data streams, troubleshoot issues, manage [brokers](../concepts/brokers.md), your cluster, [producers and consumers](../concepts/producers-consumers.md). To learn more about its features, see [{#T}](../concepts/kafka-ui.md).

{% include [roles-for-kafka-ui](../../_includes/mdb/mkf/roles-for-kafka-ui.md) %}

## Enabling the web UI {#enable-kafka-ui}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Enable **{{ ui-key.yacloud.kafka.field_kafka-ui }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Go to the **{{ ui-key.yacloud.kafka.field_kafka-ui }}** page. 

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-kf }} cluster update --help
     ```
  1. Enable the {{ KF }} web UI on your cluster using `--kafka-ui-enabled`:

     ```bash
     {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
       --kafka-ui-enabled=true
      ```
  To find out the cluster name or ID, [get the list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.
  
     Learn how to create this file in [Creating a cluster](cluster-create.md).
  
  1. To enable the {{ KF }} web UI, add the `config.kafka_ui` section to the cluster description. In this section, provide `enabled` set to `true`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          config {
            ...
            kafka_ui {
              enabled = true
            }
          }
        }
        ```
  1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-mkf }}).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.kafkaUiConfig.enabled",
                      "configSpec": {
                        "kafkaUiConfig": {
                          "enabled": true
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated string of settings you want to update. Specify `configSpec.kafkaUiConfig.enabled` to update the setting for enabling {{ kafka-ui }}.
        * `configSpec.kafkaUiConfig.enabled`: Set to `true` to enable {{ kafka-ui }}.

       You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#responses) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "config_spec.kafka_ui_config.enabled"
                    ]
                  },
                  "config_spec": {
                    "kafka_ui_config": {
                      "enabled": true
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`). Specify `config_spec.kafka_ui_config.enabled` to update the setting for enabling {{ kafka-ui }}.
        * `config_spec.kafka_ui_config.enabled`: Set to `true` to enable {{ kafka-ui }}.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Getting a link to the web UI {#get-link}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the cluster page.
  1. Go to the **{{ ui-key.yacloud.kafka.field_kafka-ui }}** page. 

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  ```
  {{ yc-mdb-kf }} cluster get <cluster_name_or_ID>
  ```

  You can find the link to {{ kafka-ui }} in the `kafka_ui.url` parameter.
  
  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:
  
     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Call the [Cluster.get](../api-ref/Cluster/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:
  
     ```bash
     curl \
         --request GET \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>'
     ```
  
     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).
  
  1. Check the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.kafka.v1.Cluster) to make sure your request was successful.

     You can find the link to the {{ KF }} web UI in the `config.kafkaUiConfig.url` parameter.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Call the [ClusterService/Get](../api-ref/grpc/Cluster/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                  "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:443 \
          yandex.cloud.mdb.kafka.v1.ClusterService.Get
      ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.kafka.v1.Cluster) to make sure your request was successful.

     You can find the link to {{ kafka-ui }} in the `config.kafka_ui_config.url` parameter.

{% endlist %}