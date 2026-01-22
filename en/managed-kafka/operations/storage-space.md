---
title: Managing disk space in a {{ mkf-name }} cluster
description: You can monitor storage usage and increase its size either manually or automatically.
---

# Managing disk space in a {{ mkf-name }} cluster

As soon as the [storage](../concepts/storage.md) is 97% full, the host automatically enters read-only mode. To avoid issues with writing to the topic, use one of the following methods:


* [Set up alerts in {{ monitoring-full-name }}](#set-alert) to monitor storage utilization.


* [Increase the storage size](#change-disk-size) to automatically disable read-only mode.
* [Set up automatic increase of storage size](#disk-size-autoscale) to prevent situations where the disk runs out of free space and the host switches to read-only mode.


## Set up alerts in {{ monitoring-full-name }} {#set-alert}

1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. [Create a notification channel](../../monitoring/operations/alert/create-channel.md).
1. [Create an alert](../../monitoring/operations/alert/create-alert.md) with the following settings:

    1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**: Configure the following metric settings:

        * Cloud.
        * Folder.
        * **{{ ui-key.yacloud_monitoring.services.label_managed-kafka }}**.
        * {{ mkf-name }} cluster ID.

            You can get the ID with the [list of clusters in the folder](../operations/cluster-list.md#list-clusters).

        * `disk.free_bytes` label.

    1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}**: Set the condition for free disk space usage to trigger the alert:

        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**: `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (metric’s minimum value over the period).
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
        * **{{ ui-key.yacloud_monitoring.alert.status_warn }}**: `95` (95% of the storage size).
        * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}**: `90` (90% of the storage size).
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**: Preferred metric update period.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}**: Preferred time shift backward, in seconds. It allows to keep the alert from triggering when multiple metrics are specified and collected at different intervals. To learn more about the calculation delay, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

    1. **Notifications**: Add the previously created notification channel.


## Increasing your storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

* Management console {#console}

    To increase your cluster storage size:

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Edit the settings in the **{{ ui-key.yacloud.mdb.forms.section_storage }}** section.

        You cannot change the disk type for an {{ KF }} cluster once you create it.

    1. Click **{{ ui-key.yacloud.common.save }}**.

* CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To increase the hosts' storage size:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. To change the size of the broker host storage, run the command:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
           --disk-size <storage_size>
        ```

        If no size units are specified, gigabytes are used.

    1. To change the size of the {{ ZK }} host storage, run the command:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
           --zookeeper-disk-size <disk_size>
        ```

        If no size units are specified, gigabytes are used.

    You cannot change the disk type for an {{ KF }} cluster once the cluster is created.

* {{ TF }} {#tf}

  To increase your cluster storage size:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, change the `disk_size` value in the `kafka.resources` and `zookeeper.resources` sections for {{ KF }} and {{ ZK }} hosts, respectively:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          kafka {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
            ...
          }
          zookeeper {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
          }
        }
        ```

        You cannot change the disk type for an {{ KF }} cluster once the cluster is created.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

* REST API {#api}

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
                      "updateMask": "configSpec.kafka.resources.diskSize,configSpec.zookeeper.resources.diskSize",
                      "configSpec": {
                        "kafka": {
                          "resources": {
                            "diskSize": "<storage_size_in_bytes>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "diskSize": "<storage_size_in_bytes>"
                          }
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated string of settings you want to update.

            Specify the relevant parameters:
            * `configSpec.kafka.resources.diskSize`: To change the broker host storage size.
            * `configSpec.zookeeper.resources.diskSize`: To change the {{ ZK }} host storage size. Use only for {{ KF }} 3.5 clusters.
        * `configSpec.kafka.resources.diskSize`: Broker host storage size in bytes.
        * `configSpec.zookeeper.resources.diskSize`: {{ ZK }} host storage size, in bytes. Use only for {{ KF }} 3.5 clusters.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure your request was successful.

* gRPC API {#grpc-api}

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
                      "config_spec.kafka.resources.disk_size",
                      "config_spec.zookeeper.resources.disk_size"
                    ]
                  },
                  "config_spec": {
                    "kafka": {
                      "resources": {
                        "disk_size": "<storage_size_in_bytes>"
                      }
                    },
                    "zookeeper": {
                      "resources": {
                        "disk_size": "<storage_size_in_bytes>"
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
            * `config_spec.kafka.resources.disk_size`: To change the broker host storage size.
            * `config_spec.brokers_count`: To change the {{ ZK }} host storage size. Use only for {{ KF }} 3.5 clusters.
        * `config_spec.kafka.resources.disk_size`: Broker host storage size in bytes.
        * `config_spec.zookeeper.resources.disk_size`: {{ ZK }} host storage size, in bytes. Use only for {{ KF }} 3.5 clusters.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Set up automatic storage expansion {#disk-size-autoscale}

Set up [automatic storage increase](../concepts/storage.md#auto-rescale) to prevent the cluster from running out of disk space and the hosts from switching to read-only mode.

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

* Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**, set the storage [utilization thresholds](../concepts/storage.md#auto-rescale) that will trigger storage expansion when reached: 
    
        {% include [autoscale-settings](../../_includes/mdb/mkf/autoscale-settings.md) %}

* CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To set up storage autoscaling:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Set the maximum storage size and conditions for its increase in the update cluster command:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_ID_or_name> \
           --disk-size-autoscaling planned-usage-threshold=<scheduled_expansion_percentage>,`
                                  `emergency-usage-threshold=<immediate_expansion_percentage>,`
                                  `disk-size-limit=<maximum_storage_size_in_bytes>
        ```

        {% include [description-of-parameters](../../_includes/mdb/mkf/disk-auto-scaling.md) %}

* REST API {#api}

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
                      "updateMask": "configSpec.diskSizeAutoscaling.plannedUsageThreshold,configSpec.diskSizeAutoscaling.plannedUsageThreshold,configSpec.diskSizeAutoscaling.plannedUsageThreshold",
                      "configSpec": {
                        "diskSizeAutoscaling": {
                          "plannedUsageThreshold": "<scheduled_expansion_percentage>",
                          "emergencyUsageThreshold": "<immediate_expansion_percentage>",
                          "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated string of settings you want to update.

            Specify the relevant parameters:
            * `configSpec.diskSizeAutoscaling.plannedUsageThreshold`: To change the storage utilization percentage to trigger a scheduled increase.
            * `configSpec.diskSizeAutoscaling.emergencyUsageThreshold`: To change the storage utilization percentage to trigger a non-scheduled increase.
            * `configSpec.diskSizeAutoscaling.diskSizeLimit`: To change the maximum storage size during autoscaling.

        {% include [autoscale-settings](../../_includes/mdb/mkf/api/rest-autoscale-settings.md) %}

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure your request was successful.

* gRPC API {#grpc-api}

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
                      "config_spec.disk_size_autoscaling.planned_usage_threshold",
                      "config_spec.disk_size_autoscaling.emergency_usage_threshold",
                      "config_spec.disk_size_autoscaling.disk_size_limit"
                    ]
                  },
                  "config_spec": {
                    "disk_size_autoscaling": {
                        "planned_usage_threshold": "<scheduled_expansion_percentage>",
                        "emergency_usage_threshold": "<immediate_expansion_percentage>",
                        "disk_size_limit": "<maximum_storage_size_in_bytes>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Specify the relevant parameters:
            * `config_spec.disk_size_autoscaling.planned_usage_threshold`: To change the storage utilization percentage to trigger a scheduled increase.
            * `config_spec.disk_size_autoscaling.emergency_usage_threshold`: To change the storage utilization percentage to trigger a non-scheduled increase.
            * `config_spec.disk_size_autoscaling.disk_size_limit`: To change the maximum storage size during autoscaling.

        {% include [autoscale-settings](../../_includes/mdb/mkf/api/grpc-autoscale-settings.md) %}

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [storage-resize-steps](../../_includes/mdb/mkf/storage-resize-steps.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}

