---
title: "Monitoring the state of {{ KF }} clusters and hosts"
description: "In this tutorial, you'll learn how to monitor the state of {{ KF }} cluster and hosts"
---

# Monitoring the state of {{ KF }} clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-freq](../../_includes/mdb/monitoring-freq.md) %}

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mkf-name }} cluster status:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click on the name of the cluster and open the **Monitoring** tab.

   1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

   The page displays the following charts:

   * **Alive brokers**: Number of functional brokers for each host with the `KAFKA` role.
   * **Bytes In/Out**: Write and message read speed for each host with the `KAFKA` role (bytes per second).
   * **Errors**: Number of failed requests by error type.
   * **Free space**: Free disk space for each host with the `KAFKA` role (in bytes).
   * **Messages in**: Message write rate (messages per second).
   * **Offline partitions**: Displays the parameter values below:
      * `OfflineReplicaCount`: Number of partitions without a leader. These partitions do not support message writes or reads.
      * `Underreplicated partitions`: Number of partitions whose replication factor is greater than the number of their in-sync replicas (ISRs).
      * `Under min ISR partitions`: Number of partitions with a number of in-sync replicas below the minimum allowed value specified in the [settings](../concepts/settings-list.md).
   * **Replicas**: Total number of partition replicas.
   * **Replicated bytes**: Replication data streaming rate for each host with the `KAFKA` role (bytes per second).
   * **Replication lag**: Greatest replication lag for each host with the `KAFKA` role (messages).
   * **Request time (0.95 quantile)**: Request processing time in the 0.95 quantile by request type.
   * **Requests**: Request rate by request type (requests per second).
   * **Top 5 topics by size**: Amount of data for each of the 5 largest topics (bytes).

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mkf-name }} hosts:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click the name of the desired cluster and select **Hosts** → **Monitoring**.
   1. Select the host from the drop-down list.

   This page displays charts showing the load on an individual host in the cluster:

   * **CPU**: The load on processor cores. As the load goes up, the `Idle` value goes down.
   * **Disk bytes**: The speed of disk operations (bytes per second).
   * **Disk IOPS**: The number of disk operations per second.
   * **Memory**: The use of RAM in bytes. At high loads, the value of `Free` goes down while the other values go up.
   * **Network Bytes**: The speed of data exchange over the network (bytes per second).
   * **Network Packets**: The number of packets exchanged over the network per second.

{% endlist %}

{% if audience != "internal" %}

## Alert settings in {{ monitoring-full-name }} {#monitoring-integration}

To configure [cluster](#monitoring-cluster) and [host](#monitoring-hosts) status metric alerts:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you wish to configure alerts for.
   1. In the list of services, select ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
   1. Under **Service dashboards**, select **{{ mkf-name }} — Cluster Overview**.
   1. In the desired chart, click ![options](../../_assets/horizontal-ellipsis.svg) and select **Create alert**.
   1. If there are multiple metrics on a chart, select a data query to generate a metric and click **Continue**. For more information about the query language, see the [{{ monitoring-full-name }} documentation](../../monitoring/concepts/querying.md).
   1. Set the `Alarm` and `Warning` threshold values to trigger the alert.
   1. Click **Create alert**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Recommended threshold values:

| Metric | Parameter | `Alarm` | `Warning` |
|------------------------------------|---------------------------------------------------------|----------------------------|----------------------------|
| Number of healthy hosts | `kafka_is_alive` | `<number of hosts> - 2` | `<number of hosts> - 1` |
| Partition replication status | `kafka_server_ReplicaManager_UnderReplicatedPartitions` | — | `Greater than 0` |
| Number of lagging replicas | `kafka_server_ReplicaManager_UnderMinIsrPartitionCount` | `Greater than 0` | — |
| Storage space used | `disk.used_bytes` | `90% of storage size` | `80% of storage size` |

You can view the current storage size in [detailed information about the cluster](cluster-list.md#get-cluster).

For a complete list of supported metrics, see the [{{ monitoring-name }} documentation](../../monitoring/metrics-ref/index.md#managed-kafka).

{% endif %}

## Cluster state and status {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

To view a cluster's state and status:

1. Go to the [folder page]({{ link-console-main }}) and select **{{ mkf-name }}**.
1. Hover over the indicator in the **Availability** column in the row of the cluster you need.

### Cluster states {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Cluster statuses {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% if audience == "internal" %}

## Solomon metrics {#solomon}

Here are the descriptions of the {{ mkf-name }} metrics that are automatically collected in Solomon.

The name of the metric is written in the `name` label.

{% cut "Labels shared by all metrics of the service" %}

| Label | Value |
----|----
| service | Service ID: `managed-kafka` |
| resource_type | Resource type: `cluster` |
| resource_id | Cluster ID |
| host | Host FQDN |
| node | Broker type: `leader`, `follower`, and `replica` |
| subcluster_name | Subcluster type: `zookeeper_subcluster`, `kafka_subcluster` |

{% endcut %}

{% cut "CPU metrics" %}

The load on processor cores.

{% include [CPU metrics](../../_includes/mdb/internal/metrics-cpu.md) %}

{% endcut %}

{% cut "Disk metrics" %}

{% include [Disk metrics](../../_includes/mdb/internal/metrics-disk.md) %}

{% endcut %}

{% cut "Disk operation metrics" %}

{% include [Disk IO metrics](../../_includes/mdb/internal/metrics-disk-io.md) %}

{% endcut %}

{% cut "RAM metrics" %}

{% include [RAM metrics](../../_includes/mdb/internal/metrics-ram.md) %}

{% endcut %}

{% cut "Network metrics" %}

{% include [Network metrics](../../_includes/mdb/internal/metrics-network.md) %}

{% endcut %}

{% cut "Service metrics" %}

| Name<br/>Type, units | Description |
| ----- | ----- |
| `kafka_controller_ControllerStats_LeaderElectionRateAndTimeMs`<br/>`DGAUGE`, ms | Leader broker change per unit of time, shows 0 if normal The value may increase under maintenance, which doesn't indicate a problem.<br/>Additional labels: `quantile` |
| `kafka_controller_KafkaController_ActiveControllerCount`<br/>`DGAUGE`, pcs | Number of active controllers. |
| `kafka_controller_KafkaController_GlobalTopicCount`<br/>`DGAUGE`, pcs | Number of topics. |
| `kafka_controller_KafkaController_OfflinePartitionsCount`<br/>`DGAUGE`, pcs | Number of offline partitions. |
| `kafka_controller_KafkaController_PreferredReplicaImbalanceCount`<br/>`DGAUGE`, pcs | Imbalance indicator in the desired allocation of replicas, shows `0` if normal. |
| `kafka_group_topic_partition_lag`<br/>`DGAUGE`, pcs | Message lag: Difference between the offset and total number of messages in the partition. |
| `kafka_group_topic_partition_offset`<br/>`DGAUGE`, pcs | Partition offset. |
| `kafka_host_count`<br/>`DGAUGE`, pcs | Number of hosts in the cluster. |
| `kafka_is_alive`<br/>`DGAUGE`, 0/1 | Broker health indicator.<br/>`1` if a broker is alive, `0` if not. |
| `kafka_network_RequestChannel_RequestQueueSize`<br/>`DGAUGE`, pcs | Requests enqueued. |
| `kafka_network_RequestMetrics_Errors`<br/>`DGAUGE`, pcs | Number of errors.<br/>Additional labels: `request` |
| `kafka_network_RequestMetrics_LocalTimeMs`<br/>`DGAUGE`, ms | The time it takes the leader broker to process a request.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_MessageConversionsTimeMs`<br/>`DGAUGE`, ms | Message format conversion time.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_RemoteTimeMs`<br/>`DGAUGE`, ms | Follower broker waiting time.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_RequestQueueTimeMs`<br/>`DGAUGE`, ms | Waiting time in the request queue.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_Requests`<br/>`DGAUGE`, pcs | Number of requests.<br/>Additional labels: `request` |
| `kafka_network_RequestMetrics_ResponseQueueTimeMs`<br/>`DGAUGE`, ms | Waiting time in the response queue.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_ResponseSendTimeMs`<br/>`DGAUGE`, ms | Response send time.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_RequestMetrics_TotalTimeMs`<br/>`DGAUGE`, ms | Total request execution time.<br/>Additional labels: `request`, `quantile` |
| `kafka_network_SocketServer_NetworkProcessorAvgIdlePercent`<br/>`DGAUGE`, % | Network processor average idle value. Ranges from `0` (all resources are utilized) to `1` (all resources are free). |
| `kafka_server_BrokerTopicMetrics_BytesIn`<br/>`DGAUGE`, bytes | Input data size. |
| `kafka_server_BrokerTopicMetrics_BytesOut`<br/>`DGAUGE`, bytes | Output data size. |
| `kafka_server_BrokerTopicMetrics_FailedFetchRequests`<br/>`DGAUGE`, pcs | Number of failed incoming requests. |
| `kafka_server_BrokerTopicMetrics_FailedProduceRequests`<br/>`DGAUGE`, pcs | Number of requests that failed to be handled. |
| `kafka_server_BrokerTopicMetrics_MessagesIn`<br/>`DGAUGE`, pcs | Number of messages written. |
| `kafka_server_BrokerTopicMetrics_ReplicationBytesIn`<br/>`DGAUGE`, bytes | Replicated data size. |
| `kafka_server_KafkaRequestHandlerPool_RequestHandlerAvgIdlePercent_count`<br/>`DGAUGE`, % | Request handler average idle value. Ranges from `0` (all resources are utilized) to `1` (all resources are free). |
| `kafka_server_KafkaServer_BrokerState`<br/>`DGAUGE` | Broker state:<br/>0: `Not Running`<br/>1: `Starting`<br/>2: `Recovering from Unclean Shutdown`<br/>3: `Running as Broker`<br/>4: `Running as Controller`<br/>5: `Pending Controlled ShutdownStates`<br/>6: `Broker Shutting Down` |
| `kafka_server_ReplicaFetcherManager_MaxLag`<br/>`DGAUGE`, pcs | Maximum lag of message replication between the follower and leader brokers.<br/>Additional labels: `clientId` |
| `kafka_server_ReplicaManager_LeaderCount`<br/>`DGAUGE`, pcs | Number of partitions with a leader broker. |
| `kafka_server_ReplicaManager_OfflineReplicaCount`<br/>`DGAUGE`, pcs | Number of partitions without a leader. These partitions do not support message writes or reads. |
| `kafka_server_ReplicaManager_PartitionCount`<br/>`DGAUGE`, pcs | Number of partitions for a broker. |
| `kafka_server_ReplicaManager_ReassigningPartitions`<br/>`DGAUGE`, pcs | Number of partitions with the leader being reassigned. |
| `kafka_server_ReplicaManager_UnderMinIsrPartitionCount`<br/>`DGAUGE`, pcs | Number of partitions with a number of in-sync replicas below the minimum allowed value specified in the settings. |
| `kafka_server_ReplicaManager_UnderReplicatedPartitions`<br/>`DGAUGE`, pcs | Number of partitions whose replication factor is greater than the number of their in-sync replicas (ISRs). |
| `kafka_server_ZooKeeperClientMetrics_ZooKeeperRequestLatencyMs`<br/>`DGAUGE`, ms | Request latency in Zookeeper.<br/>Additional labels: `quantile` |

{% endcut %}

{% endif %}