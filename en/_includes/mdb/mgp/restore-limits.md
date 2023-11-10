* The total number of segments must be the same as in the source cluster.
* The total size of the segment host disks must be the same or larger than in the source cluster.

{% cut "Example" %}

> The source cluster has four segment hosts, each containing four segments. The total number of segments is 16. When restoring the cluster, you can choose 2 segment hosts with 8 segments per host, so the total number of segments remains 16.
>
> To ensure that the total disk size does not decrease, the disk size in each segment host must at least double.

{% endcut %}
