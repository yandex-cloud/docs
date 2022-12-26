# Relationship between {{ dataproc-name }} service resources

{{ dataproc-name }} helps implement distributed data storage and processing using the [Apache Hadoop](http://hadoop.apache.org) service ecosystem.

## Resources

The main entity used in the service is a _cluster_. It groups together all the resources available in Hadoop, including storage and computing capabilities.

Each cluster consists of _subclusters_. They integrate _hosts_ that perform identical functions:

* A subcluster with a master host (`Master` or `masternode`). For example, NameNode for HDFS or ResourceManager for YARN.

   {% note info %}

   Each cluster may have only one subcluster with a master host.

   {% endnote %}

* Data storage subclusters (`Data` or `datanode`). For example, DataNode for HDFS.
* Data processing subclusters (`Compute` or `computenode`). For example, NodeManager for YARN.

Subclusters for one cluster must reside in the same [cloud network](../../vpc/concepts/network.md#network) and [availability zone](../../overview/concepts/geo-scope.md).

Hosts in each subcluster are created with the computing power consistent with the specified _host class_. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

{% if product == "cloud-il" %}

VMs corresponding to cluster hosts reside on {{ yandex-cloud }} physical servers. These hosts are selected randomly from the available pool of hosts that meet the requirements of the selected subcluster configuration.

{% endif %}

{% if product == "yandex-cloud" %}

VMs corresponding to cluster hosts can be hosted:

* On {{ yandex-cloud }} _standard hosts_.

   These are physical servers for hosting cluster VMs. These hosts are selected randomly from the available pool of hosts that meet the requirements of the selected subcluster configuration.

* On {{ yandex-cloud }} _dedicated hosts_.

   These are physical servers that only host your VMs. These VMs provide for the operation of both the cluster and your other services that support dedicated hosts. Such hosts are selected from _dedicated host groups_ specified when creating a cluster.

   This placement option ensures physical isolation of VMs. A {{ dataproc-name }} cluster using dedicated hosts includes all the features of a regular cluster.

   For more information, see the [{{ compute-full-name }} documentation on dedicated hosts](../../compute/concepts/dedicated-host.md).

{% endif %}

For information about network configuration and network access to clusters, see [{#T}](network.md).

## Leightweight clusters {#light-weight}

Starting from [image version](./environment.md) `2.0.39`, you can use a lightweight cluster configuration without HDFS and data storage subclusters. These clusters can, for example, only support YARN and SPARK. They are faster to create and use host computing resources more efficiently. We recommend using lightweight clusters to run single jobs for processing data in Spark or PySpark.

Benefits of lightweight clusters:

* The Spark Driver is run on a subcluster with master hosts. This enables you to allocate various resources to the subcluster with master hosts, which will run the Spark Driver, and to the data processing subclusters, which will run Spark Executors.

* At least one Spark Driver and Spark Executor instance will be running on each data processing subcluster of regular clusters. In lightweight clusters, the Spark Driver can use all free resources of the subcluster with master hosts, while Spark Executors can use all free resources of the data processing subclusters. This improves the performance of hosts.

Requirements for using lightweight clusters:

* The HDFS component is not selected.
* No data storage subclusters are used in a cluster.
* The cluster contains one or more data processing subclusters.
* The cluster settings specify a bucket in {{ objstorage-full-name }}.

## Security {#security}

Since a Data Proc cluster can run jobs without directly accessing clusters over {% if lang == "ru" and audience != "internal" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %}, the cluster logs the job execution results to an S3 bucket. This is done for the user's convenience. Logging to the bucket is performed under the service account specified during cluster creation. For more information about the concept, go to [Service accounts](../../iam/concepts/users/service-accounts.md).

We recommend using at least two different S3 buckets for a Data Proc cluster:

1. For the source data that the service account has read-only access to.
1. For the operation logs and results, the service account has full access.

This is required to reduce the risk of the source data being unexpectedly modified or deleted.
