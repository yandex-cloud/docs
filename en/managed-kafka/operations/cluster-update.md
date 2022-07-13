# Changing cluster settings

After creating an {{ KF }} cluster, you can:

* [{#T}](#enable-api).
* [{#T}](#change-resource-preset).
* [{#T}](#change-disk-size) (unavailable for non-replicated SSD [storage](../concepts/storage.md)).
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
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg), then **Edit cluster**.
   1. Enable **Manage topics via the API**.
   1. [Create an administrator account](./cluster-accounts.md#create-account).

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To enable topic management via the Admin API:

   1. Run the command:

      ```
      {{ yc-mdb-kf }} cluster update <cluster name or ID> --unmanaged-topics=true
      ```

   1. [Create an administrator account](./cluster-accounts.md#create-account).

- Terraform

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

   1. [Create an administrator account](./cluster-accounts.md#create-account).


- API

   To enable topic management via the Admin API:

   1. Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

      * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
      * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
      * The new cluster configuration in the `configSpec` parameter. Specify the value `"unmanagedTopics": true` in the configuration.

   1. [Create an administrator account](./cluster-accounts.md#create-account).


{% endlist %}

## Change the class and number of hosts {#change-resource-preset}

You can change:
* The {{ KF }} broker host class and number.
* The class of {{ ZK }} hosts.

{% note warning %}

You can't decrease the number of {{ KF }} broker hosts.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg), then **Edit cluster**.
   1. Change the required settings:
      * To edit the [broker host](../concepts/brokers.md) class, select a new [**Host class**](../concepts/instance-types.md).
      * Edit the **Number of brokers in zone**.

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the class and number of hosts:

   1. Get information about the cluster:

      ```
      {{ yc-mdb-kf }} cluster list
      {{ yc-mdb-kf }} cluster get <cluster ID or name>
      ```

   1. View a description of the CLI's update cluster command:

      ```
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. To increase the number of broker hosts, run the command:

      ```
      {{ yc-mdb-kf }} cluster update <cluster name or ID> --brokers-count <number>
      ```

   1. To change the broker host class, run the command:

      ```
      {{ yc-mdb-kf }} cluster update <cluster name or ID> --resource-preset <host class>
      ```

   1. To change the {{ ZK }} host class, run the command:

      ```
      {{ yc-mdb-kf }} cluster update <cluster ID or name> \
        --zookeeper-resource-preset <host class>
      ```

- Terraform

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

   1. In the {{ mkf-name }} cluster description, change the `resource_preset_id` parameter in the `kafka.resources` and `zookeeper.resources` sections for the {{ KF }} and {{ ZK }} hosts, respectively:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        kafka {
          resources {
            resource_preset_id = "<class of Apache Kafka hosts>"
            ...
          }
        }
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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
   * The new cluster configuration in the `configSpec` parameter.


{% endlist %}

## Increasing storage size {#change-disk-size}

{% note warning %}

You can't change the disk type for {{ KF }} clusters after creation.

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To increase a cluster's storage size:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg), then **Edit cluster**.
   1. Edit the settings in the **Storage** section.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase the hosts' storage size:

   1. View a description of the CLI's update cluster command:

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

- Terraform

   To increase a cluster's storage size

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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   To increase a cluster's storage size, use the API [update](../api-ref/Cluster/update.md) method and pass in in the call:
   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
   * The new cluster configuration in the `configSpec` parameter.


{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg), then **Edit cluster**.
   1. Change additional cluster settings:

      {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. Run the command with a list of settings to update:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster name or ID> \
         --maintenance-window type=<maintenance type: anytime or weekly>,`
                             `day=<day of week for weekly>,`
                             `hour=<hour for weekly>
         --deletion-protection=<protect cluster from deletion: true or false>
      ```

   You can change the following settings:

   * {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window.md) %}

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [[deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

   You can find out the cluster ID and name in a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. {% include [maintenance-window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mkf }}).

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter.

   * {% include [maintenance-window](../../_includes/mdb/api/maintenance-window.md) %}

   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

   * List of cluster configuration fields to be changed in the `updateMask` parameter.

   You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

   {% note warning %}

   This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, be sure to pass the names of the fields to be changed in the `updateMask` parameter.

   {% endnote %}

{% endlist %}

## Changing {{ KF }} settings {#change-kafka-settings}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg), then **Edit cluster**.
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

- Terraform

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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [Terraform provider documentation]({{ tf-provider-link }}/mdb_kafka_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
   * New values of [settings {{ KF }}](../concepts/settings-list.md#cluster-settings) in the parameter:
      * `configSpec.kafka.kafkaConfig_2_8` if you use {{ KF }} `2.8`;
      * `configSpec.kafka.kafkaConfig_3_0` if you are using {{ KF }} version `3.0`.


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

   Use the [move](../api-ref/Cluster/move.md) API method and pass the following in the query:
   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
   1. In the row next to the appropriate cluster, click ![image](../../_assets/horizontal-ellipsis.svg), then **Edit cluster**.
   1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the CLI's update cluster command:

      ```
      {{ yc-mdb-kf }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```
      {{ yc-mdb-kf }} cluster update <cluster name> \
         --security-group-ids <security group list>
      ```

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Change the value of the `security_group_ids` parameter in the cluster description:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        security_group_ids  = ["<list of cluster security group IDs>"]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [Terraform provider documentation]({{ tf-provider-link }}/mdb_kafka_cluster).

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
   - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   - The list of groups in the `securityGroupIds` parameter.
   - The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
