# Relationship between {{ dataproc-name }} service resources

{{ dataproc-name }} helps implement distributed data storage and processing using the [Apache Hadoop](http://hadoop.apache.org) service ecosystem.

The main entity used in the service is a _cluster_. It groups together all the resources available in Hadoop, including storage and computing capabilities.

Each cluster consists of _subclusters_. They integrate _hosts_ that perform identical functions:

* A subcluster with master hosts (for example, NameNode for HDFS or ResourceManager for YARN).

  {% note info %}

  Each cluster may have only one subcluster with master hosts.

  {% endnote %}

* Subclusters for data storage (for example, DataNode for HDFS).
* Subclusters for data processing (for example, NodeManager for YARN).

Subclusters for one cluster must reside in the same cloud network and availability zone. [More about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

Hosts in each subcluster are created with the computing power consistent with the specified _host class_. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

VMs corresponding to cluster hosts can be hosted:

* On {{ yandex-cloud }} _standard hosts_.

    These are physical servers for hosting cluster VMs. These hosts are selected randomly from the available pool of hosts that meet the requirements of the selected subcluster configuration.

* On {{ yandex-cloud }} _dedicated hosts_.

    These are physical servers that only host your VMs. These VMs provide for the operation of both the cluster and your other services that support dedicated hosts. Such hosts are selected from _dedicated host groups_ specified when creating a cluster.

    This placement option ensures physical isolation of VMs. A {{ dataproc-name }} cluster using dedicated hosts includes all the features of a regular cluster.

    For more information, see the [{{ compute-full-name }} documentation on dedicated hosts](../../compute/concepts/dedicated-host.md).

For information about network configuration and network access to clusters, see [{#T}](network.md).

## Security {#security}

Since a Data Proc cluster can run jobs without directly accessing clusters over SSH, the cluster logs the job execution results to an S3 bucket. This is done for the user's convenience. Logging to the bucket is performed under the service account specified during cluster creation. For more information about the concept, go to [Service accounts](../../iam/concepts/users/service-accounts.md).

We recommend using at least two different S3 buckets for the Data Proc cluster:

1. For the source data that the service account has read-only access to.
1. For the operation logs and results, the service account has full access.

This is required to reduce the risk of the source data being unexpectedly modified or deleted.
