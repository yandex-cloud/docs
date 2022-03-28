# Changing cluster settings

{% if api != "noshow" %}

After creating an {{ KF }} cluster, you can:

* [{#T}](#change-resource-preset).
* [{#T}](#change-disk-size) (only available for [storage types](../concepts/storage.md) `network-hdd` and `network-ssd`).
* [Update the {{ KF }} settings](#change-kafka-settings).
* [Move the cluster](#move-cluster) from the current folder to another one.
* [Change cluster security groups](#change-sg-set).

{% else %}

After creating an {{ KF }} cluster, you can:

* [{#T}](#change-resource-preset).
* [{#T}](#change-disk-size).
* [Update the {{ KF }} settings](#change-kafka-settings).

{% endif %}

## Change the class and number of hosts {#change-resource-preset}

You can change:
* The {{ KF }} broker host class and number.
* The class of {{ ZK }} hosts.

{% note warning %}

You can't decrease the number of {{ KF }} broker hosts.

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Select the cluster and click **Edit** in the top panel.
  1. Change the required settings:
     * To change the class of [broker hosts](../concepts/brokers.md), select a new [host class](../concepts/instance-types.md) in the corresponding section.
     * To change the number of broker hosts in each availability zone that was chosen when [creating a cluster](cluster-create.md#create-cluster), change the value of the corresponding setting.

  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the class and number of hosts:

  1. Get information about the cluster:

     ```
     {{ yc-mdb-kf }} cluster list
     {{ yc-mdb-kf }} cluster get <cluster name or ID>
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
     {{ yc-mdb-kf }} cluster update <cluster name or ID> \
     --zookeeper-resource-preset <host class>
     ```

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, change the `brokers_count` parameter to increase the number of broker hosts:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster name>" {
          config {
            brokers_count  = <number of broker hosts>
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
              resource_preset_id = "<class of {{ ZK }} hosts>"
              ...
            }
          }
         }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mkf }}).

{% if api != "noshow" %}

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
  * The new cluster configuration in the `configSpec` parameter.

{% endif %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% note warning %}

You can't change the disk type for {{ KF }} clusters after creation.

{% endnote %}

{% include [storage type check](../../_includes/mdb/note-change-disk-size.md) %}

{% list tabs %}

- Management console

  To increase the storage size for a cluster:

  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Select the cluster and click **Edit** in the top panel.
  1. Change the storage size in the relevant section.
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the storage size for a cluster:

  1. View a description of the CLI's update cluster command:

     ```bash
     {{ yc-mdb-kf }} cluster update --help
     ```

  1. To change the size of the broker host storage, run the command:

     ```bash
     {{ yc-mdb-kf }} cluster update <cluster name or ID> \
        --disk-size <storage size>
     ```

     If no size units are specified, gigabytes are used.

  1. To change the size of the {{ ZK }} host storage, run the command:

     ```bash
     {{ yc-mdb-kf }} cluster update <cluster name or ID> \
     --zookeeper-disk-size <disk size>
     ```

     If no size units are specified, gigabytes are used.

- Terraform

  Increasing the storage size for a cluster

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

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

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mkf }}).

{% if api != "noshow" %}

- API

  To increase the storage size for a cluster, use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
  * The new cluster configuration in the `configSpec` parameter.

{% endif %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mkf-name }}**.
    1. Select the cluster and click **Edit** in the top panel.
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

    1. To protect a cluster from accidental deletion by a user of your cloud, set `--deletion-protection` to `true`:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster name or ID> \
           ...
           --deletion-protection=true
        ```

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

    You can get the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

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

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mkf }}).

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

    * The cluster ID in the `clusterId` parameter.
    * Cluster deletion protection settings in the `deletionProtection` parameter.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

    * List of cluster configuration fields to be changed in the `updateMask` parameter.

    You can get the cluster ID with a [list of clusters in a folder ](./cluster-list.md#list-clusters).

    {% note warning %}

    This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, pass the names of the fields to be changed in the `updateMask` parameter.

    {% endnote %}

{% endlist %}

## Changing {{ KF }} settings {#change-kafka-settings}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mkf-name }}**.
    1. Select the cluster and click **Edit** in the top panel.
    1. Change the {{ KF }} settings by clicking **Configure** under **DBMS settings**:

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

    1. Change [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) in the cluster update command (not all settings are shown in the example):

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster name> \
           --compression-type <compression type> \
           --log-flush-interval-messages <number of messages in the log to trigger flushing to disk> \
           --log-flush-interval-ms <maximum time a message can be stored in memory before flushing to disk>
        ```

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, modify the values of the parameters in the `kafka.kafka_config` section (the example does not contain an exhaustive list of the [settings](../concepts/settings-list.md#cluster-settings)):

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster name>" {
          ...
          config {
            kafka {
              ...
              kafka_config {
                compression_type            = "<compression type>"
                log_flush_interval_messages  = <maximum number of messages in memory>
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

    For more information, see the [Terraform provider documentation]({{ tf-provider-mkf }}).

{% if api != "noshow" %}

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
    * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
    * New values of [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) in the parameter:
        * `configSpec.kafka.kafkaConfig_2_1` if you use {{ KF }} `2.1`.
        * `configSpec.kafka.kafkaConfig_2_6` if you use {{ KF }} `2.6`.
        * `configSpec.kafka.kafkaConfig_2_8` if you use {{ KF }} `2.8`.

{% endif %}

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}

{% if api != "noshow" %}

- API

  Use the API [move](../api-ref/Cluster/move.md) method and pass the following in the call:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * The ID of the destination folder in the `destinationFolderId` parameter.

{% endif %}

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

  1. View a description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-kf }} cluster update --help
      ```

  1. Specify the security groups in the update cluster command:

      ```
      $ {{ yc-mdb-kf }} cluster update <cluster name>
           --security-group-ids <list of security groups>
      ```

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create such a file, see [{#T}](cluster-create.md).

    1. Change the value of the `security_group_ids` parameter in the cluster description:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster name>" {
          ...
          security_group_ids = [ <list of IDs of cluster security groups> ]
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [Terraform provider documentation]({{ tf-provider-mkf }}).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
  * The list of groups in the `securityGroupIds` parameter.
  * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
