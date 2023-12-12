# Decommissioning subclusters and hosts in {{ dataproc-name }}

Decommissioning is the process of reducing the cluster capacity (the number of hosts and their class) without stopping the cluster and interrupting its workload.  Decommissioning is supported for {{ dataproc-name }} clusters version 1.2 and higher. 

{{ dataproc-name }} implements decommissioning based on[ YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YARN.html) and [HDFS](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/HdfsDesign.html). Decommissioning will not interrupt running user tasks or cause data to be lost.

You can specify a decommissioning timeout for YARN clusters. In this case, the cluster will wait for the current operations to complete, but not longer than the specified time. Without a timeout, subcluster hosts will terminate immediately. The hosts being decommissioned will not perform new operations or accept new data.

The decommissioning duration depends on the timeout and the time spent modifying a cluster. The maximum timeout is 24 hours. The maximum duration of cluster operations is 1 hour.

YARN subcluster resources are decommissioned when:

* Changing the host class.
* Increasing the disk size.
* Reducing the number of hosts in data processing subclusters.

HDFS subcluster resources are decommissioned if the number of hosts in data storage subclusters is reduced.

If the hosts must be rebooted for a cluster to update:

1. The hosts to update or delete are added to YARN's `excluded` list.
1. No new jobs are run on the hosts from the `excluded` list. As the running jobs are completed, the hosts are updated and restarted.
1. If jobs are not completed before the decommissioning timeout, they are aborted and the host is updated and restarted.
1. After restarting, the hosts are removed from the `excluded` list.

When all hosts change their status to `Alive`, decommissioning is considered complete.

For more information about YARN subcluster decommissioning, see the [Apache Hadoop documentation](http://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/GracefulDecommission.html).
