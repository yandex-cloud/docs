# Calculating the cluster configuration

This section provides recommendations for calculating an optimized cluster configuration based on typical load when using {{ mgp-name }} as enterprise [data storage](https://en.wikipedia.org/wiki/Data_storage).

## Segment host configuration {#segment}

Segment hosts are designed to store data and process queries against such data, which is why they are resource intensive. When choosing a segment host configuration, start with the estimated amount of data you will be storing (in GB) before compression.

* The recommended segment host storage size is as follows:

    ```text
    <uncompressed_data_size> × 1.5
    ```

    The formula is correct for standard first-level compression (zstd) (see [Creating column-oriented tables](../concepts/tables.md#create-columnar-table)). It also takes into account [data mirroring](../concepts/index.md), space for temporary files when executing heavy queries, and DBMS free space.

* The recommended total RAM for segment hosts is as follows:

    ```text
    <uncompressed_data_size> ÷ 8
    ```

* The recommended total number of segment host vCPU cores is as follows:

    ```text
    <uncompressed_data_size> ÷ 80
    ```

* The recommended number of segment hosts in the cluster is as follows:

    We recommend creating as many segment hosts as possible with fewer resources per host if their total capacity is at least equal to the computed values. This will help you mitigate the negative consequences if a host fails.

    Please note that, when scaling your cluster:

    * The new hosts will have the same configuration (RAM, vCPU cores, and number of segments per host) as the segment hosts when creating the cluster.
    * You cannot add fewer than two new segment hosts.

* The recommended number of segments per host depends on the following two parameters:

    * Number of vCPU cores per host:

        * 8 ≤ vCPU < 32: 4 segments
        * 32 ≤ vCPU < 64: 4-8 segments
        * vCPU ≥ 64: 8-16 segments

        If these values are selected, each segment is allocated at least one vCPU core, and the replicas use at least one more core each. There are as many replicas as there are segments.

        The larger the number of segments, the less time it takes to execute long queries, which provides better parallelism per query. If there are less segments, each of them can use more resources. This allows running more memory-consuming queries with higher concurrency.

        If you expect a high degree of concurrency (from dozens to hundreds of simultaneous queries), the number of segments per host you select should be close to the lower limit.

    * Number of files in a database.

        The recommended number of files per host should not exceed 100,000.

        ```text
        <number_of_segments_per_host> ≤ 100,000 ÷ <number_of_files_in_DB>
        ```

        You can approximately estimate the number of files by the number of DB tables: each [table without clustered indexes](../concepts/tables.md) (a heap) has at least three files, while an append-optimized table, about seven files. If you use partitioned tables, each partition is considered a separate table, while for column-oriented tables, each column is treated as a separate table.

* The required RAM per {{ GP }} server process is at least 20 MB. This indicator value is calculated using the following formula:

    ```text
    <host_segment_RAM> ÷ (<Max_connections> x <number_of_segments_per_host>)
    ```

    Where `Max_connections` is the {{ GP }} [DBMS setting](../../managed-greenplum/concepts/settings-list.md#setting-max-connections).

    If the calculated value is less than 20 MB, you will get an [error](../qa/cluster-hosts.md#memory-limit) when creating, modifying, or restoring the cluster. To avoid it, select a host segment class with such a RAM size that the value calculated by the formula is at least 20 MB.

### Segment host configuration example {#segment-example}

To store and process 20480 GB (20 TB) of uncompressed data, you need a cluster with the following segment host properties:

* Storage size: 20,480 GB × 1.5 = 30,720 GB
* Amount of RAM: 20,480 GB ÷ 8 = 2,560 GB
* Number of vCPUs: 20,480 GB ÷ 80 = 256

This is equal to 20 `{{ i2.2xlarge }}` hosts with 4 segments per host or 10 `{{ i2.4xlarge }}` hosts with 8 segments per host. For more information about host classes, see [Available host classes](../concepts/instance-types.md#available-flavors).

## Configuration of master hosts {#master}

Master hosts are designed to handle connections and keep coordinate the work of segments. These hosts do not store or process data, which is why they have lower performance requirements.

We recommend using the same [type of disks](../concepts/storage.md) for both the master and the segment hosts.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
