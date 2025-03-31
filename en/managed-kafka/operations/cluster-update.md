---
title: How to change {{ KF }} cluster settings in {{ mkf-full-name }}
description: Follow this guide to change {{ KF }} cluster settings.
---

# Updating {{ KF }} cluster settings


After creating a {{ mkf-name }} cluster, you can:

* [Change the cluster name and description](#change-name-and-description)
* [Change the class and number of broker hosts](#change-brokers)
* [Change the {{ ZK }} host class](#change-zookeeper)
* [Change security group and public access settings](#change-sg-set)
* [Change additional cluster settings](#change-additional-settings)
* [Change {{ KF }} settings](#change-kafka-settings)
* [Move a cluster to another folder](#move-cluster)

Learn more about other cluster updates:

* [{#T}](cluster-version-update.md).
* [{#T}](storage-space.md).
* [{#T}](host-migration.md).

## Changing the cluster name and description {#change-name-and-description}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, enter a new name and description for the cluster.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the name and description of a cluster:

    1. View the description of the update cluster CLI command:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Specify a new name and description in the cluster update command:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
          --new-name <new_cluster_name> \
          --description <new_cluster_description>
        ```

        To find out the cluster name or ID, [get a list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    {% note alert %}

    Do not change the cluster name using {{ TF }}. This will delete the existing cluster and create a new one.

    {% endnote %}

    To update the cluster description:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](./cluster-create.md).

    1. In the {{ mkf-name }} cluster description, change the `description` parameter value:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          name        = "<cluster_name>"
          description = "<new_cluster_description>"
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }}]({{ tf-provider-mrd }}) provider documentation.

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "name,description",
                      "name": "<cluster_name>",
                      "description": "<new_cluster_description>"
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Specify the relevant parameters:
            * `name`: To change the cluster name.
            * `description`: To change the cluster description.
        * `name`: New cluster name.
        * `description`: New cluster description.

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                      "name",
                      "description"
                    ]
                  },
                  "name": "<cluster_name>",
                  "description": "<new_cluster_description>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Specify the relevant parameters:
            * `name`: To change the cluster name.
            * `description`: To change the cluster description.
        * `name`: New cluster name.
        * `description`: New cluster description.

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing the broker host class and number {#change-brokers}

You can increase the number of [broker hosts](../concepts/brokers.md) if the following conditions are met:

* The cluster uses {{ KF }} 3.5 or lower. Clusters running {{ KF }} 3.6 or higher use the [{{ kraft-name }}](../concepts/kraft.md) protocol; therefore, such clusters always have three {{ KF }} hosts.
* The cluster contains at least two broker hosts in different availability zones.

You cannot have fewer broker hosts. To meet the cluster [fault tolerance conditions](../concepts/index.md#fault-tolerance), you need at least three broker hosts.

When changing the broker host class:

* A single broker host cluster will be unavailable for a few minutes with topic connections terminated.
* In a multiple broker host cluster, hosts will be stopped and updated one at a time. Stopped hosts will be unavailable for a few minutes.

We recommend changing broker host class only when there is no active workload on the cluster.

{% list tabs group=instructions %}

- Management console {#console}

  To change the class and number of hosts:

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Change the required settings:
     * To edit the broker host class, select a new [**{{ ui-key.yacloud.mdb.forms.section_resource }}**](../concepts/instance-types.md).
     * Change **{{ ui-key.yacloud.kafka.label_brokers-per-az }}**.

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the class and number of hosts:

  1. Get information about the cluster:

     ```bash
     {{ yc-mdb-kf }} cluster list
     {{ yc-mdb-kf }} cluster get <cluster_name_or_ID>
     ```

  1. View the description of the CLI command to update the cluster:

     ```bash
     {{ yc-mdb-kf }} cluster update --help
     ```

  1. To increase the number of broker hosts, run this command:

     ```bash
     {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> --brokers-count <number>
     ```

  1. To change the [broker host class](../concepts/instance-types.md), run this command:

     ```bash
     {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> --resource-preset <host_class>
     ```

  To find out the cluster name or ID, [get a list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, change the `brokers_count` parameter to increase the number of broker hosts:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          config {
            brokers_count = <number_of_broker_hosts>
            ...
          }
          ...
        }
        ```

    1. In the {{ mkf-name }} cluster description, edit the value of the `resource_preset_id` parameter under `kafka.resources` to specify a new [broker host class](../concepts/instance-types.md):

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          kafka {
            resources {
              resource_preset_id = "<broker_host_class>"
              ...
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Request a list of available host classes:

        1. Use the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method and run the request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/resourcePresets'
            ```

        1. View the [server response](../api-ref/ResourcePreset/list.md#responses) to make sure the request was successful.

    1. Change the class and number of broker hosts as appropriate:

        1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

            {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
                --data '{
                          "updateMask": "configSpec.kafka.resources.resourcePresetId,configSpec.brokersCount",
                          "configSpec": {
                            "kafka": {
                              "resources": {
                                "resourcePresetId": "<broker_host_class_ID>"
                              }
                            },
                            "brokersCount": "<number_of_broker_hosts>"
                          }
                        }'
            ```

            Where:

            * `updateMask`: List of parameters to update as a single string, separated by commas.

                Specify the relevant parameters:
                * `configSpec.kafka.resources.resourcePresetId`: To change the broker host class.
                * `configSpec.brokersCount`: To change the number of broker hosts.

            You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). The list of available host classes with their IDs came to you earlier.

        1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Request a list of available host classes:

        1. Use the [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) call and run the request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.kafka.v1.ResourcePresetService.List
            ```

        1. View the [server response](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse) to make sure the request was successful.

    1. Change the host class as appropriate:

        1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                          "config_spec.kafka.resources.resource_preset_id",
                          "config_spec.brokers_count"
                        ]
                      },
                      "config_spec": {
                        "kafka": {
                          "resources": {
                            "resource_preset_id": "<broker_host_class_ID>"
                          }
                        },
                        "brokers_count": {
                          "value": "<number_of_broker_hosts>"
                        }
                      }
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.kafka.v1.ClusterService.Update
            ```

            Where:

            * `update_mask`: List of parameters to update as an array of `paths[]` strings.

                Specify the relevant parameters:
                * `config_spec.kafka.resources.resource_preset_id`: To change the broker host class.
                * `config_spec.brokers_count`: To change the number of broker hosts.

            You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). The list of available host classes with their IDs came to you earlier.

        1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing the {{ ZK }} host class {#change-zookeeper}

{% note info %}

The {{ ZK }} host class is used only in clusters with {{ KF }} 3.5 or lower.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Select a new [**{{ ui-key.yacloud.kafka.section_zookeeper-resources }}**](../concepts/instance-types.md).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the class of {{ ZK }} hosts:

  1. Get information about the cluster:

     ```bash
     {{ yc-mdb-kf }} cluster list
     {{ yc-mdb-kf }} cluster get <cluster_name_or_ID>
     ```

  1. View the description of the CLI command to update the cluster:

     ```bash
     {{ yc-mdb-kf }} cluster update --help
     ```

  1. To change the {{ ZK }} [host class](../concepts/instance-types.md), run this command:

     ```bash
     {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
       --zookeeper-resource-preset <host_class>
     ```

  To find out the cluster name or ID, [get a list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, edit the value of the `resource_preset_id` parameter under `zookeeper.resources` to specify a [new {{ ZK }} host class](../concepts/instance-types.md):

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          zookeeper {
            resources {
              resource_preset_id = "<{{ ZK }}_host_class>"
              ...
            }
          }
         }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Request a list of available host classes:

        1. Use the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method and run the request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/resourcePresets'
            ```

        1. View the [server response](../api-ref/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse) to make sure the request was successful.

    1. Change the host class as appropriate:

        1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

            {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
                --data '{
                          "updateMask": "configSpec.zookeeper.resources.resourcePresetId",
                          "configSpec": {
                            "zookeeper": {
                              "resources": {
                                "resourcePresetId": "<{{ ZK }}_host_class_ID>"
                              }
                            }
                          }
                        }'
            ```

            Where:

            * `updateMask`: List of parameters to update as a single string, separated by commas.

                Specify the relevant parameters:
                * `configSpec.zookeeper.resources.resourcePresetId`: To change the {{ ZK }} host class.

            You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). The list of available host classes with their IDs came to you earlier.

        1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Request a list of available host classes:

        1. Use the [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) call and run the request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.kafka.v1.ResourcePresetService.List
            ```

        1. View the [server response](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse) to make sure the request was successful.

    1. Change the host class as appropriate:

        1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                          "config_spec.zookeeper.resources.resource_preset_id"
                        ]
                      },
                      "config_spec": {
                        "zookeeper": {
                          "resources": {
                            "resource_preset_id": "<{{ ZK }}_host_class_ID>"
                          }
                        }
                      }
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.kafka.v1.ClusterService.Update
            ```

            Where:

            * `update_mask`: List of parameters to update as an array of `paths[]` strings.

                Specify the relevant parameters:
                * `config_spec.zookeeper.resources.resource_preset_id`: To change the {{ ZK }} host class.

            You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). The list of available host classes with their IDs came to you earlier.

        1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


## Changing security group and public access settings {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select security groups for cluster network traffic.
  1. Enable or disable public access to a cluster via the **Public access** option.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

  1. View the description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

  1. Specify the security groups and public access settings in the update cluster command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --security-group-ids <list_of_security_groups> \
         --assign-public-ip=<public_access>
      ```

      Where:

      * `--security-group-ids`: List of cluster security group IDs.
      * `--assign-public-ip`: Public access to the cluster, `true` or `false`.

      To find out the cluster name or ID, [get a list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Change the values of the `security_group_ids` and `assign_public_ip` parameters in the cluster description:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          security_group_ids = [ <list_of_security_groups> ]
          ...
          config {
            assign_public_ip = "<public_access>"
            ...
            }
        }
        ```

        Where:
        * `security_group_ids`: List of cluster security group IDs.
        * `assign_public_ip`: Public access to the cluster, `true` or `false`.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "securityGroupIds,configSpec.assignPublicIp",
                      "securityGroupIds": [
                        <list_of_security_group_IDs>
                      ],
                      "configSpec": {
                        "assignPublicIp": "<public_access:_true_or_false>"
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Specify the relevant parameters:
            * `securityGroupIds`: To change the list of security groups.
            * `configSpec.assignPublicIp`: To change the public access setting.
        * `securityGroupIds`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.

            {% note warning %}

            The list of security groups assigned to the cluster will be completely overwritten by the list in the `securityGroupIds` parameter.

            Before executing your request, make sure the list includes all the required security group IDs, including existing ones.

            {% endnote %}

        * `assignPublicIp`: Internet access to the broker hosts, `true` or `false`.

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                      "security_group_ids",
                      "config_spec.assign_public_ip"
                    ]
                  },
                  "security_group_ids": [
                    <list_of_security_group_IDs>
                  ],
                  "config_spec": {
                    "assign_public_ip": "<public_access:_true_or_false>"
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Specify the relevant parameters:
            * `security_group_ids`: To change the list of security groups.
            * `config_spec.assign_public_ip`: To change the public access setting.
        * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.

            {% note warning %}

            The list of security groups assigned to the cluster will be completely overwritten by the list in the `security_group_ids` parameter.

            Before executing your request, make sure the list includes all the required security group IDs, including existing ones.

            {% endnote %}

        * `assign_public_ip`: Internet access to the broker hosts, `true` or `false`.

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

[Restart the cluster](./cluster-stop.md) for the new public access settings to take effect.

You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.


## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Change additional cluster settings:

     {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change additional cluster settings:

    1. View the description of the update cluster CLI command:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Run the following command with the list of settings to update:

        
        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
           --maintenance-window type=<maintenance_type>,`
                               `day=<day_of_week>,`
                               `hour=<hour> \
           --datatransfer-access=<access_to_cluster> \
           --deletion-protection \
           --schema-registry=<data_schema_management>
        ```


    You can change the following settings:

    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}


    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Deletion protection](../../_includes/mdb/deletion-protection-limits-data.md) %}

    * `--schema-registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`.

        {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

    To find out the cluster name or ID, [get a list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

    1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          deletion_protection = <deletion_protection>
        }
        ```

        {% include [Deletion protection](../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. To enable data schema management using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), add the `config.schema_registry` field set to `true` to the cluster description:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          config {
            ...
            schema_registry  = <data_schema_management>
          }
        }
        ```

        {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mkf }}).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        
        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.restApiConfig.emabled,configSpec.schemaRegistry,maintenanceWindow,deletionProtection",
                      "configSpec": {
                        "schemaRegistry": true,
                        "restApiConfig": {
                          "enabled": true
                        }
                      },
                      "maintenanceWindow": {
                        "anytime": {},
                        "weeklyMaintenanceWindow": {
                          "day": "<day_of_week>",
                          "hour": "<hour_UTC>"
                        }
                      },
                      "deletionProtection": <deletion_protection:_true_or_false>
                    }'
        ```


        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Specify the relevant parameters:
            * `configSpec.schemaRegistry`: To enable the settings for data schema management using [{{ mkf-msr }}](../concepts/managed-schema-registry.md).
            * `configSpec.restApiConfig.enabled`: To enable access to sending requests to the {{ KF }} REST API.


            * `maintenanceWindow`: To change the [maintenance window](../concepts/maintenance.md) settings, including for disabled clusters.
            * `deletionProtection`: To enable or disable protection of the cluster, its databases, and users against accidental deletion.
        * `configSpec.schemaRegistry`: Set to `true` to manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md). You will not be able to edit this setting once it is enabled.
        * `configSpec.restApiConfig.enabled`: Set to `true` for access to sending requests to the {{ KF }} REST API. You will not be able to edit this setting once it is enabled.


        * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). Select one of the options:

            * `anytime`: At any time (default).
            * `weeklyMaintenanceWindow`: On schedule:
                * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Hour of day (UTC) in `HH` format, from `1` to `24`.

        * `deletionProtection`: To enable or disable protection of the cluster, its database, and users against accidental deletion.

            {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                      "maintenance_window",
                      "deletion_protection",
                      "config_spec.schema_registry",
                      "config_spec.rest_api_config.enabled"
                    ]
                  },
                  "config_spec": {
                    "schema_registry": true,
                    "rest_api_config": {
                      "enabled": true
                    }
                  },
                  "maintenance_window": {
                    "anytime": {},
                    "weekly_maintenance_window": {
                      "day": "<day_of_week>",
                      "hour": "<hour_UTC>"
                    }
                  },
                  "deletion_protection": <deletion_protection:_true_or_false>
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```


        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Specify the relevant parameters:
            * `config_spec.schema_registry`: To manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md).
            * `config_spec.rest_api_config.enabled`: To enable access to sending requests to the {{ KF }} REST API.


            * `maintenance_window`: To change the [maintenance window](../concepts/maintenance.md) settings, including for disabled clusters.
            * `deletion_protection`: To enable or disable protection of the cluster, its databases, and users against accidental deletion.
        * `schema_registry`: Set to `true` to manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md). You will not be able to edit this setting once it is enabled.
        * `rest_api_config.enabled`: Set to `true` for access to sending requests to the {{ KF }} REST API. You will not be able to edit this setting once it is enabled.


        * `maintenance_window`: [Maintenance](../concepts/maintenance.md) window settings. Select one of these options:

            * `anytime`: Anytime.
            * `weekly_maintenance_window`: On schedule:
                * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Hour of day (UTC) in `HH` format, from `1` to `24`.

        * `deletion_protection`: To enable (`true`) or disable (`false`) protection of the cluster, its databases, and users against accidental deletion.

            {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing {{ KF }} settings {#change-kafka-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_settings-kafka }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.

     For more information, see [{{ KF }} settings](../concepts/settings-list.md).

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update the {{ KF }} settings:

    1. See the description of the CLI command for updating cluster settings:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Change the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) in the cluster update command (the example below does not list all possible parameters):

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
           --compression-type <compression_type> \
           --log-flush-interval-messages <number_of_messages_in_log> \
           --log-flush-interval-ms <maximum_time_to_store_messages>
        ```

        Where:

        * `--log-flush-interval-messages`: Number of messages in the log to trigger flushing to disk.
        * `--log-flush-interval-ms`: Maximum time a message can be stored in memory before flushing to disk.

        To find out the cluster name or ID, [get a list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, modify the values of the parameters in the `kafka.kafka_config` section (the example below does not list all possible [settings](../concepts/settings-list.md#cluster-settings)):

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          config {
            kafka {
              ...
              kafka_config {
                compression_type            = "<compression_type>"
                log_flush_interval_messages = <maximum_number_of_messages_in_memory>
                ...
              }
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.kafka.kafkaConfig_2_8.<setting_1_for_{{ KF }}_2.8_configuration>,...,configSpec.kafka.kafkaConfig_2_8.<setting_N_for_{{ KF }}_2.8_configuration>,configSpec.kafka.kafkaConfig_3.<setting_1_for_{{ KF }}_3.x_configuration>,...,configSpec.kafka.kafkaConfig_3.<setting_N_for_{{ KF }}_3.x_configuration>",
                      "configSpec": {
                        "kafka": {
                          "kafkaConfig_2_8": {
                            "<setting_1_for_{{ KF }}_2.8_configuration>": "<setting_value>",
                            "<setting_2_for_{{ KF }}_2.8_configuration>": "<setting_value>",
                            ...,
                            "<setting_N_for_{{ KF }}_2.8_configuration>": "<setting_value>"
                          },
                          "kafkaConfig_3": {
                            "<setting_1_for_{{ KF }}_3.x_configuration>": "<setting_value>",
                            "<setting_2_for_{{ KF }}_3.x_configuration>": "<setting_value>",
                            ...,
                            "<setting_N_for_{{ KF }}_3.x_configuration>": "<setting_value>"
                          }
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Specify the relevant parameters:
            * `configSpec.kafka.kafkaConfig_2_8.<setting_for_{{ KF }}_2.8_configuration>`: For {{ KF }} `2.8`.
            * `configSpec.kafka.kafkaConfig_3.<setting_for_{{ KF }}_3.x_configuration>`: For {{ KF }} `3.x`.
        * `configSpec.kafka.kafkaConfig_2_8.<setting_for_{{ KF }}_2.8_configuration`: Specify a new value for the setting if using {{ KF }} `2.8`.
        * `configSpec.kafka.kafkaConfig_3.<setting_for_{{ KF }}_3.x_configuration`: Specify a new value for the setting if using {{ KF }} `3.x`.

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                      "config_spec.kafka.kafka_config_2_8.<setting_1_for_{{ KF }}_2.8_configuration>",
                      ...,
                      "config_spec.kafka.kafka_config_2_8.<setting_N_for_{{ KF }}_2.8_configuration>",
                      "config_spec.kafka.kafka_config_3.<setting_1_for_{{ KF }}_3.x_configuration>",
                      ...,
                      "config_spec.kafka.kafka_config_3.<setting_N_for_{{ KF }}_3.x_configuration>"
                    ]
                  }
                  "config_spec": {
                    "kafka": {
                      "kafka_config_2_8": {
                        "<setting_1_for_{{ KF }}_2.8_configuration>": "<setting_value>",
                        "<setting_2_for_{{ KF }}_2.8_configuration>": "<setting_value>",
                        ...,
                        "<setting_N_for_{{ KF }}_2.8_configuration>": "<setting_value>"
                      },
                      "kafka_config_3": {
                        "<setting_1_for_{{ KF }}_3.x_configuration>": "<setting_value>",
                        "<setting_2_for_{{ KF }}_3.x_configuration>": "<setting_value>",
                        ...,
                        "<setting_N_for_{{ KF }}_3.x_configuration>": "<setting_value>"
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Specify the relevant parameters:
            * `config_spec.kafka.kafka_config_2_8.<setting_for_{{ KF }}_2.8_configuration>`: For {{ KF }} `2.8`.
            * `config_spec.kafka.kafka_config_3.<setting_for_{{ KF }}_3.x_configuration>`: For {{ KF }} `3.x`.
        * `config_spec.kafka.kafka_config_2_8.<setting_for_{{ KF }}_2.8_configuration`: Specify a new value for the setting if using {{ KF }} `2.8`.
        * `config_spec.kafka.kafka_config_3.<setting_for_{{ KF }}_3.x_configuration`: Specify a new value for the setting if using {{ KF }} `3.x`.

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Moving a cluster to another folder {#move-cluster}

{% list tabs group=instructions %}


- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To move a cluster:

    1. View the description of the CLI move cluster command:

        ```bash
        {{ yc-mdb-kf }} cluster move --help
        ```

    1. Specify the destination folder in the move cluster command:

        ```bash
        {{ yc-mdb-kf }} cluster move <cluster_name_or_ID> \
           --destination-folder-name=<destination_folder_name>
        ```

        To find out the cluster name or ID, [get a list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.move](../api-ref/Cluster/move.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>:move' \
            --data '{
                      "destinationFolderId": "<folder_ID>"
                    }'
        ```

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/Move](../api-ref/grpc/Cluster/move.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "destination_folder_id": "<folder_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Move
        ```

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
