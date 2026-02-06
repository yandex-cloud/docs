---
title: How to update {{ KF }} cluster settings in {{ mkf-full-name }}
description: Follow this guide to update {{ KF }} cluster settings.
---

# Updating {{ KF }} cluster settings


After creating a {{ mkf-name }} cluster, you can:

* [Change the cluster name and description](#change-name-and-description)
* [Change the class and number of broker hosts](#change-brokers)
* [Change the {{ ZK }} host class](#change-zookeeper)
* [Change the {{ kraft-short-name }} host class](#change-kraft)
* [Change security group and public access settings](#change-sg-set)
* [Change additional cluster settings](#change-additional-settings)
* [Change {{ KF }} settings](#change-kafka-settings)
* [Move the cluster to another folder](#move-cluster)

Learn more about other cluster updates:

* [{#T}](cluster-version-update.md).
* [{#T}](storage-space.md).
* [{#T}](host-migration.md).
* [{#T}](kafka-ui-enable.md).

## Changing a cluster name and description {#change-name-and-description}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, enter a new name and description for the cluster.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the cluster name and description:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Run this command, specifying the new cluster name and description:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
          --new-name <new_cluster_name> \
          --description <new_cluster_description>
        ```

        To find out the cluster name or ID, [get the list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    {% note alert %}

    Do not change the cluster name using {{ TF }}. This will delete the existing cluster and create a new one.

    {% endnote %}

    To update the cluster description:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](./cluster-create.md).

    1. Edit the `description` parameter in the {{ mkf-name }} cluster description:

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
                      "updateMask": "name,description",
                      "name": "<cluster_name>",
                      "description": "<new_cluster_description>"
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated string of settings you want to update.

            Specify the relevant parameters:
            * `name`: To change the cluster name.
            * `description`: To change the cluster description.
        * `name`: New cluster name.
        * `description`: New cluster description.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

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

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Specify the relevant parameters:
            * `name`: To change the cluster name.
            * `description`: To change the cluster description.
        * `name`: New cluster name.
        * `description`: New cluster description.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing a class and number of broker hosts {#change-brokers}

You can increase the number of [broker hosts](../concepts/brokers.md) if the following conditions are met:

* The cluster uses {{ KF }} with {{ ZK }}. You cannot change the number of broker hosts in {{ KF }} clusters that use the [{{ kraft-short-name }} protocol](../concepts/kraft.md).
* The cluster includes at least two broker hosts in different availability zones.

You cannot reduce the number of broker hosts. To comply with cluster [high availability conditions](../concepts/ha-cluster.md), at least three broker hosts are required.

When changing the broker host class:

* A single-broker cluster will be unavailable for a few minutes with topic connections dropped.
* In a multi-broker cluster, each host will be stopped and updated one by one, remaining unavailable for a few minutes.

We recommend changing broker host class only when your cluster has no active workload.

{% list tabs group=instructions %}

- Management console {#console}

  To change the class and number of hosts:

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Change the relevant settings:
     * To update the broker host class, select a new [**{{ ui-key.yacloud.mdb.forms.section_resource }}**](../concepts/instance-types.md).
     * Change the **{{ ui-key.yacloud.kafka.label_brokers-per-az }}**.

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

  1. See the description of the CLI command for updating a cluster:

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

  To find out the cluster name or ID, [get the list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, edit the `brokers_count` parameter value to increase the number of broker hosts:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          config {
            brokers_count = <number_of_broker_hosts>
            ...
          }
          ...
        }
        ```

    1. In the {{ mkf-name }} cluster description, edit the `resource_preset_id` parameter value in the `kafka.resources` section to specify a new [broker host class](../concepts/instance-types.md):

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

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Get the list of available host classes:

        1. Call the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/resourcePresets'
            ```

        1. Check the [server response](../api-ref/ResourcePreset/list.md#responses) to make sure your request was successful.

    1. Change the class and number of broker hosts as appropriate:

        1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

            * `updateMask`: Comma-separated string of settings you want to update.

                Specify the relevant parameters:
                * `configSpec.kafka.resources.resourcePresetId`: To change the broker host class.
                * `configSpec.brokersCount`: To change the number of broker hosts.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

        1. Check the [server response](../api-ref/Cluster/update.md#responses) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Get the list of available host classes:

        1. Call the [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        1. Check the [server response](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse) to make sure your request was successful.

    1. Change the host class as appropriate:

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

            * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

                Specify the relevant parameters:
                * `config_spec.kafka.resources.resource_preset_id`: To change the broker host class.
                * `config_spec.brokers_count`: To change the number of broker hosts.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

        1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing a {{ ZK }} host class {#change-zookeeper}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
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

  1. See the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-kf }} cluster update --help
     ```

  1. To change the {{ ZK }} [host class](../concepts/instance-types.md), run this command:

     ```bash
     {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
       --zookeeper-resource-preset <host_class>
     ```

  To find out the cluster name or ID, [get the list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, edit the `resource_preset_id` parameter value in the `zookeeper.resources` section to specify a new {{ ZK }} [host class](../concepts/instance-types.md):

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

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Get the list of available host classes:

        1. Call the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/resourcePresets'
            ```

        1. Check the [server response](../api-ref/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse) to make sure your request was successful.

    1. Change the host class as appropriate:

        1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

            * `updateMask`: Comma-separated string of settings you want to update.

                Specify the relevant parameters:
                * `configSpec.zookeeper.resources.resourcePresetId`: To change the {{ ZK }} host class.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

        1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Get the list of available host classes:

        1. Call the [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        1. Check the [server response](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse) to make sure your request was successful.

    1. Change the host class as appropriate:

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

            * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

                Specify the relevant parameters:
                * `config_spec.zookeeper.resources.resource_preset_id`: To change the {{ ZK }} host class.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

        1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing a {{ kraft-short-name }} host class {#change-kraft}

{% note info %}

The {{ kraft-short-name }} host class is only used in clusters with {{ KF }} 3.6 or higher.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Select a new [**{{ ui-key.yacloud.kafka.section_kraft-resources }}**](../concepts/instance-types.md).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the class of {{ kraft-short-name }} hosts:

  1. Get information about the cluster:

     ```bash
     {{ yc-mdb-kf }} cluster list
     {{ yc-mdb-kf }} cluster get <cluster_name_or_ID>
     ```

  1. See the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-kf }} cluster update --help
     ```

  1. To change the {{ kraft-short-name }} [host class](../concepts/instance-types.md), run this command:

     ```bash
     {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
       --controller-resource-preset <host_class>
     ```

  To find out the cluster name or ID, [get the list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, edit the `resource_preset_id` parameter value in the `kraft.resources` section to specify a new {{ kraft-short-name }} [host class](../concepts/instance-types.md):

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          kraft {
            resources {
              resource_preset_id = "<{{ kraft-short-name }}_host_class>"
              ...
            }
          }
         }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Get the list of available host classes:

        1. Call the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/resourcePresets'
            ```

        1. Check the [server response](../api-ref/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse) to make sure your request was successful.

    1. Change the host class as appropriate:

        1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
                --data '{
                          "updateMask": "configSpec.kraft.resources.resourcePresetId",
                          "configSpec": {
                            "kraft": {
                              "resources": {
                                "resourcePresetId": "<{{ kraft-short-name }}_host_class_ID>"
                              }
                            }
                          }
                        }'
            ```

            Where:

            * `updateMask`: Comma-separated string of settings you want to update.

                Specify the relevant parameters:
                * `configSpec.kraft.resources.resourcePresetId`: To change the {{ kraft-short-name }} host class.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

        1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Get the list of available host classes:

        1. Call the [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        1. Check the [server response](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.kafka.v1.ListResourcePresetsResponse) to make sure your request was successful.

    1. Change the host class as appropriate:

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
                          "config_spec.kraft.resources.resource_preset_id"
                        ]
                      },
                      "config_spec": {
                        "kraft": {
                          "resources": {
                            "resource_preset_id": "<{{ kraft-short-name }}_host_class_ID>"
                          }
                        }
                      }
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.kafka.v1.ClusterService.Update
            ```

            Where:

            * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

                Specify the relevant parameters:
                * `config_spec.kraft.resources.resource_preset_id`: To change the {{ kraft-short-name }} host class.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

        1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


## Changing security group and public access settings {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the security groups for cluster network traffic.
  1. Enable or disable **Public access** to your cluster.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

  1. See the description of the CLI command for updating a cluster:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

  1. Run this command, specifying the security groups and public access settings:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --security-group-ids <list_of_security_groups> \
         --assign-public-ip=<enable_public_access_to_cluster>
      ```

      Where:

      * `--security-group-ids`: List of cluster security group IDs.
      * `--assign-public-ip`: Public access to the cluster, `true` or `false`.

      To find out the cluster name or ID, [get the list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. Change the values of the `security_group_ids` and `assign_public_ip` parameters in the cluster description:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          security_group_ids = [ <list_of_security_groups> ]
          ...
          config {
            assign_public_ip = "<enable_public_access_to_cluster>"
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

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

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
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "securityGroupIds,configSpec.assignPublicIp",
                      "securityGroupIds": [
                        <list_of_security_group_IDs>
                      ],
                      "configSpec": {
                        "assignPublicIp": "<enable_public_access_to_cluster>"
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated string of settings you want to update.

            Specify the relevant parameters:
            * `securityGroupIds`: To change the list of security groups.
            * `configSpec.assignPublicIp`: To change the public access setting.
        * `securityGroupIds`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.

            {% note warning %}

            The list of security groups assigned to the cluster will be completely overwritten by the list provided in the `securityGroupIds` parameter.

            Before running your request, make sure the list includes all the required security group IDs, including existing ones.

            {% endnote %}

        * `assignPublicIp`: Access to broker hosts from the internet, `true` or `false`.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
                      "security_group_ids",
                      "config_spec.assign_public_ip"
                    ]
                  },
                  "security_group_ids": [
                    <list_of_security_group_IDs>
                  ],
                  "config_spec": {
                    "assign_public_ip": "<enable_public_access_to_cluster>"
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Specify the relevant parameters:
            * `security_group_ids`: To change the list of security groups.
            * `config_spec.assign_public_ip`: To change the public access setting.
        * `security_group_ids`: [Security group](../../vpc/concepts/security-groups.md) IDs as an array of strings. Each string is a security group ID.

            {% note warning %}

            The list of security groups assigned to the cluster will be completely overwritten by the list provided in the `security_group_ids` parameter.

            Before running your request, make sure the list includes all the required security group IDs, including existing ones.

            {% endnote %}

        * `assign_public_ip`: Access to broker hosts from the internet, `true` or `false`.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

[Restart the cluster](./cluster-stop.md) so the new public access settings take effect.

You may need to additionally [configure security groups](connect/index.md#configuring-security-groups) to connect to the cluster.


## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Change additional cluster settings:

     {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change additional cluster settings:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Run the following command with the list of settings to update:

        
        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
           --maintenance-window type=<maintenance_type>,`
                               `day=<day_of_week>,`
                               `hour=<hour> \
           --datatransfer-access=<allow_access_from_Data_Transfer> \
           --deletion-protection \
           --schema-registry=<data_schema_management>
        ```


    You can update the following settings:

    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for stopped clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}


    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.

    * `--schema-registry`: Manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md), `true` or `false`.

        {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

    To find out the cluster name or ID, [get the list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

    1. To enable cluster protection from accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          deletion_protection = <protect_cluster_against_deletion>
        }
        ```

        Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.

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
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.restApiConfig.enabled,configSpec.schemaRegistry,maintenanceWindow,deletionProtection",
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
                      "deletionProtection": <protect_cluster_against_deletion>
                    }'
        ```


        Where:

        * `updateMask`: Comma-separated string of settings you want to update.

            Specify the relevant parameters:
            * `configSpec.schemaRegistry`: To enable the settings for data schema management using [{{ mkf-msr }}](../concepts/managed-schema-registry.md).
            * `configSpec.restApiConfig.enabled`: To enable sending {{ KF }} REST API requests.


            * `maintenanceWindow`: To change the [maintenance window](../concepts/maintenance.md) settings, including for stopped clusters.
            * `deletionProtection`: To enable or disable cluster protection from accidental deletion.

              Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.

        * `configSpec.schemaRegistry`: Set to `true` to manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md). You will not be able to edit this setting once it is enabled.
        * `configSpec.restApiConfig.enabled`: Set to `true` to enable sending {{ KF }} REST API requests. You will not be able to edit this setting once it is enabled.


        * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings, including those for stopped clusters. Select one of these options:

            * `anytime`: At any time (default).
            * `weeklyMaintenanceWindow`: On schedule:
                * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

        * `deletionProtection`: To enable (`true`) or disable (`false`) cluster protection from accidental deletion.

            Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
                  "deletion_protection": <protect_cluster_against_deletion>
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```


        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Specify the relevant parameters:
            * `config_spec.schema_registry`: To manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md).
            * `config_spec.rest_api_config.enabled`: To enable sending {{ KF }} REST API requests.


            * `maintenance_window`: To change the [maintenance window](../concepts/maintenance.md) settings, including for stopped clusters.
            * `deletion_protection`: To enable or disable protection of the cluster, its databases, and users from accidental deletion.
        * `schema_registry`: Set to `true` to manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md). You will not be able to edit this setting once it is enabled.
        * `rest_api_config.enabled`: Set to `true` to enable sending {{ KF }} REST API requests. You will not be able to edit this setting once it is enabled.


        * `maintenance_window`: [Maintenance](../concepts/maintenance.md) window settings. Select one of these options:

            * `anytime`: Any time.
            * `weekly_maintenance_window`: On schedule:
                * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

        * `deletion_protection`: To enable (`true`) or disable (`false`) cluster protection from accidental deletion.

            Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing {{ KF }} settings {#change-kafka-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
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

    1. Run the cluster update command, providing the [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) you want to change (the example below does not list all possible parameters):

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
           --compression-type <compression_type> \
           --log-flush-interval-messages <number_of_messages_in_log> \
           --log-flush-interval-ms <maximum_time_to_store_messages>
        ```

        Where:

        * `--log-flush-interval-messages`: Number of messages in the log to trigger flushing to disk.
        * `--log-flush-interval-ms`: Maximum time a message can be stored in memory before flushing to disk.

        To find out the cluster name or ID, [get the list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, edit the values of the parameters in the `kafka.kafka_config` section (the example below does not list all possible [settings](../concepts/settings-list.md#cluster-settings)):

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

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

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

        * `updateMask`: Comma-separated string of settings you want to update.

            Specify the relevant parameters:
            * `configSpec.kafka.kafkaConfig_2_8.<setting_for_{{ KF }}_2.8_configuration>`: For {{ KF }} `2.8`.
            * `configSpec.kafka.kafkaConfig_3.<setting_for_{{ KF }}_3.x_configuration>`: For {{ KF }} `3.x`.
        * `configSpec.kafka.kafkaConfig_2_8.<setting_for_{{ KF }}_2.8_configuration`: Specify a new value for the setting if using {{ KF }} `2.8`.
        * `configSpec.kafka.kafkaConfig_3.<setting_for_{{ KF }}_3.x_configuration`: Specify a new value for the setting if using {{ KF }} `3.x`.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Specify the relevant parameters:
            * `config_spec.kafka.kafka_config_2_8.<setting_for_{{ KF }}_2.8_configuration>`: For {{ KF }} `2.8`.
            * `config_spec.kafka.kafka_config_3.<setting_for_{{ KF }}_3.x_configuration>`: For {{ KF }} `3.x`.
        * `config_spec.kafka.kafka_config_2_8.<setting_for_{{ KF }}_2.8_configuration`: Specify a new value for the setting if using {{ KF }} `2.8`.
        * `config_spec.kafka.kafka_config_3.<setting_for_{{ KF }}_3.x_configuration`: Specify a new value for the setting if using {{ KF }} `3.x`.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Moving a cluster to another folder {#move-cluster}

{% list tabs group=instructions %}


- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To move a cluster:

    1. See the description of the CLI command for moving a cluster:

        ```bash
        {{ yc-mdb-kf }} cluster move --help
        ```

    1. Run this command, providing the destination folder:

        ```bash
        {{ yc-mdb-kf }} cluster move <cluster_name_or_ID> \
           --destination-folder-name=<destination_folder_name>
        ```

        To find out the cluster name or ID, [get the list of clusters in the folder](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](./cluster-create.md).

    1. In the {{ mkf-name }} cluster description, edit the `folder_id` value. If the argument does not exist, add it:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          folder_id = "<destination_folder_ID>"
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

    1. Call the [Cluster.move](../api-ref/Cluster/move.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

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

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/Move](../api-ref/grpc/Cluster/move.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
