# Changing cluster settings


After creating an {{ KF }} cluster, you can:

* [{#T}](#change-resource-preset).
* [{#T}](#change-disk-size) (available only for `network-hdd` standard network storage and `network-ssd` fast network storage).
* [Change {{ KF }} settings](#change-kafka-settings).
* [Move the cluster](#move-cluster) from the current folder to another one.
* [Change cluster security groups](#change-sg-set).

## Change the class and number of hosts {#change-resource-preset}

You can change:

* {{ KF }} broker host class and number.
* {{ ZK }} hosts class.

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

    To change the [class and number of hosts](../concepts/instance-types.md) for the cluster:

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

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).


- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
  * The new cluster configuration in the `configSpec` parameter.

{% endlist %}

## Changing storage settings {#change-disk-size}

{% note warning %}

Currently, you can't change the disk type for the {{ KF }} cluster after creation.

{% endnote %}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Select the cluster and click **Edit** in the top panel.
  1. Change the storage size in the relevant section.
  1. Click **Save**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change storage settings for hosts:

  1. Make sure the required cluster uses standard or fast network storage (it's not possible to increase the size of local or non-replicated network storage). To do this, request information about the cluster and find the `disk_type_id` field: it should be set to `network-hdd` or `network-ssd`:

     ```
     {{ yc-mdb-kf }} cluster list
     {{ yc-mdb-kf }} cluster get <cluster name or ID>
     ```

  1. View a description of the CLI's update cluster command:

     ```
     {{ yc-mdb-kf }} cluster update --help
     ```

  1. To change the size of the broker host disks, run the command:

     ```
     {{ yc-mdb-kf }} cluster update <cluster name or ID> --disk-size <disk size>
     ```

     If no size units are specified, gigabytes are used.

  1. To change the size of the {{ ZK }} host disks, run the command:

     ```
     {{ yc-mdb-kf }} cluster update <cluster name or ID> \
     --zookeeper-disk-size <disk size>
     ```

     If no size units are specified, gigabytes are used.

- Terraform

    To increase the storage size for a cluster:

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

    For more information, see the [{{ TF }} provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).


- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  * The cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
  * The new cluster configuration in the `configSpec` parameter.

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

    To change the [cluster settings](../concepts/settings-list.md#cluster-settings):

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. In the {{ mkf-name }} cluster description, change the parameter values in the `kafka.kafka_config` section (not all the settings are listed in the example):

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

    2. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    3. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [Terraform provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).


- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
    - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
    - In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
    - New values of [{{ KF }} settings](../concepts/settings-list.md#cluster-settings) in the parameter:
        - `configSpec.kafka.kafkaConfig_2_1` if you use {{ KF }} `2.1`.
        - `configSpec.kafka.kafkaConfig_2_6` if you use {{ KF }} `2.6`.

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}


- API

  To move a cluster from the current folder to a different one, use the [move](../api-ref/Cluster/move.md) API method and pass the following in the request:
  * The cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * The ID of the destination folder in the `destinationFolderId` parameter.

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

    To change cluster security groups:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

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

    For more information, see the [Terraform provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

- API

  To edit the list of cluster [security groups](../concepts/network.md#security-groups), use the `update` API method and pass the following in the request:
  * The cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
  * The list of groups, in the `securityGroupIds` parameter.
  * The list of settings to update, in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up the security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

