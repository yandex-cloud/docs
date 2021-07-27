---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Decommissioning subclusters and hosts

Decommissioning is the procedure for reducing the capacity of a cluster (the number of hosts and their class) without stopping it and interrupting the workload. Decommissioning is supported for {{ dataproc-name }} clusters version 1.2 and higher.

In {{ dataproc-name }}, decommissioning is implemented based on YARN and HDFS. While decommissioning is in progress, running user tasks won't be interrupted and the data in HDFS won't be lost.

To decommission subclusters in a YARN cluster, you can set a timeout. In this case, the cluster will wait for the current operations to complete, but not longer than the specified time. The hosts being decommissioned won't perform new operations or accept new data.

YARN resources are decommissioned when:

* Changing the host class.
* Increasing the disk size.
* Reducing the number of hosts in data processing subclusters.

HDFS resources are decommissioned when:

* Reducing the number of hosts in data storage subclusters.
* Deleting data storage subclusters.

If updating a cluster requires restarting its hosts, the service uses the following scenario:

1. The hosts to be updated or deleted are added to the `excluded` list in YARN.
1. No new tasks are run on the hosts from the `excluded` list. As the running tasks are completed, the hosts are updated and restarted.
1. If tasks are not completed before the decommissioning timeout, they are aborted and the host is updated and restarted.
1. After restarting, the hosts are removed from the `excluded` list.
1. The service waits until the status of every host changes to `Alive`.

The decommissioning operation time includes the decommissioning timeout and the time it takes to perform cluster update operations. The maximum decommissioning timeout is 24 hours. The maximum time to complete cluster operations is 1 hour.

For more information on decommissioning YARN clusters, see [Graceful Decommission of YARN Nodes](http://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/GracefulDecommission.html) in the Apache Hadoop documentation.
