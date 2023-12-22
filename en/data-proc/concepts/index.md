# {{ dataproc-name }} resource relationships

{{ dataproc-name }} helps implement distributed data storage and processing using the [Apache Hadoop](http://hadoop.apache.org) service ecosystem.

## Resources {#resources}

The main entity used in {{ dataproc-name }} is a _cluster_. It groups together all resources available in Hadoop, including storage and computing capacity.

Each cluster consists of _subclusters_. They integrate _hosts_ that perform identical functions:

* Subcluster with a master host (`masternode`), such as NameNode for HDFS or ResourceManager for YARN.

   Each cluster may only have one subcluster with a master host.

* Data storage subclusters (`Data` or `datanode`), such as DataNode for HDFS.
* Data processing subclusters (`Compute` or `computenode`), such as NodeManager for YARN.

Subclusters of a single cluster must reside in the same [cloud network](../../vpc/concepts/network.md#network) and [availability zone](../../overview/concepts/geo-scope.md).

{% note warning %}

The `{{ region-id }}-c` availability zone is [being deprecated](/blog/posts/2023/08/new-availability-zone). If your cluster is hosted in this availability zone, [create a new cluster and move](../operations/migration-to-an-availability-zone.md) the workload to it.

{% endnote %}

Hosts in each subcluster are created with the computing capacity that is consistent with the specified _host class_. For a list of available host classes and their specs, see [{#T}](instance-types.md).



VMs for cluster hosts can be hosted on:

* _Regular {{ yandex-cloud }} hosts_:

   These are physical servers for hosting cluster VMs. These hosts are selected randomly from the available pool of hosts that meet the requirements of the selected subcluster configuration.

* _Dedicated {{ yandex-cloud }} hosts_:

   These are physical servers that only host your VMs. Such VMs ensure the operation of both the cluster and your other services that support dedicated hosts. The hosts are selected from _dedicated host groups_ specified when creating a cluster.

   Such a placement option makes sure the VMs are physically isolated. A {{ dataproc-name }} cluster using dedicated hosts includes all features of a regular cluster.

   For more information about dedicated hosts, see the [{{ compute-full-name }} documentation](../../compute/concepts/dedicated-host.md).


For information about network configuration and network access to clusters, see [{#T}](network.md).

{% include [dedicated-hosts-edit-restrictions](../../_includes/data-proc/note-vm-edit-restrictions.md) %}

## Leightweight clusters {#light-weight-clusters}

Starting from [image version](./environment.md) `2.0.39`, you can use a lightweight cluster configuration without HDFS and data storage subclusters. These clusters can, for example, only support YARN and SPARK. They are faster to create and use host computing resources more efficiently. We recommend using lightweight clusters to run single jobs for processing data in Spark or PySpark.

Benefits of lightweight clusters:

* The Spark Driver is run on a subcluster with master hosts. This enables you to allocate different resources to the subcluster with master hosts, which will run the Spark Driver, and to the data processing subclusters, which will run Spark Executors.

* At least one Spark Driver and Spark Executor instance will be running on each data processing subcluster of regular clusters. In lightweight clusters, the Spark Driver can use all free resources of the subcluster with master hosts, while Spark Executors can use all free resources of the data processing subclusters. This improves the performance of hosts.

Requirements for using lightweight clusters:

* The HDFS component is not selected.
* No data storage subclusters are used in a cluster.
* The cluster contains one or more data processing subclusters.
* The cluster settings specify a bucket in {{ objstorage-full-name }}.

For more information about resource allocation, see [Spark jobs](./spark-sql.md#resource-management).

## Security {#security}

Since a {{ dataproc-name }} cluster can run jobs without directly accessing clusters over SSH, the cluster logs the job execution results to an S3 bucket. This is done for the user's convenience. The logs are written under the service account specified during cluster creation. For more information, see [Service accounts](../../iam/concepts/users/service-accounts.md).

We recommend using at least two separate S3 buckets for a {{ dataproc-name }} cluster:

1. One for the source data, where the service account has read-only access.
1. Another one for the operation logs and results, where the service account has full access.

This is required to minimize the risk of unexpectedly modifying or deleting source data.
