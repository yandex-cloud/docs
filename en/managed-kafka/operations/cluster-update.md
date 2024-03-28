---
title: "How to change {{ KF }} cluster settings in {{ mkf-full-name }}"
description: "Follow this guide to change {{ KF }} cluster settings."
---

# Changing {{ KF }} cluster settings

After creating a {{ mkf-name }} cluster, you can:

* [{#T}](#change-brokers).
* [{#T}](#change-zookeeper).
* [{#T}](#change-disk-size) (unavailable for non-replicated SSD [storage](../concepts/storage.md)).
* [{#T}](#change-additional-settings).
* [{#T}](#change-kafka-settings).
* [{#T}](#move-cluster) from the current folder to another one.
* [{#T}](#change-sg-set).

To move a cluster to a different availability zone, follow [this guide](host-migration.md). You will thus move the cluster hosts.

## Changing the broker host class and number {#change-brokers}

You cannot increase the number of {{ KF }} broker hosts unless a cluster includes at least two broker hosts in different availability zones. You cannot have fewer broker hosts. To meet the cluster [fault tolerance conditions](../concepts/index.md#fault-tolerance), you need at least three broker hosts.

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. In the appropriate cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Change the required settings:
      * To edit the [broker host](../concepts/brokers.md) class, select a new [**{{ ui-key.yacloud.mdb.forms.section_resource }}**](../concepts/instance-types.md).
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

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. To increase the number of broker hosts, run the command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> --brokers-count <number_of_broker_hosts>
      ```

   1. To change the broker host class, run the command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> --resource-preset <host_class>
      ```

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

   1. In the {{ mkf-name }} cluster description, edit the value of the `resource_preset_id` parameter under `kafka.resources` to specify a new broker host class:

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

- API {#api}

   To change the class and number of broker hosts, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Broker host class in the `configSpec.kafka.resources.resourcePresetId` parameter.
   * Number of broker hosts in the `configSpec.brokersCount` parameter.
   * List of settings to update, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing the {{ ZK }} host class {#change-zookeeper}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. In the appropriate cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
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

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. To change the {{ ZK }} host class, run this command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
        --zookeeper-resource-preset <host_class>
      ```

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

   1. In the {{ mkf-name }} cluster description, edit the value of the `resource_preset_id` parameter under `zookeeper.resources` to specify a new {{ ZK }} host class:

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

- API {#api}

   To change the class of {{ ZK }} hosts, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * {{ ZK }} host class in the `configSpec.zookeeper.resources.resourcePresetId` parameter.
   * List of settings to update, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% note warning %}

You cannot change the disk type for an {{ KF }} cluster once you create it.

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   To increase the cluster storage size:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. In the appropriate cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Edit the settings in the **{{ ui-key.yacloud.mdb.forms.section_storage }}** section.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase the hosts' storage size:

   1. View a description of the update cluster CLI command:

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

- {{ TF }} {#tf}

   To increase the cluster storage size

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

   1. In the {{ mkf-name }} cluster description, change the `disk_size` parameter in the `kafka.resources` and `zookeeper.resources` sections for the {{ KF }} and {{ ZK }} hosts, respectively:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
        ...
        kafka {
          resources {
            disk_size = <storage_size_GB>
            ...
          }
          ...
        }
        zookeeper {
          resources {
            disk_size = <storage_size_GB>
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

- API {#api}

   To increase the cluster storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New storage settings in the `configSpec.kafka.resources` parameter (`configSpec.zookeeper.resources` for {{ ZK }} hosts).
   * List of settings to update, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


## Updating security group and public access settings {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. In the appropriate cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select security groups for cluster network traffic.
   1. Enable or disable public access to a cluster via the **Public access** option.
   1. Click **{{ ui-key.yacloud.common.save }}**.

   [Restart the cluster](./cluster-stop.md) for the new public access settings to take effect.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the update cluster CLI command:

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

   [Restart the cluster](./cluster-stop.md) for the new public access settings to take effect.

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
      * `security_group_ids`: List of IDs of security groups in the cluster.
      * `assign_public_ip`: Public access to the cluster, `true` or `false`.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   [Restart the cluster](./cluster-stop.md) for the new public access settings to take effect.

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

   To change the security group and public access settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   - Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   - List of security group IDs in the `securityGroupIds` parameter.
   - Public access settings in the `configSpec.assignPublicIp` parameter.
   - List of settings to update, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

   [Restart the cluster](./cluster-stop.md) for the new public access settings to take effect.

{% endlist %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.


## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. In the appropriate cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Change additional cluster settings:

      {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. Run the following command with a list of settings to update:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<hour> \
         --datatransfer-access=<access_to_cluster> \
         --deletion-protection=<deletion_protection>\
         --schema-registry=<data_schema_management>
      ```

   You can change the following settings:

   * `--maintenance-window`: Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters), where `type` is the maintenance type:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

   * {% include [datatransfer access](../../_includes/mdb/cli/datatransfer-access-update.md) %}

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [Deletion protection](../../_includes/mdb/deletion-protection-limits-data.md) %}

   * `--schema-registry`: Enable this option to manage data schemas using [{{ mkf-msr }}](../concepts/managed-schema-registry.md).

      {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

   You can get the cluster ID and name [with a list of clusters in the folder](cluster-list.md#list-clusters).

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

   1. To enable data schema management via [{{ mkf-msr }}](../concepts/managed-schema-registry.md), add to the cluster description the `config.schema_registry` field with `true` for value:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
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

- API {#api}

   To change additional cluster settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).

   * Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters) in the `maintenanceWindow` parameter.

   * Cluster access configuration settings for [{{ data-transfer-full-name }}](../../data-transfer/) in Serverless mode: in the `configSpec.access.dataTransfer` parameter.

      This enables you to connect to {{ data-transfer-full-name }} running in {{ k8s }} via a special network. As a result, other operations, e.g., transfer launch and deactivation, will run faster.

   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Deletion protection](../../_includes/mdb/deletion-protection-limits-data.md) %}

   * Settings for data schema management via [{{ mkf-msr }}](../concepts/managed-schema-registry.md) in the `configSpec.schemaRegistry` parameter.

      {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ KF }} settings {#change-kafka-settings}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. In the appropriate cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_settings-kafka }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.

      For more information, see [{{ KF }} settings](../concepts/settings-list.md).

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change {{ KF }} settings:

   1. View a description of the CLI update cluster settings command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. Change [settings {{ KF }}](../concepts/settings-list.md#cluster-settings) in the cluster update command (not all settings are shown in the example):

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --compression-type <compression_type> \
         --log-flush-interval-messages <number_of_messages_in_log> \
         --log-flush-interval-ms <maximum_time_to_retain_messages_in_memory>
      ```

      Where:

      * `--log-flush-interval-messages`: Number of messages in the log to trigger flushing to disk.
      * `--log-flush-interval-ms`: Maximum time a message can be stored in memory before flushing to disk.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

   1. In the {{ mkf-name }} cluster description, modify the values of the parameters in the `kafka.kafka_config` section (the example does not contain an exhaustive list of the [settings](../concepts/settings-list.md#cluster-settings)):

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

- API {#api}

   To change {{ KF }} settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   * New values of [settings {{ KF }}](../concepts/settings-list.md#cluster-settings) in the parameter:
      * `configSpec.kafka.kafkaConfig_2_8` if you use {{ KF }} `2.8`;
      * `configSpec.kafka.kafkaConfig_3` if you are using {{ KF }} version `3.x`.

   * List of settings to update, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs group=instructions %}


- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a cluster:

   1. View a description of the CLI move cluster command:

      ```bash
      {{ yc-mdb-kf }} cluster move --help
      ```

   1. Specify the destination folder in the move cluster command:

      ```bash
      {{ yc-mdb-kf }} cluster move <cluster_ID> \
         --destination-folder-name=<destination_folder_name>
      ```

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

   To move a cluster, use the [move](../api-ref/Cluster/move.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Move](../api-ref/grpc/cluster_service.md#Move) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}


## Changing security groups {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. In the appropriate cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select security groups for cluster network traffic.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --security-group-ids <list_of_security_groups>
      ```

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

   1. Change the value of the `security_group_ids` parameter in the cluster description:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
        ...
        security_group_ids = [ <list_of_security_groups> ]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

   To update security groups, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   - Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   - List of security group IDs in the `securityGroupIds` parameter.
   - List of settings to update, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

