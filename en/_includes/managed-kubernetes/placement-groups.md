{% note info %}

The placement group determines the maximum available node group size:

* In an instance group with the [spread placement](../../compute/concepts/placement-groups.md#spread) strategy, the maximum number of instances depends on the [limits](../../compute/concepts/limits.md#compute-limits-vm).
* In an instance group with the [partition placement](../../compute/concepts/placement-groups.md#partition) strategy, the maximum number of instances in a partition depends on the [quotas](../../compute/concepts/limits.md#vm-quotas).


{% endnote %}
