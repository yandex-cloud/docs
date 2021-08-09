---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Changing cluster settings


After creating an {{ KF }} cluster, you can:

- [{#T}](#change-resource-preset).
- [{#T}](#change-disk-size) (available only for `network-hdd` standard network storage and `network-ssd` fast network storage).
- [Change {{ KF }} settings](#change-kafka-settings).
- [Move the cluster](#move-cluster) from the current folder to another one.
- [Change cluster security groups](#change-sg-set).

## Change the class and number of hosts {#change-resource-preset}

You can change:

- {{ KF }} broker host class and number.
- {{ ZK }} hosts class.

{% note warning %}

You can't decrease the number of {{ KF }} broker hosts.

{% endnote %}

{% list tabs %}


- Management console

  1. Go to the folder page and select **{{ mkf-name }}**.

  1. Select the cluster and click **Edit** in the top panel.

  1. Change the required settings:
     - To change the class of [broker hosts](../concepts/brokers.md), select a new [host class](../concepts/instance-types.md) in the corresponding section.
     - To change the number of broker hosts in each availability zone that was chosen when [creating a cluster](cluster-create.md#create-cluster), change the value of the corresponding setting.

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


- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
  - The new cluster configuration in the `configSpec` parameter.

{% endlist %}

## Changing storage settings {#change-disk-size}

{% note warning %}

Currently, you can't change the disk type for {{ KF }} clusters after creation.

{% endnote %}

{% list tabs %}


- Management console
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Select the cluster and click **Edit** in the top panel.
  1. To change storage settings, select the [storage type](../concepts/storage.md) and its size in the corresponding section.
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


- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
  - The new cluster configuration in the `configSpec` parameter.

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

    1. View a description of the CLI's update cluster settings command:

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
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

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

- API

  To edit the list of cluster [security groups](../concepts/network.md#security-groups), use the `update` API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
  - The list of groups in the `securityGroupIds` parameter.
  - The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

