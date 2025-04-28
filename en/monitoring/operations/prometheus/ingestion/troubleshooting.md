---
title: How to troubleshoot issues when writing metrics via the Remote API
description: Follow this guide to troubleshoot issues when writing metrics via the Remote API.
---

# Troubleshooting issues when writing metrics via the Remote API

The most common issue is where data sent to remote storage lags behind data written to the WAL. This usually happens after you restart {{ prometheus-name }} or reload the [configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write).

If you are experiencing a lag when writing metrics via the Remote API:

* [Analyze](#diagnostics) the collected [metrics](./remote-write.md#metrics) to find what causes the lag.
* Try using one of the [methods for troubleshooting common issues](#troubleshooting).

## Diagnosing issues when writing metrics via the Remote API {#diagnostics}

If you suspect that your data goes to remote storage with a lag:

1. Check if the `prometheus_wal_watcher_current_segment` and `prometheus_tsdb_wal_segment_current` values match. If they do not, it means the data sent to remote storage lags behind the new data written to the WAL.
1. Compare `prometheus_remote_storage_queue_highest_sent_timestamp_seconds` to `prometheus_remote_storage_highest_timestamp_in_seconds`. This will give you an idea of how big the lag is.
1. If there is a lag, check the `prometheus_remote_storage_shards` and `prometheus_remote_storage_shards_max` values. If they match, the remote write is using the maximum possible number of shards.
1. Compare `prometheus_remote_storage_shards_desired` to `prometheus_remote_storage_shards_max`. If the number of shards you need (`prometheus_remote_storage_shards_desired`) is greater than the maximum (`prometheus_remote_storage_shards_max`), the current maximum number of shards is not enough for efficient remote writing.
1. Analyze the `prometheus_remote_storage_samples_retried_total` values. Long-term high readings of this metric may indicate network or remote storage issues. In this case, you may need to reduce the remote write throughput to reduce the load.

## Troubleshooting common issues when writing metrics via the Remote API {#troubleshooting}

To configure remote writing, update the {{ prometheus-name }} configuration parameters in the `queue_config` section under `remote_write`.

### Suboptimal shard allocation limits {#shards}

{{ prometheus-name }} remote writes use sharding to increase data throughput. Data is distributed across shards, and the number of these shards is calculated based on recent throughput and incoming data size. If a remote write cannot use the optimal number of shards, this may cause delays in sending data to remote storage.

Updating `max_shards` allows you to increase or decrease the maximum throughput for data transfer to remote storage. If there is a delay, [check](#diagnostics) if the number of shards you need exceeds the maximum value. If so, you should increase `max_shards` in the {{ prometheus-name }} configuration.

The `min_shards` parameter defines the minimum number of shards for remote writes. Usually, there is no need to change it. However, if your remote writes always use a specific minimum number of shards, increasing the `min_shards` value may help reduce recovery time after restarting {{ prometheus-name }}.

### Insufficient buffer size {#capacity}

Before going to remote storage, the WAL data gets sharded, with each shard then individually sending its data to remote storage. If the memory buffer of one of the shards gets full, {{ prometheus-name }} will suspend WAL reads for all shards.

The `capacity` parameter sets the shard buffer size. The recommended `capacity` value should be between three and ten times the `max_samples_per_send` value. You can raise the `capacity` value to increase the throughput of each shard; however, setting it too high may cause excessive memory consumption.

If the network load is high, try increasing `capacity` while simultaneously decreasing `max_shards`. This way you can reduce the network load without affecting the throughput.

### Remote storage send deadline is too short {#batch-send-deadline}

There is a send deadline for data going to remote storage. Once this deadline is reached, the data will be sent even if the data packet is not full. You can change the deadline in the `batch-send-deadline` parameter, which sets the maximum time between data sends for each shard.

Generally, you should avoid modifying this parameter; however, it can be helpful for diagnosing certain remote write issues. If the deadline gets missed on a regular basis, this may indicate that the throughput is too high for the current configuration.

### Data packet size is too small {#batch-size}

If the maximum number of points in a data packet is too small, it may cause the network to get overloaded with many small data packets. If this issue occurs, increase the `max_samples_per_send` value. This will increase the throughput for both shards and data packets.

### Too many retries to send data to remote storage {#samples-retried}

If a recoverable error occurs when sending data to remote storage, it will trigger a retry. To avoid data loss, retries will continue indefinitely. The `min_backoff` and `max_backoff` parameters define the minimum and maximum delays before a retry.

Too frequent retries may lead to network overload. You can diagnose this condition using the `prometheus_remote_storage_samples_retried_total` metric. If this is the case, increase the `max_backoff` value to extend the maximum delay before a retry.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}


