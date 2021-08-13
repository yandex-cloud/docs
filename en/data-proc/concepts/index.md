---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Relationship between {{ dataproc-name }} service resources

{{ dataproc-name }} lets you use distributed data storage and processing for data using [Apache Hadoop](http://hadoop.apache.org) ecosystem services.

The main entity used in the service is a _cluster_. It groups together all the resources available in Hadoop, including computing and storage capabilities.

Each cluster consists of _subclusters_. They integrate _hosts_ that perform identical functions:

* A subcluster with master hosts (for example, NameNode for HDFS or ResourceManager for YARN).

  {% note info %}

  Each cluster may have only one subcluster with master hosts.

  {% endnote %}

* Subclusters for data storage (for example, DataNode for HDFS).

* Subclusters for data processing (for example, NodeManager for YARN).

Subclusters for one cluster must reside in the same cloud network and availability zone. [Learn more about the geo scope of {{ yandex-cloud }}](../../overview/concepts/geo-scope.md).

Hosts in each subcluster are created with the computing power consistent with the specified _host class_. For a list of available host classes and their characteristics, see [{#T}](instance-types.md).

For information about network configuration and network access to clusters, see [{#T}](network.md).

## Security {#security}

Since a {{ dataproc-name }} cluster can run jobs without directly accessing clusters over SSH, the cluster logs the job execution results to an S3 bucket. This is done for the user's convenience. Logging to the bucket is performed under the service account specified during cluster creation. For more information about the concept, go to [Service accounts](../../iam/concepts/users/service-accounts.md).

We recommend using at least two different S3 buckets for the Data Proc cluster:

1. For the source data that the service account has read-only access to.
2. For the operation logs and results, the service account has full access.

This is required to reduce the risk of the source data being unexpectedly modified or deleted.

