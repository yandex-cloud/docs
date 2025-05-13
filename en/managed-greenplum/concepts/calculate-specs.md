# Calculating the cluster configuration

This section provides general recommendations for calculating cluster configuration when using {{ mgp-name }} as an enterprise [data warehouse](https://en.wikipedia.org/wiki/Data_storage) of small or medium size up to 100 TB of uncompressed data.

These are generic recommendations. The actual resource usage depends on factors that are hard to foresee at the planning stage: query complexity, amount of data processed by queries, actual query concurrency, settings of data storage in tables, compression rate, percentage of archived data, etc.

We recommend load testing the production cluster before deployment. If required, {{ mgp-name }} allows you to [update the cluster configuration](../operations/cluster-config.md) with minimum downtime.

## Segment host configuration {#segment}

Segment hosts are used to store all data and run queries, which makes them resource-intensive. When choosing a configuration, make sure to consider at least the following factors:

* Estimated amount of data.
* Estimated concurrency, i.e., the number of queries running at the same time.

### Storage size calculation {#storage}

When calculating cluster storage size, consider the following factors:

* _Mirroring_. This doubles the required storage size.
* _Compression_. This reduces the required storage size. The compression rate may vary significantly depending on the data and selected compression algorithm. For calculation purposes, we will use the compression rate of 3.
* _Free space_. When working with {{ mgp-name }}, we recommend keeping your storage utilization under 70%. Make sure to have free space for transaction logs, spill and system files.

Based on these factors, the total storage size for all segment hosts may be approximately equal to the amount of uncompressed data:

```text
Storage size = <amount_of_uncompressed_data> × 2 ÷ 3 ÷ 0.7 = <amount_of_uncompressed_data> × 0.95
```

When calculating the {{ mgp-name }} storage size, you do not need to take into account the amount of data you plan to store in a cold storage using the [{{ YZ }}](../operations/extensions/yezzey.md) module.

For more information about disk types used for storage, see [Disk types](./storage.md).

### Calculating the number of segment hosts and the number of segments per host {#number-segments}

{{ GP }} architecture implements parallelization of data processing. The parallelization unit is a segment. The more segments in a cluster, the more resources are allocated per query.

One segment host can contain one or more segments. You can set the number of segments in the cluster when creating one, and then increase it by [expanding the cluster](./expand.md). Cluster expansion is time-consuming as all the data has to be redistributed across segments. You cannot reduce the number of segments.

When calculating the number of segments for a medium sized cluster, you can take the amount of uncompressed data in terabytes as the baseline value:

```text
Total number of segments = <amount_of_uncompressed_data_in_TB>
```

If the query concurrency is not high, you can add more segments. If the query concurrency is high, you need to either reduce the number of segments, or increase the resources of segment hosts (vCPUs, RAM).

For systems in production, we recommend creating at least 8 segments in total.

When calculating the number of segment hosts, you must meet this ratio:

```text
Total number of segments = <number_of_segment_hosts> × <number_of_segments_per_host>
```

We recommend having a larger number of segment hosts with fewer segments per host. The maximum number of segment hosts per cluster is 32. When designing a new cluster, it is best to stay below this limit so that you can expand the cluster by adding segment hosts.

### Calculating the number of vCPUs and amount of RAM {#vcpu-ram}

To calculate the number of vCPUs, consider the amount of data and expected load concurrency.
For moderate loads, you can allocate 3 vCPUs per segment. This way, the total number of vCPUs on all segment hosts will be:

```text
Total number of vCPUs = <total_number_of_segments> × 3
```

For high loads (from dozens to hundreds of concurrent queries), you can increase resources up to 15 vCPUs per segment.

To calculate the number of cores per segment host, use the above parameters and this formula:

```text
Number of vCPUs per segment host = <total_number_of_vCPUs> / <number_of_segment_hosts>
```

Select the segment host configuration where the number of vCPUs per segment host is the closest to the value you get. For systems in production, we recommend choosing the `io-optimized` host types.

### Example of calculating segment host configuration {#segment-example}

To store and process 20 TB of uncompressed data at moderate loads, you need a cluster with the following segment host properties:

* Storage size: 20 TB × 1 = 20 TB.
* Number of segments: 20 TB × 1 segment/TB = 20.
* Number of vCPUs per segment: 20 segments × 3 vCPUs/segment = 60.
* Number of segment hosts: 60 vCPUs ÷ 16 vCPUs/host = 4.

    {% note info %}

    For systems in production, choose the `io-optimized` host type where the minimum number of cores per host is 16.

    {% endnote %}

* Storage size per host: 20 TB ÷ 4 hosts = 5 TB.
* Number of segments per host: 20 segments ÷ 4 hosts = 5.

For more information about host classes, see [Available host classes](./instance-types.md#available-flavors).

## Configuration of master hosts {#master}

Master hosts are designed to handle connections and keep coordinate the work of segments. These hosts do not store or process data, which is why they have lower performance requirements.

In most cases, you can use `standard` hosts with `network-ssd` [disks](./storage.md) and 100 GB capacity as master hosts.

For high-load clusters with a large number of segment hosts, we recommend selecting `io-optimized` hosts as your masters.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
