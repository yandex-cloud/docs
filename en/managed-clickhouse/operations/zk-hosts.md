---
title: Managing {{ ZK }} hosts
description: Follow this guide to manage {{ ZK }} hosts.
---

# Managing {{ ZK }} hosts


{{ ZK }} is a coordination tool you can use to distribute queries among {{ CH }} hosts for [data replication](../concepts/replication.md). For successful replication, a {{ mch-name }} cluster must have [three or five {{ ZK }} hosts](../qa/cluster-settings.md#zookeeper-hosts-number). This cluster will be fault-tolerant.

If you are creating a cluster with two or more {{ CH }} hosts per shard, the system automatically adds three {{ ZK }} hosts to the cluster. At this stage, you can only set up their configuration. If you created a single-host cluster or a cluster with multiple single-host shards, you can add {{ ZK }} hosts later.

For more information about {{ ZK }} hosts, see [{#T}](../concepts/replication.md#zk).

You can do the following with {{ ZK }} hosts:

* [Get a list of cluster hosts](#list-hosts).
* [Add {{ ZK }} hosts](#add-zk).
* [Update {{ ZK }} host settings](#update-zk-settings).
* [Restart a host](#restart).
* [Move {{ ZK }} hosts to a different availability zone](host-migration.md#zookeeper-hosts).
* [Delete a host](#delete-zk-host).

## Getting a list of cluster hosts {#list-hosts}

{% include notitle [get-hosts](../../_includes/mdb/mch/get-hosts.md) %}


## Adding {{ ZK }} hosts {#add-zk}

{% note info %}

Intel Broadwell is not supported in the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. At the top right, click **{{ ui-key.yacloud.mdb.cluster.hosts.button_create-coordinator }}**.
  1. Specify the [host class](../concepts/instance-types.md).
  1. Configure the storage.
  1. Change the {{ ZK }} host settings, if required. To do this, hover over the relevant host row and click ![image](../../_assets/console-icons/pencil.svg).
  1. To convert non-replicated tables to [replicated](../concepts/replication.md#replicated-tables), enable **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}**. This will convert [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree) tables to [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication) ones.

     {% note warning %}

     Once this option is enabled, you cannot disable it.

     {% endnote %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add {{ ZK }} hosts to a cluster:
  1. See the description of the CLI command for adding {{ ZK }} hosts:

     ```bash
     {{ yc-mdb-ch }} cluster add-zookeeper --help
     ```

  1. Run this command to add hosts with the default configurations:

     ```bash
     {{ yc-mdb-ch }} cluster add-zookeeper <cluster_name> \
        --host zone-id={{ region-id }}-d,subnet-name=default-d \
        --host zone-id={{ region-id }}-a,subnet-name=default-a \
        --host zone-id={{ region-id }}-b,subnet-name=default-b
     ```

     If the cluster network contains exactly three subnets, one per availability zone, you do not have to explicitly specify subnets for the hosts: {{ mch-name }} will automatically distribute hosts across these subnets.

     To convert non-replicated tables to [replicated](../concepts/replication.md#replicated-tables), add the `--convert-tables-to-replicated` parameter to the command. This will convert [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree) tables to [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication) ones.

     {% note warning %}

     Once this option is enabled, you cannot disable it.

     {% endnote %}

     You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  To add {{ ZK }} hosts to a cluster:

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For information on how to create such a file, see [Creating a cluster](cluster-create.md).

  1. Make sure the configuration file describes three subnets, one per availability zone. Add the missing ones, if required:

     ```hcl
     resource "yandex_vpc_network" "<network_name>" {
       name = "<network_name>"
     }

     resource "yandex_vpc_subnet" "<subnet_name_in_{{ region-id }}-a_zone>" {
       name           = "<subnet_name_in_{{ region-id }}-a_zone>"
       zone           = "{{ region-id }}-a"
       network_id     = yandex_vpc_network.<network_name>.id
       v4_cidr_blocks = [ "<{{ region-id }}-a_zone_subnet_IP_address_range>" ]
     }

     resource "yandex_vpc_subnet" "<subnet_name_in_{{ region-id }}-b_zone>" {
       name           = "<subnet_name_in_{{ region-id }}-b_zone>"
       zone           = "{{ region-id }}-b"
       network_id     = yandex_vpc_network.<network_name>.id
       v4_cidr_blocks = [ "<{{ region-id }}-b_zone_subnet_IP_address_range>" ]
     }

     resource "yandex_vpc_subnet" "<subnet_name_in_{{ region-id }}-d_zone>" {
       name           = "<subnet_name_in_{{ region-id }}-d_zone>"
       zone           = "{{ region-id }}-d"
       network_id     = yandex_vpc_network.<network_name>.id
       v4_cidr_blocks = [ "<{{ region-id }}-d_zone_subnet_IP_address_range>" ]
     }
     ```

  1. Add a {{ ZK }} configuration section and at least three `ZOOKEEPER`-type `host` sections to the {{ CH }} cluster description.

     {{ ZK }} host requirements:
     * Each availability zone must have at least one host.
     * Minimum host class: `b1.medium`.
     * Disk type: `{{ disk-type-example }}`.
     * Minimum storage size: 10 GB.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       ...
       zookeeper {
         resources {
           resource_preset_id = "<host_class>"
           disk_type_id       = "{{ disk-type-example }}"
           disk_size          = <storage_size_in_GB>
         }
       }
       ...
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-a"
         subnet_id = yandex_vpc_subnet.<subnet_name_in_{{ region-id }}-a_zone>.id
       }
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-b"
         subnet_id = yandex_vpc_subnet.<subnet_name_in_{{ region-id }}-b_zone>.id
       }
       host {
         type      = "ZOOKEEPER"
         zone      = "{{ region-id }}-d"
         subnet_id = yandex_vpc_subnet.<subnet_name_in_{{ region-id }}-d_zone>.id
       }
     }
     ```

     Where `resource_preset_id` is the host class, `b1.medium` or higher.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mch }}).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  {% include [zk-hosts-rest](../../_includes/mdb/mch/api/zk-hosts-rest.md) %}

- gRPC API {#grpc-api}

  {% include [zk-hosts-grpc](../../_includes/mdb/mch/api/zk-hosts-grpc.md) %}

{% endlist %}

{% note info %}

{{ ZK }} hosts have the following configuration by default:
* Host class: `b2.medium`.
* Network SSD [storage](../concepts/storage.md) (`{{ disk-type-example }}`): 10 GB.

{% endnote %}

## Updating {{ ZK }} host settings {#update-zk-settings}

After creating {{ ZK }} hosts, you can change their [class](../concepts/instance-types.md), storage size, and [disk type](../concepts/storage.md).

{% include [instance-type-change](../../_includes/mdb/mch/instance-type-change.md) %}

{% note info %}

To change the disk type to `local-ssd`, contact [support]({{ link-console-support }}).

{% endnote %}

The minimum number of cores per {{ ZK }} host depends on the total number of cores on {{ CH }} hosts. To learn more, see [Replication](../concepts/replication.md#zk).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}**, select the platform, VM type, and required {{ ZK }} host class.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_zookeeper-disk }}**, set the storage size and disk type for {{ ZK }} hosts.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update a {{ ZK }} host configuration:

  1. View the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Get the list of available host classes (the `ZONE IDS` column specifies the availability zones where you can select the appropriate class):

     ```bash
     {{ yc-mdb-ch }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

  1. In the update cluster command, specify the new class, disk type, and storage size for your {{ ZK }} host:

     ```bash
     {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
        --zookepeer-resource-preset=<host_class> \
        --zookeeper-disk-size=<storage_size_in_GB> \
        --zookeeper-disk-type=<disk_type>
     ```

     You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  To change the {{ ZK }} host settings:

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For information on how to create such a file, see [Creating a cluster](cluster-create.md).

  1. In the {{ ZK }} configuration section, specify the new host class, disk type, and storage size.

     {{ ZK }} host requirements:
     * Minimum host class: `b1.medium`.
     * Minimum storage size: 10 GB.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       ...
       zookeeper {
         resources {
           resource_preset_id = "<host_class>"
           disk_type_id       = "<disk_type>"
           disk_size          = <storage_size_in_GB>
         }
       }
       ...
     }
     ```

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mch }}).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Get the list of available host classes:

      1. Call the [ResourcePreset.List](../api-ref/ResourcePreset/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          ```bash
          curl \
              --request GET \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/resourcePresets'
          ```

      1. View the [server response](../api-ref/ResourcePreset/list.md#responses) to make sure your request was successful.

  1. Update the host class, disk type, and storage size:

      1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

          ```bash
          curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
              --data '{
                        "updateMask": "configSpec.zookeeper.resources.resourcePresetId,configSpec.zookeeper.resources.diskTypeId,configSpec.zookeeper.resources.diskSize",
                        "configSpec": {
                          "zookeeper": {
                            "resources": {
                              "resourcePresetId": "<host_class>",
                              "diskTypeId": "<disk_type>",
                              "diskSize": "<storage_size_in_GB>"
                            }
                          }
                        }
                      }'
          ```

          Where:

          * `updateMask`: Comma-separated list of settings you want to update.

              Specify the relevant parameters:
              * `configSpec.zookeeper.resources.resourcePresetId`: To change the {{ ZK }} host class.
              * `configSpec.zookeeper.resources.diskTypeId`: To change the disk type for {{ ZK }} hosts.
              * `configSpec.zookeeper.resources.diskSize`: To change the {{ ZK }} storage size.

          * `configSpec.zookeeper.resources.resourcePresetId`: [Host class](../concepts/instance-types.md) ID.
          * `configSpec.zookeeper.resources.diskTypeId`: [Disk type](../concepts/storage.md).
          * `configSpec.zookeeper.resources.diskSize`: Storage size, in GB.

          You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Get the list of available host classes:

      1. Use the [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

          ```bash
          grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/resource_preset_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ResourcePresetService.List
          ```

      1. View the [server response](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.clickhouse.v1.ListResourcePresetsResponse) to make sure your request was successful.

  1. Update the host class, disk type, and storage size:

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
                        "config_spec.zookeeper.resources.resource_preset_id",
                        "config_spec.zookeeper.resources.disk_type_id",
                        "config_spec.zookeeper.resources.disk_size"
                      ]
                    },
                    "config_spec": {
                      "zookeeper": {
                        "resources": {
                          "resource_preset_id": "<host_class>",
                          "disk_type_id": "<disk_type>",
                          "disk_size": "<storage_size_in_GB>"
                        }
                      }
                    }
                  }' \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
          ```

          Where:

          * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

              Specify the relevant parameters:
              * `config_spec.zookeeper.resources.resource_preset_id`: To change the {{ ZK }} host class.
              * `config_spec.zookeeper.resources.disk_type_id`: To change the disk type for {{ ZK }} hosts.
              * `config_spec.zookeeper.resources.disk_size`: To change the {{ ZK }} storage size.

          * `config_spec.zookeeper.resources.resource_preset_id`: [Host class](../concepts/instance-types.md) ID.
          * `config_spec.zookeeper.resources.disk_type_id`: [Disk type](../concepts/storage.md).
          * `config_spec.zookeeper.resources.disk_size`: Storage size, in GB.

          You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Restarting a {{ ZK }} host {#restart}

{% include notitle [restart-host](../../_includes/mdb/mch/restart-host.md) %}

## Converting non-replicated tables to replicated {#replicated-tables}

To automatically convert non-replicated [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables to [replicated](../concepts/replication.md#replicated-tables) [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) tables, add {{ ZK }} hosts with table conversion enabled.

For more information, see [Adding {{ ZK }} hosts](#add-zk) and [this {{ CH }} guide]({{ ch.docs }}/development/architecture#replication).

## Deleting a {{ ZK }} host {#delete-zk-host}

{% note warning %}

If {{ ZK }} hosts have already been created in the cluster, you cannot delete them completely: a cluster will always have at least three {{ ZK }} hosts.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. Hover over the relevant host row and click ![image](../../_assets/console-icons/xmark.svg).
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a host from the cluster, run this command:

  ```bash
  {{ yc-mdb-ch }} hosts delete <host_name> \
    --cluster-name=<cluster_name>
  ```

  You can get the host name with the [list of cluster hosts](hosts.md#list-hosts), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   To delete a {{ ZK }} host:

   1. Open the current {{ TF }} configuration file describing your infrastructure.

      For information on how to create such a file, see [Creating a cluster](cluster-create.md).
   1. Delete the `ZOOKEEPER`-type `host` section from the {{ mch-name }} cluster description.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Type `yes` and press **Enter**.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

  {% include [zk-hosts-rest](../../_includes/mdb/mch/api/delete-zk-hosts-rest.md) %}

- gRPC API {#grpc-api}

  {% include [zk-hosts-grpc](../../_includes/mdb/mch/api/delete-zk-hosts-grpc.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
