---
title: How to diagnose and troubleshoot issues when writing metrics via the Remote API
description: Follow this guide to diagnose and troubleshoot issues when writing metrics via the Remote API.
---

# Diagnosing and troubleshooting issues when writing metrics via the Remote API

The most common issue is where data sent to remote storage lags behind data written to WAL. This usually happens after you restart {{ prometheus-name }} or reboot the [configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write).

If you are experiencing a lag when writing metrics via the Remote API:

* [Analyze](#diagnostics) the collected [metrics](./remote-write.md#metrics) to find what causes the lag.
* Try using one of the [methods for troubleshooting common issues](#troubleshooting).

## Diagnosing issues when writing metrics via the Remote API {#diagnostics}

If you suspect that your data goes to remote storage with a lag:

1. Check if the `prometheus_wal_watcher_current_segment` and `prometheus_tsdb_wal_segment_current` metrics match. If they do not, it means the data sent to remote storage lags behind the new data written to WAL.
1. Compare `prometheus_remote_storage_queue_highest_sent_timestamp_seconds` to `prometheus_remote_storage_highest_timestamp_in_seconds`. This will give you an idea of how big the lag is.
1. If there is a lag, compare `prometheus_remote_storage_shards` to `prometheus_remote_storage_shards_max`. If their values are equal, the remote write uses the maximum possible number of shards.
1. Compare `prometheus_remote_storage_shards_desired` to `prometheus_remote_storage_shards_max`. If the desired number of shards is greater than the maximum, the current maximum number of shards is not enough for an efficient remote write operation.
1. Analyze the `prometheus_remote_storage_samples_retried_total` metric values. Long-term high readings of this metric may indicate network or remote storage issues. In this case, you may need to reduce the remote write throughput to reduce the load.

## Troubleshooting common issues when writing metrics via the Remote API {#troubleshooting}

You can configure the remote write operation by changing the {{ prometheus-name }} configuration parameters in the `queue_config` section inside the `remote_write` section.

### Non-optimal limits on the number of shards {#shards}

The {{ prometheus-name }} remote writes use sharding to increase data throughput. Data is distributed based on a set of shards, the number of which is calculated based on recent throughput and the amount of incoming data. If a remote write cannot use the optimal number of shards, this may cause delays in sending data to remote storage.

Changing the `max_shards` parameter allows you to increase or decrease the maximum data transfer throughput to remote storage. If there is a delay, [check](#diagnostics) if the desired number of shards exceeds the maximum number of shards. If so, you should increase `max_shards` in the {{ prometheus-name }} configuration.

The `min_shards` parameter is responsible for the minimum number of shards in a remote write operation. Usually there is no need to change it. The exception is when your remote write operation always uses a particular minimum number of shards. In which case by increasing the `min_shards` parameter you can improve recovery time after rebooting {{ prometheus-name }}.

### Insufficient buffer size {#capacity}

Before it goes to remote storage, the WAL data gets sharded, after which each shard sends its data to remote storage. If the memory buffer of one of the shards gets full, {{ prometheus-name }} will suspend WAL reads for all shards.

The `capacity` parameter is responsible for the shard buffer size. The recommended `capacity` value should be between three and ten times the `max_samples_per_send` value. You can raise the `capacity` parameter to increase each shard's throughput, but if set too high, it can lead to excessive memory consumption.

If the network load is high, try increasing `capacity` while simultaneously decreasing `max_shards`. This way you can reduce the network load without affecting throughput.

### Deadline for sending data to remote storage is too short {#batch-send-deadline}

There is a send deadline for data that goes to remote storage. Once this deadline is reached, the data gets sent even if the data packet is not completely full. You can change the deadline via the `batch-send-deadline` parameter, which sets the maximum time between data send operations for each shard.

Generally, you do not want to change this setting, but it can be useful for diagnosing some remote write problems. If the deadline gets missed on a regular basis, this may indicate that the throughput is too high given the current configuration.

### Data packet size is too small {#batch-size}

If the maximum number of points in a data packet is too small, it may cause the network to get overloaded with many small data packets. If this problem occurs, increase the `max_samples_per_send` parameter. This will increase throughput for both shards and data packets.

### Too many retries to send data to remote storage {#samples-retried}

If there is a fixable error when sending data to remote storage, an attempt to resend will be made. To avoid data loss, the resend attempts will continue indefinitely. The `min_backoff` and `max_backoff` parameters are responsible for the minimum and maximum delays before resending.

If too frequent, the resend attempts may cause the network to get overloaded. You can diagnose this condition using the `prometheus_remote_storage_samples_retried_total` metric. In which case increase the maximum delay before sending by increasing the `max_backoff` parameter.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}


