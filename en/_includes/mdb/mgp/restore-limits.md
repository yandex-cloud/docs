* The total number of segments must be the same as in the source cluster.
* The disk size per segment in the new cluster must be at least as large as in the source cluster.

{% cut "Example" %}

> The source cluster has four segment hosts, each containing four segments. The total number of segments is 16. When restoring the cluster, you can choose two segment hosts with eight segments per host, so that the total number of segments remains 16.
>
> To ensure that the disk size per segment does not decrease, the disk size in each segment host must at least double.

{% endcut %}
