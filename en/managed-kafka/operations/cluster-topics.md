# Working with topics and partitions

In {{ mkf-name }} clusters, you can:

- [Create topics and their partitions](#create-topic).
- [Update topic and partition settings](#update-topic).
- [Delete topics](#delete-topic).
- [Get a list of topics in a cluster](#list-topics).
- [Get detailed information about a topic](#get-topic).

## Create a topic {#create-topic}

{% list tabs %}

- Management console

  To create a topic, follow these steps:

  1. Go to the folder page and select **{{ mkf-name }}**.

  1. Click the name of the cluster and go to the **Topics** tab.

  1. Click **Create topic**.

  1. Under **Basic parameters**, set the basic parameters of the topic:
     - The topic name (must be unique in the {{ KF }} cluster).
     - The number of topic partitions.
     - The replication factor. This parameter value should not exceed the number of brokers in the cluster. Minimum value: `1`. Default:
       - For a cluster with one or two brokers: `1`.
       - For a cluster with three or more brokers: `3`.
  1. Under **Topic settings**, specify the [topic settings](#topic-extra-settings).
  1. Click **Create**.


- API

  Use the [create](../api-ref/Topic/create.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where you want to create a topic. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Topic settings in the `topicSpec` parameter.

{% endlist %}

## Update topic settings {#update-topic}

{% note warning %}

The number of {{ KF }} topic partitions can only be increased.

{% endnote %}

{% list tabs %}

- Management console

  To change topic settings, follow these steps:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click on the name of the cluster and select the **Topics** tab.
  1. Click ![image](../../_assets/options.svg) for the necessary topic and select **Edit**.
  1. Change the basic parameters of the topic:
     - The number of topic partitions.
     - The replication factor. This parameter value should not exceed the number of brokers in the cluster. Minimum value: `1`. Default:
       - For a cluster with one or two brokers: `1`.
       - For a cluster with three or more brokers: `3`.
  1. Change the [topic settings](#topic-extra-settings).
  1. Click **Save**.


- API

  Use the [update](../api-ref/Topic/update.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the topic is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The topic name in the `topicName` parameter. To find out the name, [get a list of topics in the cluster](#list-topics).
  - In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any topic settings that aren't explicitly specified in the request to their default values.
  - New values for the topic settings in the `topicSpec` parameter.

{% endlist %}

## Delete a topic {#delete-topic}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs %}

- Management console

  To delete a topic, follow these steps:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Topics** tab.
  1. Click ![image](../../_assets/options.svg) for the necessary topic and select **Delete topic**.
  1. Confirm topic deletion and click **Delete**.


- API

  Use the [delete](../api-ref/Topic/delete.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the topic is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The topic name in the `topicName` parameter. To find out the name, [get a list of topics in the cluster](#list-topics).

{% endlist %}

## Get a list of topics in a cluster {#list-topics}

{% list tabs %}

- Management console

  To get a list of topics, follow these steps:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Topics** tab.


- API

  Use the [list](../api-ref/Topic/list.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Get detailed information about a topic {#get-topic}

{% list tabs %}

- Management console

  To get detailed information about a topic, follow these steps:
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click the name of the cluster and go to the **Topics** tab.
  1. Click on the name of the topic.


- API

  To get detailed information about a topic, use the [get](../api-ref/Topic/get.md) API method and pass the following in the request:
  - In the `clusterId` parameter, the ID of the cluster where the topic is located. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The topic name in the `topicName` parameter. To find out the name, [get a list of topics in the cluster](#list-topics).

{% endlist %}

## Additional topic settings {#topic-extra-settings}

These settings specify various topic parameters:

- **Cleanup policy**:
    - `Delete`: Delete log segments when either their retention time or log size limit is reached.
    - `Compact`: Compact messages in the log.
    - `CompactAndDelete`: Both compact messages and delete log segments.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#cleanup.policy).

- **Compression type**: The codec to use for message compression:
    - `Uncompressed`: No compression.
    - `Zstd`: The Zstandard codec.
    - `Lz4`: The LZ4 codec.
    - `Snappy`: The Snappy codec.
    - `Gzip`: The GZip codec.
    - `Producer`: The codec is set by the [producer](../concepts/producers-consumers.md).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#compression.type).

- **Delete retention, ms**: The amount of time in milliseconds to retain delete tombstone markers for log compacted topics. You can see this parameter only when you select the `Compact` and `CompactAndDelete` cleanup policies.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#retention.ms).

- **Delete delay, ms**: The time to wait before deleting a file from the filesystem.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#file.delete.delay.ms).

- **Maximum number of messages in memory**: The number of topic messages that can be kept in memory before these messages are flushed to disk. For example, if the parameter is `1`, the disk is flushed after each message is received. If it's set to `5`, messages are flushed to disk in groups of five.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#flush.messages).

- **Message retention time, ms**: The time that a message in any topic is kept in memory before it's flushed to disk.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#flush.ms).

- **Minimum compaction lag, ms**: The minimum time a message will remain uncompacted in the log.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#min.compaction.lag.ms).

- **Maximum partition size, bytes**: The maximum size that a partition can grow to. After reaching this size, {{ KF }} starts deleting old log segments. This setting applies if the `Delete` log cleanup policy is in effect.

    It's helpful if you need to control the size of a log due to limited disk space.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#retention.bytes).

- **Log segment lifetime, ms**: The time after which {{ KF }} starts deleting old log segments. This setting applies if the `Delete` log cleanup policy is in effect.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#retention.ms).

- **Maximum batch size**: The maximum batch size of messages that {{ KF }} allows you to write to a topic to the producer or read from a topic to the consumer (in bytes, after compression, if enabled).

    Minimum value: `0` (default: `1,048,588`, 1 MB).

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#retention.bytes).

- **Minimum number of in-sync replicas**: The minimum number of replicas to wait for record confirmation from in order to consider a message successfully written to a topic. This setting is useful when the broker is waiting for record confirmation from all replicas in the cluster.

    Minimum value: `1`. Default:
    - For a cluster with one or two brokers: `1`.
    - For a cluster with three or more brokers: `2`.

    For more information, see the [documentation for {{ KF }}](https://kafka.apache.org/documentation/#min.insync.replicas).
