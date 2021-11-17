# Updating instance groups

Creating and updating instances in a group is done in two steps:

1. Instances are [allocated to zones](./zones.md).
1. The [deployment algorithm](./deploy.md) starts.

In all availability zones, similar numbers of instances are updated at the same time.

To learn about the implications of updating or changing an instance group, see the [update rules](instance.md).

{% note info %}

If for an instance group, [processes are paused](../stopping-pausing.md) ([status](../statuses.md#group-statuses) is `PAUSED`), it is not updated.

{% endnote %}

