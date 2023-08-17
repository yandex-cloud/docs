# Changing {{ KF }} cluster settings

After creating an {{ mkf-name }} cluster, you can:

* [{#T}](#enable-api).
* [{#T}](#change-brokers).
* [{#T}](#change-zookeeper).
* [{#T}](#change-disk-size) (unavailable for non-replicated SSD [storage](../concepts/storage.md)).
* [{#T}](#change-additional-settings).
* [{#T}](#change-kafka-settings).
* [{#T}](#move-cluster) from the current folder to another one.
* [{#T}](#change-sg-set).

## Enabling user and topic management using the Admin API {#enable-api}

{% note info %}

It is impossible to disable the enabled topic management via the {{ KF }} Admin API.

{% endnote %}

To [manage topics via the {{ KF }} Admin API](../concepts/topics.md#management):

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit cluster**.
   1. Enable **Manage topics via the API**.
   1. [Create an admin user](./cluster-accounts.md#create-user).

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To enable topic management via the Admin API:

   1. Run this command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster name or ID> --unmanaged-topics=true
      ```

   1. [Create an admin user](./cluster-accounts.md#create-user).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Change the value of the `unmanaged_topics` parameter in the description of a {{ mkf-name }} cluster to enable topic management via the Admin API:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        config {
          unmanaged_topics = true
          ...
        }
        ...
      }
      ```

   1. [Create an admin user](./cluster-accounts.md#create-user).

- API

   To enable topic management via the Admin API:

   1. Use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
      * New cluster configuration in the `configSpec` parameter. Set `unmanagedTopics` to `true` in the configuration.
      * List of cluster configuration fields to update in the `UpdateMask` parameter.

      {% include [Node API updateMask](../../_includes/note-api-updatemask.md) %}

   1. [Create an admin user](./cluster-accounts.md#create-user).

{% endlist %}

## Changing the broker host class and number {#change-brokers}

You cannot increase the number of {{ KF }} broker hosts unless a cluster includes at least two broker hosts in different availability zones. You cannot have fewer broker hosts. To meet the cluster [fault tolerance conditions](../concepts/index.md#fault-tolerance), you need at least three broker hosts.

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit cluster**.
   1. Change the required settings:
      * To edit the [broker host](../concepts/brokers.md) class, select a new [**Host class**](../concepts/instance-types.md).
      * Edit the **Number of brokers in zone**.

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the class and number of hosts:

   1. Get information about the cluster:

      ```bash
      {{ yc-mdb-kf }} cluster list
      {{ yc-mdb-kf }} cluster get <cluster ID or name>
      ```

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. To increase the number of broker hosts, run the command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster name or ID> --brokers-count <number>
      ```

   1. To change the broker host class, run the command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster name or ID> --resource-preset <host class>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mkf-name }} cluster description, change the `brokers_count` parameter to increase the number of broker hosts:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        config {
          brokers_count = <number of broker hosts>
          ...
        }
        ...
      }
      ```

   1. In the {{ mkf-name }} cluster description, edit the value of the `resource_preset_id` parameter under `kafka.resources` to specify a new broker host class:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        kafka {
          resources {
            resource_preset_id = "<broker host class>"
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

   To change the class and number of broker hosts, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Broker host class in the `configSpec.kafka.resources.resourcePresetId` parameter.
   * Number of broker hosts in the `configSpec.brokersCount` parameter.
   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing the {{ ZK }} host class {#change-zookeeper}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit cluster**.
   1. Select a new [**Zookeeper host class**](../concepts/instance-types.md).
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the class of {{ ZK }} hosts:

   1. Get information about the cluster:

      ```bash
      {{ yc-mdb-kf }} cluster list
      {{ yc-mdb-kf }} cluster get <cluster ID or name>
      ```

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. To change the {{ ZK }} host class, run this command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster ID or name> \
        --zookeeper-resource-preset <host class>
      ```

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mkf-name }} cluster description, edit the value of the `resource_preset_id` parameter under `zookeeper.resources` to specify a new {{ ZK }} host class:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        zookeeper {
          resources {
            resource_preset_id = "<{{ ZK }} host class>"
            ...
          }
        }
       }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

   To change the class of {{ ZK }} hosts, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * {{ ZK }} host class in the `configSpec.zookeeper.resources.resourcePresetId` parameter.
   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% note warning %}

You cannot change the disk type for an {{ KF }} cluster once you create it.

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To increase the cluster storage size:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit cluster**.
   1. Edit the settings in the **Storage** section.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase the hosts' storage size:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. To change the size of the broker host storage, run the command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster ID or name> \
        --disk-size <storage size>
      ```

      If no size units are specified, gigabytes are used.

   1. To change the size of the {{ ZK }} host storage, run the command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster ID or name> \
        --zookeeper-disk-size <disk size>
      ```

      If no size units are specified, gigabytes are used.

- {{ TF }}

   To increase the cluster storage size

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mkf-name }} cluster description, change the `disk_size` parameter in the `kafka.resources` and `zookeeper.resources` sections for the {{ KF }} and {{ ZK }} hosts, respectively:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        kafka {
          resources {
            disk_size = <storage size in GB>
            ...
          }
          ...
        }
        zookeeper {
          resources {
            disk_size = <storage size in GB>
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

   To increase the cluster storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New storage settings in the `configSpec.kafka.resources` parameter (`configSpec.zookeeper.resources` for {{ ZK }} hosts).
   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


## Updating security group and public access settings {#change-sg-set}

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit cluster**.
   1. Under **Network settings**, select security groups for cluster network traffic.
   1. Enable or disable public access to a cluster via the **Public access** option.
   1. Click **Save**.

   [Restart the cluster](./cluster-stop.md) for the new public access settings to take effect.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. Specify the security groups and public access settings in the update cluster command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster name> \
         --security-group-ids <security group list> \
         --assign-public-ip=<cluster public access: true or false>
      ```

   [Restart the cluster](./cluster-stop.md) for the new public access settings to take effect.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Change the values of the `security_group_ids` and `assign_public_ip` parameters in the cluster description:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        security_group_ids = [ <list of cluster security group IDs> ]
        ...
        config {
          assign_public_ip = "<cluster public access: true or false>"
          ...
          }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   [Restart the cluster](./cluster-stop.md) for the new public access settings to take effect.

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

   To change the security group and public access settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   - Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   - List of security group IDs in the `securityGroupIds` parameter.
   - Public access settings, in the `configSpec.assignPublicIp` parameter.
   - List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

   [Restart the cluster](./cluster-stop.md) for the new public access settings to take effect.

{% endlist %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.


## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit cluster**.
   1. Change additional cluster settings:

      {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. Run the following command with a list of settings to update:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster name or ID> \
         --maintenance-window type=<maintenance type: anytime or weekly>,`
                             `day=<day of week for weekly>,`
                             `hour=<hour for weekly> \
         --datatransfer-access=<true or false> \
         --deletion-protection=<protect cluster from deletion: true or false>
      ```

   You can change the following settings:

   * `--maintenance-window`: Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters):

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

   * {% include [datatransfer access](../../_includes/mdb/cli/datatransfer-access-update.md) %}

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [Deletion protection](../../_includes/mdb/deletion-protection-limits-data.md) %}

   You can find out the cluster ID and name in the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [Deletion protection](../../_includes/mdb/deletion-protection-limits-data.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mkf }}).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

   To change additional cluster settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).

   * Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters) in the `maintenanceWindow` parameter.

   * Cluster access configuration settings for [{{ data-transfer-full-name }}](../../data-transfer/) in Serverless mode: in the `configSpec.access.dataTransfer` parameter.

      This enables you to connect to {{ data-transfer-full-name }} running in {{ k8s }} via a special network. It will also cause other operations to run faster, such as transfer launch and deactivation.

   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Deletion protection](../../_includes/mdb/deletion-protection-limits-data.md) %}

   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ KF }} settings {#change-kafka-settings}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit cluster**.
   1. Under **Kafka Settings**, click **Configure**.

      For more information, see [{{ KF }} settings](../concepts/settings-list.md).

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change {{ KF }} settings:

   1. View a description of the CLI update cluster settings command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. Change [settings {{ KF }}](../concepts/settings-list.md#cluster-settings) in the cluster update command (not all settings are shown in the example):

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster ID or name> \
         --compression-type <compression type> \
         --log-flush-interval-messages <number of messages in log before flushing to disk> \
         --log-flush-interval-ms <maximum time to retain messages in memory before flushing to disk>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mkf-name }} cluster description, modify the values of the parameters in the `kafka.kafka_config` section (the example does not contain an exhaustive list of the [settings](../concepts/settings-list.md#cluster-settings)):

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        config {
          kafka {
            ...
            kafka_config {
              compression_type            = "<compression type>"
              log_flush_interval_messages = <maximum number of messages in memory>
              ...
            }
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

   To change {{ KF }} settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   * New values of [settings {{ KF }}](../concepts/settings-list.md#cluster-settings) in the parameter:
      * `configSpec.kafka.kafkaConfig_2_8` if you use {{ KF }} `2.8`;
      * `configSpec.kafka.kafkaConfig_3` if you are using {{ KF }} version `3.x`.

   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}


- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a cluster:

   1. View a description of the CLI move cluster command:

      ```bash
      {{ yc-mdb-kf }} cluster move --help
      ```

   1. Specify the destination folder in the move cluster command:

      ```bash
      {{ yc-mdb-kf }} cluster move <cluster ID> \
         --destination-folder-name=<destination folder name>
      ```

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To move a cluster, use the [move](../api-ref/Cluster/move.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Move](../api-ref/grpc/cluster_service.md#Move) gRPC API call and provide the following in the request:
   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}


## Changing security groups {#change-sg-set}

{% include [security-groups-note-services](../../_includes/vpc/security-groups-note-services.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg), then **Edit cluster**.
   1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster name> \
         --security-group-ids <security group list>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Change the value of the `security_group_ids` parameter in the cluster description:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        security_group_ids = ["<list of cluster security group IDs>"]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

   To update security groups, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   - Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   - List of security group IDs in the `securityGroupIds` parameter.
   - List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

