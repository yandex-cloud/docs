# Calculating the cluster configuration

This section provides recommendations for calculating the optimal cluster configuration for typical load when using {{ mgp-name }} as an enterprise [data warehouse]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Хранилище_данных){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Data_warehouse){% endif %}.

{% note info %}

In other use cases, the recommended parameters and calculation formulas may differ, for example, when there is a large volume of archived data or more intensive data processing.

{% endnote %}

## Segment host configuration {#segment}

Segment hosts directly store data and process requests to it, so they are more resource intensive. When choosing a segment host configuration, we recommend starting with the estimated size of the stored data without taking compression (in GB) into account.

* The recommended storage size for segment hosts is:

    ```
    <data volume without compression> × 1.5
    ```

   The resulting size is correct when using standard level 1 compression (zstd) (see [Creating column-oriented tables](../concepts/tables.md#create-columnar-table)). It also takes into account data mirroring, space for temporary files when executing heavy queries, and free space for the DBMS.

* The recommended total size of RAM of the segment hosts is:

    ```
    <data volume without compression> ÷ 8
    ```

* The recommended total number of segment host vCPU cores is:

    ```
    <data volume without compression> ÷ 80
    ```

* The recommended number of segments per host is:

    ```
    <number of vCPU cores per segment host> ÷ 2
    ```

  This is the maximum possible number of segments on a single host. In this case, one vCPU core is allocated to each segment, and another core is used by replicas. There are as many replicas as there are segments.

> For example, to store and process 20480 GB (20 TB) of uncompressed data, you need a cluster with the following segment host characteristics:
>
> * Storage size: 30720 GB.
> * RAM: 2560 GB.
> * vCPU cores: 256.
>
> This corresponds, for example, to ten `{{ m2-4xlarge }}` hosts or five `{{ m2-8xlarge }}` hosts. For more information about host classes, see [Available host classes](../concepts/instance-types.md#available-flavors).

The number of segment hosts in a cluster is unimportant if their total characteristics are not lower than the calculated values, but keep in mind the following when scaling the cluster:

* The new hosts will have the same configuration (RAM, vCPU cores, and number of segments per host) as the segment hosts when creating the cluster.
* The minimum number of new segment hosts when you add them is 2.

## Configuration of master hosts {#master}

Master hosts don't store or process data. They only handle connection processing and segment coordination and are less resource intensive, so here are just some recommendations for setting them up.

* Recommended number of hosts: 2.

  A cluster with two master hosts continues to handle queries if one of them fails. A cluster with a single master host doesn't guarantee fault tolerance.

* We recommend using the same [storage type](../concepts/storage.md) as the segment hosts.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}