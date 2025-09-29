# Multi-zonal {{ compute-full-name }} instance group with instances in the incident zone

{% note tip %}

We recommend using multiple zonal [instance groups](../index.md) distributed across [availability zones](../../../../overview/concepts/geo-scope.md) instead of a single multi-zonal group. This approach provides more granular control over instance distribution and updates, allowing you to manage your instance groups in each zone independently.

{% endnote %}

To compensate for lost capacity from instances in the affected zone, we recommend you initially set your instance group size with a performance buffer. Otherwise, temporarily increase the size of instance groups in the healthy zones during the incident.

We also recommend using the [deployment policy](../policies/deploy-policy.md) `max_expansion` parameter which controls the maximum number of instances to add when updating the group. When this parameter is set, new instances will be created first, and only then the old ones will get deleted. During autohealing, the new instance will always be created in the old instance’s zone, provided this zone is available.

The scaling behavior of your instance group will vary depending on the [scaling policy](../policies/scale-policy.md):

* [Fixed-size instance groups](#increase-fixed-size)
* [Autoscaling instance groups](#increase-scalable)

See also some aspects of other actions on instance groups during a zonal incident:

* [Autohealing an instance in the group](#autohealing)
* [Updating an instance in the group](#update)
* [Completing instance group operations initiated before the incident](#operation-completion)

## Fixed-size instance groups {#increase-fixed-size}

In fixed-size groups, instances are always distributed evenly across availability zones. This behavior persists even during a zonal incident.

If the number of instances in a group is divisible by the number of zones, the instances will be evenly split across the zones. In healthy zones, the new instances will be created immediately; in the affected zone, they will be created after the incident ends.

If the number of instances is not divisible by the number of zones, the remaining instances will be distributed only among healthy zones. If instance distribution across zones is uneven, instances will be added to the zone with the fewest instances to restore balance even if the zone is not operational.

> Here is an example: Group instances are distributed across three zones, `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d`, one instance per zone.
>
> When there is no incident, if you add two instances to the group, they will be distributed across zones as follows:
> * `{{ region-id }}-a`: Two instances
> * `{{ region-id }}-b`: Two instances
> * `{{ region-id }}-d`: One instance
> 
> When there is an incident in the `{{ region-id }}-b` zone:
> * `{{ region-id }}-a`: Two instances
> * `{{ region-id }}-b`: One instance
> * `{{ region-id }}-d`: Two instances

This way, you can develop your own strategy to automatically make up for lost resources in the affected zone.

{% note warning %}

During a zonal incident, some of the new instances in a fixed-size group will still be assigned to the affected zone. Configure your groups with a performance buffer and make sure all instances can be evenly split across zones.

{% endnote %}

## Autoscaling instance groups {#increase-scalable}

In autoscaling groups, new instances are distributed across availability zones for maximum efficiency, according to the [scaling policy](../policies/scale-policy.md#auto-scale-policy) settings.

> For example, if your application runs on 9 instances and is deployed across two availability zones, you need to host 9 instances in each zone, 18 in total.
> 
> Alternatively, if your application runs on 9 instances and is deployed across three availability zones, the total number of instances in the group must be 12.

{% note tip %}

To compensate for lost capacity from instances in the affected zone, set the scaling policy `max_size` parameter with a performance buffer.

{% endnote %}

Regardless of the [autoscaling type](../scale.md#auto-scale-type), the number of instances in the affected zone will not change. During an incident, instances are created or deleted only in unaffected zones. New instances are created until the `max_size` limit is reached.

In groups with _zonal_ autoscaling, instances do not have to be evenly distributed across zones. They will be created or deleted in healthy zones based on the workload.

In groups with _regional_ autoscaling, instances are always evenly distributed across zones. However, an incident may lead to an imbalance in distribution.

When the incident is over, instances are automatically redistributed across all zones based on the group’s autoscaling type.

## Autohealing an instance in the group {#autohealing}

During a zonal incident, [autohealing](../autohealing.md#healthcheck-cases) continues to work normally in healthy zones:

* Instances deemed unhealthy based on their [status in {{ compute-name }}](../autohealing.md#auto-healthcheck) will be recovered as normal without counting against any quota.
* Instances deemed unhealthy based on [application health checks](../autohealing.md#functional-healthcheck) will be recovered within the `max_unavailable` quota. In the [deployment policy](../policies/deploy-policy.md), this quota defines the maximum allowed number of unavailable instances during group updates. If autohealing is on, instances residing in the affected zone are excluded from the `max_unavailable` quota during the incident, so recovery will run normally in other zones.

## Updating an instance in the group {#update}

You can update your instances to a new version even during a zonal incident.

In healthy zones, changes are applied immediately, while instances in the affected zone will be updated after the incident is over. 

{% note warning %}

To avoid losing all instances in the group during an update, instances from the affected zone will count toward the `max_unavailable` limit set in the [deployment policy](../policies/deploy-policy.md). This means that, during an incident, you should increase the `max_expansion` parameter to safely perform updates.

{% endnote %}

## Completing instance group operations initiated before the incident {#operation-completion}

A zonal incident during an instance update will not disrupt the process even if there are active operations on instances in the affected zone. The update will continue in unaffected zones, provided the `max_unavailable` quota in the [deployment policy](../policies/deploy-policy.md) is not exceeded. After the incident ends, the remaining instances in the affected zone will also get updated to the target state.

{% note info %}

{{ compute-name }} aims to achieve the target state for the instance group, so group updates may follow hybrid scenarios.

{% endnote %}

> For example, if the instances were getting updated before the incident and you need to scale up the group afterward, the updated target specification will apply to the new instances.