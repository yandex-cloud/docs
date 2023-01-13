# Calculating the cluster configuration

This section provides recommendations to optimize the cluster configuration for a standard load when using {{ mgp-name }} as corporate [data storage]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Хранилище_данных){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Data_storage){% endif %}.

## Segment host configuration {#segment}

Segment hosts are designed to store data and process queries against such data, which is why they are resource intensive. When choosing a segment host configuration, start with the estimated amount of data you will be storing (in GB) before compression.

* Recommended segment host storage size:

   ```text
   <data volume without compression> × 1.5
   ```

   The formula is correct for standard first-level compression (zstd) (see the section on [Creating column-oriented tables](../concepts/tables.md#create-columnar-table)). It also takes [data mirroring](../concepts/index.md), space for temporary files when executing heavy queries, and DBMS free space into consideration.

* Recommended total RAM for segment hosts:

   ```text
   <data volume without compression> ÷ 8
   ```

* Recommended total number of segment host vCPU cores:

   ```text
   <data volume without compression> ÷ 80
   ```

* The number of segment hosts in a cluster isn't important as long as their total capacity is at least equal to the computed values. When scaling a cluster:

   * Recommended number of segments per host:

      ```text
      <number of vCPU cores per segment host> ÷ 2
      ```

      If this value is selected, each segment is allocated a single vCPU core, and the replicas use another core each. There are as many replicas as there are segments. You cannot specify a greater value.

   * The new hosts will have the same configuration (RAM, vCPU cores, and number of segments per host) as the segment hosts when creating the cluster.
   * You cannot add fewer than two new segment hosts.

> For example, to store and process 20480 GB (20 TB) of uncompressed data, you need a cluster with the following segment host characteristics:
>
> * Storage size: 20480 GB × 1.5 = 30720 GB.
> * RAM: 20480 GB ÷ 8 = 2560 GB.
> * vCPU cores: 20480 GB ÷ 80 = 256.
> * Segments per host: 256 ÷ 2 =128.
>
> For example, this matches 20 `{{ i2.2xlarge }}` hosts or 10 `{{ i2.4xlarge }}` hosts. For more information about host classes, see [Available host classes](../concepts/instance-types.md#available-flavors).

## Configuration of master hosts {#master}

Master hosts are designed to handle connections and keep coordinate the work of segments. These hosts don't store or process data, which is why they have lower performance requirements.

We recommend using the same [type of disks](../concepts/storage.md) for both the master and the segment hosts.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
