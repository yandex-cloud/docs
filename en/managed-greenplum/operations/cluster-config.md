---
title: How to update a {{ GP }} cluster configuration in {{ mgp-full-name }}
description: Follow this guide to update a {{ GP }} cluster configuration.
---

# Updating a {{ GP }} cluster configuration


After creating a cluster, you can:

* [Change the host class](#change-resource-preset).
* [Change the disk type and increase the storage size](#change-disk-size).
* [Expand the cluster](#add-hosts) by adding segment hosts or increasing the number of segments per hosts.
* [Change the cluster's availability zone](#change-cluster-zone).

## Changing the host class {#change-resource-preset}

You can change the host class for both master hosts and segment hosts. When changing the host class, the cluster's primary master host will change.

{% include [warn-preset-change](../../_includes/mdb/mgp/warn-preset-change.md) %}

When changing the class of segment hosts, make sure that the new amount of memory in segment hosts is sufficient to maintain the number of connections specified in the [Max connections](../concepts/settings-list.md#setting-max-connections) setting.

We recommend changing the host class only when the cluster has no active workload.

{% include [note-change-resource-preset](../../_includes/mdb/note-change-resource-preset.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the required class for {{ GP }} master hosts or segment hosts.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View the description of the CLI command to update the cluster:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Request a list of available classes (the `ZONE IDS` column lists the availability zones where you can select the appropriate class):
     * For master hosts:

        ```bash
        {{ yc-mdb-gp }} resource-preset list master
        ```

     * For segment hosts:

        ```bash
        {{ yc-mdb-gp }} resource-preset list segment
        ```

     
     ```text
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     |     ID      |            ZONE IDS            |           DISK TYPES           | CORES |  MEMORY  | HOST COUNT DIVIDER | MAX SEGMENT IN HOST |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     | i2.2xlarge  | {{ region-id }}-a, {{ region-id }}-b   | local-ssd,                     |    16 | 128.0 GB |                  1 |                   0 |
     |             |                                | network-ssd-nonreplicated      |       |          |                    |                     |
     | ...                                                                                                                                         |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     ```


  1. Specify the required classes in the cluster update command:

      ```bash
      {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
          --master-config resource-id=<master_host_class_ID> \
          --segment-config resource-id=<segment_host_class_ID>
      ```

      {{ mgp-short-name }} will run the update host class command for the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mgp-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mgp }}).

  1. In the {{ mgp-name }} cluster description, change the `resource_preset_id` attribute value under `master_subcluster.resources` or `segment_subcluster.resources`:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<cluster_name>" {
        ...
        master_subcluster {
          resources {
            resource_preset_id = "<host_class>"
            ...
          }
        }
        segment_subcluster {
          resources {
            resource_preset_id = "<host_class>"
            ...
          }
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "masterConfig.resources.resourcePresetId,segmentConfig.resources.resourcePresetId",
                      "masterConfig": {
                        "resources": {
                          "resourcePresetId": "<host_class>"
                        }
                      },
                      "segmentConfig": {
                        "resources": {
                          "resourcePresetId": "<host_class>"
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

        * `masterConfig.resources.resourcePresetId` and `segmentConfig.resources.resourcePresetId`: New [host class](../concepts/instance-types.md) for master and segment hosts.

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "master_config.resources.resource_preset_id",
                      "segment_config.resources.resource_preset_id"
                    ]
                  },
                  "master_config": {
                    "resources": {
                      "resource_preset_id": "<host_class>"
                    }
                  },
                  "segment_config": {
                    "resources": {
                      "resource_preset_id": "<host_class>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

        * `master_config.resources.resource_preset_id` and `segment_config.resources.resource_preset_id`: New [host class](../concepts/instance-types.md) for master and segment hosts.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Change the disk type and increase the storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% include [warn-disk-size-increase](../../_includes/mdb/mgp/warn-disk-size-change.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Select the cluster.
  1. At the top of the page, click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:

      * Select the [disk type](../concepts/storage.md).
      * Specify the required disk size.

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the cluster storage size:

  1. View the description of the CLI command to update the cluster:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Specify the required storage size for the master hosts or segment hosts in the cluster update command (at least as large as `disk_size` in the cluster properties):

      ```bash
      {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
         --master-config disk-size <storage_size_in_GB> \
         --segment-config disk-size <storage_size_in_GB>
      ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mgp-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mgp }}).

    1. In the {{ mgp-name }} cluster description, change the values of the `disk_type_id` and `disk_size` attributes under `master_subcluster.resources` or `segment_subcluster.resources`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<cluster_name>" {
          ...
          master_subcluster {
            resources {
              disk_type_id = "<disk_type>"
              disk_size    = <storage_size_in_GB>
              ...
            }
          }
          segment_subcluster {
            resources {
              disk_type_id = "<disk_type>"
              disk_size    = <storage_size_in_GB>
              ...
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "masterConfig.resources.diskTypeId,masterConfig.resources.diskSize,segmentConfig.resources.diskTypeId,segmentConfig.resources.diskSize",
                      "masterConfig": {
                        "resources": {
                          "diskTypeId": "<disk_type>",
                          "diskSize": "<storage_size_in_bytes>"
                        }
                      },
                      "segmentConfig": {
                        "resources": {
                          "diskTypeId": "<disk_type>",
                          "diskSize": "<storage_size_in_bytes>"
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

        * `masterConfig.resources`, `segmentConfig.resources`: Storage parameters for master hosts and segment hosts:

            * `diskTypeId`: [Disk type](../concepts/storage.md).
            * `diskSize`: New storage size in bytes.

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "master_config.resources.disk_type_id",
                      "master_config.resources.disk_size",
                      "segment_config.resources.disk_type_id",
                      "segment_config.resources.disk_size"
                    ]
                  },
                  "master_config": {
                    "resources": {
                      "disk_type_id": "<disk_type>",
                      "disk_size": "<storage_size_in_bytes>"
                    }
                  },
                  "segment_config": {
                    "resources": {
                      "disk_type_id": "<disk_type>",
                      "disk_size": "<storage_size_in_bytes>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

        * `master_config.resources`, `segment_config.resources`: Storage parameters for master hosts and segment hosts:

            * `disk_type_id`: [Disk type](../concepts/storage.md).
            * `disk_size`: New storage size in bytes.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Expanding a cluster {#add-hosts}

You can add segment hosts to a {{ mgp-name }} cluster by [expanding it](cluster-expand.md). You need to add at least two hosts. You can also increase the [number of segments per host](../concepts/index.md) when expanding a cluster.

## Changing the cluster's availability zone {#change-cluster-zone}

All {{ mgp-name }} cluster hosts are located in the same {{ yandex-cloud }} [availability zone](../../overview/concepts/geo-scope.md). You cannot migrate a cluster to a different availability zone. If you need to change the availability zone, [restore the cluster from a backup](cluster-backups.md#restore). When restoring from a backup, specify a new availability zone in the new cluster's settings.

{% include [zone-d-disk-restrictions](../../_includes/mdb/ru-central1-d-local-ssd.md) %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
