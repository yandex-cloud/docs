# Calculating cluster configuration

This section provides recommendations for calculating the optimal cluster configuration for typical load when using {{ mgp-name }} as corporate [data storage](https://en.wikipedia.org/wiki/Data_storage).

{% note info %}

In other use cases, recommended parameters and calculation formulas may differ, for example, in the case of a large volume of archived data or more intensive data processing.

{% endnote %}

## Configuration of segment hosts {#segment}

Segment hosts directly store data and process requests to it, so they are more resource-intensive. When choosing configuration of host segments, we recommend starting from the estimated size of stored data without taking compression (in GB) into account.

* The recommended storage size for segment hosts is:

    ```
    <data volume without compression> × 1.5
    ```

    The resulting size is correct when using standard compression (zstd) of the first level (see [Creating column-oriented tables](../concepts/tables.md#create-columnar-table)). It also takes into account data mirroring, the space for temporary files when executing heavy queries, and the free space for the DBMS.

* The recommended total size of RAM of the segment hosts is:

    ```
    <data volume without compression> ÷ 8
    ```

* The recommended total number of vCPU cores of host segments is:

    ```
    <data volume without compression> ÷ 80
    ```

* The recommended number of segments per host is:

    ```
    <number of vCPU cores per host segment> ÷ 2
    ```

  This is the maximum possible number of segments on a single host. In this case, one vCPU core is allocated to each segment, and another core is used by replicas — their number is the same as the number of segments.

> For example, to store and process 20,480 GB (20 TB) of uncompressed data, you need a cluster with the following host segment characteristics:
>
> * Storage size: 30,720 GB.
> * RAM capacity: 2560 GB.
> * Number of vCPU cores: 256.
>
> This corresponds, for example, to twenty `{{ i2.2xlarge }}` hosts or ten `{{ i2.4xlarge }}` hosts. For more information about host classes, see [Available host classes](../concepts/instance-types.md#available-flavors).

The number of segment hosts in a cluster is unimportant if their total characteristics are not lower than the calculated values, but keep in mind the following when scaling the cluster:

* The new hosts will have the same configuration (memory capacity, number of vCPU cores, and number of segments per host) as the segment hosts when creating the cluster.
* The minimum number of new segment hosts when you add them is 2.

## Configuration of master hosts {#master}

Master hosts don't store or process data — they only handle connection processing and segment coordination and are less resource-intensive, so here are just some recommendations for setting them up.

* Recommended number of hosts: 2.

  A cluster with two master hosts continues to handle queries if one of them fails. A cluster with a single master host doesn't guarantee fault tolerance.

* It's recommended to use the same [storage type](../concepts/storage.md) as for segment hosts.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
