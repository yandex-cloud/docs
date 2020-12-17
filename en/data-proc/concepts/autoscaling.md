# Autoscaling of subclusters

{{ dataproc-full-name }} supports automatic scaling of compute subclusters as of version 1.2. The service uses {{ ig-name }} and lets you increase or decrease the number of hosts in the cluster based on CPU utilization. Scaling rules are set separately for each subcluster.

For more information about {{ ig-name }}, see the [documentation](../../compute/concepts/instance-groups/index.md).

To run operations, use a [service account](../../iam/concepts/index.md#sa) with the `editor` rights. The operations will be executed on its behalf. Assign this role in addition to the `dataproc.agent` role.

You can set the following autoscaling parameters:

* The initial size of the group (it also sets the group's minimum size).
* [Decommissioning](decommission.md) timeout. Set in seconds. Its maximum value is one day (86400 seconds). The default value is 2 minutes.
* Type of VM instances: standard or preemptible
* Maximum group size.
* Utilization measurement period to average the utilization measurements for each instance in the group.
* Instance warmup period. The interval during which data from an instance isn't used after it starts. Average metric values for the group are used instead.
* Stabilization period (minutes or seconds): The interval during which the required number of instances in the group can't be decreased.

When you set up the autoscaling rules, take account of the base load on the subcluster and the minimum required performance of the subcluster. When vCPU utilization exceeds the specified threshold, new hosts are added to the subcluster according to the rule. You can use the new hosts in a YARN cluster running Apache Spark and Apache Hive as soon as the status of the hosts is `Alive`. When vCPU utilization falls below the specified threshold, the process of reducing the autoscaled subcluster will start: on some of the subcluster nodes, [decommission](decommission.md) will start. The decommission timeout is specified at subcluster creation. After the decommission is complete (nodes are correctly removed from the cluster), the removed hosts are deleted.
