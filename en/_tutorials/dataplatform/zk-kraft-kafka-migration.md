# Upgrading a {{ mkf-name }} cluster to migrate from {{ ZK }} to {{ kraft-short-name }}


{{ mkf-name }} multi-host clusters version 3.5 and lower use {{ ZK }} to manage metadata. {{ ZK }} support will be [discontinued](../../managed-kafka/concepts/update-policy.md#version-schedule) starting from {{ KF }} 4.0. You can migrate clusters with {{ ZK }} hosts to the {{ kraft-short-name }} protocol. Starting with version 3.6, {{ KF }} uses [{{ kraft-short-name }}](../../managed-kafka/concepts/kraft.md) as the main metadata synchronization protocol.

To switch to {{ kraft-short-name }} in a {{ ZK }} cluster:

1. [Update the cluster version](#update-version).
1. [Migrate the cluster to {{ kraft-short-name }}](#migrate-to-kraft).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mkf-name }} cluster fee: using computing resources allocated to hosts (including {{ kraft-short-name }} hosts) and disk space (see [{{ mkf-name }} pricing](../../managed-kafka/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Update the cluster version {#update-version}

Update {{ KF }} in your cluster with {{ ZK }} to version `3.9` step by step without skipping versions in the following order: 3.5 → 3.6 → 3.7 → 3.8 → 3.9. If your cluster’s version is lower than `3.5`, first, [update the cluster](../../managed-kafka/operations/cluster-version-update.md) to this version.

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. In the row with your cluster, click ![image](../../_assets/console-icons/ellipsis.svg), then select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select version 3.6.
    1. Click **{{ ui-key.yacloud.common.save }}**.
    1. Repeat the steps for the remaining {{ KF }} versions in the given order.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Initiate updating {{ KF }} in your cluster with the following command:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
           --version=3.6
        ```

    1. Repeat the command for the remaining versions in the given order.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.
    1. In the `config` section of the {{ mkf-name }} cluster, set `3.6` in the `version` field as the new {{ KF }} version:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          config {
            version = "3.6"
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    1. Repeat the steps for the remaining {{ KF }} versions in the given order.

- REST API {#api}

    1. [Get an IAM token for API authentication](../../managed-kafka/api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.update](../../managed-kafka/api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "3.6"
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

          Here only one parameter is specified: `configSpec.version`.

        * `configSpec.version`: {{ KF }} version.

       You can request the cluster ID with the [list of clusters in the folder](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../managed-kafka/api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.
    1. Repeat the steps for the remaining {{ KF }} versions in the given order.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../managed-kafka/api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [ClusterService/Update](../../managed-kafka/api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                      "config_spec.version"
                    ]
                  },
                  "config_spec": {
                    "version": "3.6"
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          Here only one parameter is specified: `config_spec.version`.

        * `config_spec.version`: {{ KF }} version.

        You can request the cluster ID with the [list of clusters in the folder](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../managed-kafka/api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.
    1. Repeat the steps for the remaining {{ KF }} versions in the given order.

{% endlist %}

## Migrate the cluster to {{ kraft-short-name }} {#migrate-to-kraft}

To migrate a {{ mkf-name }} cluster with {{ ZK }} hosts to the {{ kraft-short-name }} protocol, configure resources for the {{ kraft-short-name }} controllers.

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Click the cluster name.
    1. At the top of the screen, click **Migrate**.
    1. Select the [platform](../../compute/concepts/vm-platforms.md), host type, and host class for the {{ kraft-short-name }} controllers.
    1. Click **{{ ui-key.yacloud.common.save }}**.
    1. Wait for the migration to complete.

- CLI {#cli}

    Run this command to start the cluster migration:

     ```bash
     {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
        --controller-resource-preset "<{{ kraft-short-name }}_host_class>" \
        --controller-disk-size <storage_size> \
        --controller-disk-type <disk_type>
     ```

     Where:

     * `--controller-resource-preset`: [{{ kraft-short-name }} host class](../../managed-kafka/concepts/instance-types.md).
     * `--controller-disk-type`: Disk type of {{ kraft-short-name }} hosts.

     {% include [kraft-resources](../../_includes/mdb/mkf/note-kraft-resources-limits.md) %}

     To find out the cluster name or ID, [get a list of clusters in the folder](../../managed-kafka/operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.
    1. Delete the `config.zookeeper` section of the {{ mkf-name }} cluster.
    1. Add the `config.kraft` section with the {{ kraft-short-name }} controller resource description:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          config {
            ...
            kraft {
              resources {
                disk_size          = <storage_size_in_GB>
                disk_type_id       = "<disk_type>"
                resource_preset_id = "<{{ kraft-short-name }}_host_class>"
              }
            }
          }
        }
        ```

        Where:

        * `kraft.resources.resource_preset_id`: [{{ kraft-short-name }} host class](../../managed-kafka/concepts/instance-types.md).
        * `kraft.resources.disk_type_id`: Disk type of {{ kraft-short-name }} hosts.

        {% include [kraft-resources](../../_includes/mdb/mkf/note-kraft-resources-limits.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../../managed-kafka/api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.update](../../managed-kafka/api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.kraft.resources.resourcePresetId,configSpec.kraft.resources.diskSize,configSpec.kraft.resources.diskTypeId",
                      "configSpec": {
                        "kraft": {
                          "resources": {
                            "resourcePresetId": "<{{ kraft-short-name }}_host_class>",
                            "diskSize": "<storage_size_in_bytes>",
                            "diskTypeId": "<disk_type>"
                          }
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

          Here you need to specify all parameters of the resources you want to add: `configSpec.kraft.resources.resourcePresetId`, `configSpec.kraft.resources.diskSize`, `configSpec.kraft.resources.diskTypeId`.

        * `configSpec.kraft`: {{ kraft-short-name }} controller configuration:

            * `resources.resourcePresetId`: Host class ID. You can request the list of available host classes with their IDs using the [ResourcePreset.list](../../managed-kafka/api-ref/ResourcePreset/list.md) method.
            * `resources.diskSize`: Disk size in bytes.
            * `resources.diskTypeId`: Disk type.

            {% include [kraft-resources](../../_includes/mdb/mkf/note-kraft-resources-limits.md) %}

       You can request the cluster ID with the [list of clusters in the folder](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../managed-kafka/api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../managed-kafka/api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [ClusterService/Update](../../managed-kafka/api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                      "config_spec.kraft.resources.resource_preset_id",
                      "config_spec.kraft.resources.disk_size",
                      "config_spec.kraft.resources.disk_type_id"
                    ]
                  },
                  "config_spec": {
                    "kraft": {
                      "resources": {
                        "resource_preset_id": "<{{ kraft-short-name }}_host_class>",
                        "disk_size": "<storage_size_in_bytes>",
                        "disk_type_id": "<disk_type>"
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          Here you need to specify all parameters of the resources you want to add: `config_spec.kraft.resources.resource_preset_id`, `config_spec.kraft.resources.disk_size`, `config_spec.kraft.resources.disk_type_id`.

        * `config_spec.kraft`: {{ kraft-short-name }} controller configuration:

            * `resources.resource_preset_id`: Host class ID. You can request the list of available host classes with their IDs using the [ResourcePreset.list](../../managed-kafka/api-ref/grpc/ResourcePreset/list.md) method.
            * `resources.disk_size`: Disk size in bytes.
            * `resources.disk_type_id`: Disk type.

            {% include [kraft-resources](../../_includes/mdb/mkf/note-kraft-resources-limits.md) %}

        You can request the cluster ID with the [list of clusters in the folder](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. View the [server response](../../managed-kafka/api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

    [Delete the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}