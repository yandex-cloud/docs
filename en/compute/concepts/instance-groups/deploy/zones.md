# Allocating instances across zones

Allocation of instances across zones depends on the [group scaling type](../scale.md).

## In manually scaled groups {#fixed-scale}

In manually scaled groups, instances are distributed evenly between zones.

In accordance with the [deployment policy](../policies/allocation-policy.md), instances are added to each zone sequentially, one at a time. If the list of zones is exhausted, but the desired number of instances is not created, zones are reused.

{% note tip %}

We recommend creating an instance group so that its size is a multiple of the number of zones.

In this case, every zone will host the same number of instances, and a [network load balancer](../../../../network-load-balancer/concepts/index.md) (if any) will evenly allocate the load between instances.

{% endnote %}

If the group size is not a multiple of the number of zones, some zones will host less instances than others, but no more than one instance less.

### Examples {#ex-fixed-scale}

If you listed zones in the order `[{{ region-id }}-c, {{ region-id }}-a]` in the YAML specification, and the size of the group is 4, then after allocation you'll have 2 instances in each zone:


| Step | {{ region-id }}-c | {{ region-id }}-a | Left |
| :-: | :-----------: | :-----------: | :------: |
| 1 | 1 | 0 | 3 |
| 2 | 1 | 1 | 2 |
| 3 | 2 | 1 | 1 |
| 4 | 2 | 2 | 0 |


If you listed zones in the order `[{{ region-id }}-c, {{ region-id }}-a]` in the YAML specification, and the size of the group is 5, then after allocation you'll have 3 instances in `{{ region-id }}-c` and 2 instances in `{{ region-id }}-a`:


| Step | {{ region-id }}-c | {{ region-id }}-a | Left |
| :-: | :-----------: | :-----------: | :------: |
| 1 | 1 | 0 | 4 |
| 2 | 1 | 1 | 3 |
| 3 | 2 | 1 | 2 |
| 4 | 2 | 2 | 1 |
| 5 | 3 | 2 | 0 |


If you listed three zones in the order `[{{ region-id }}-c, {{ region-id }}-a, {{ region-id }}-b]` in the specification and entered a fixed size for group 2 that's lower than the number of zones. In this case, one instance is created both in `{{ region-id }}-c` and `{{ region-id }}-a`, and no instances are created in `{{ region-id }}-b`. **Such a configuration is not recommended, but it's not prohibited either**.

## In automatically scaled groups {#auto-scale}

Unlike fixed-size groups, the order of zones in automatically scaled instance groups makes no difference.

The number of instances in zones is determined by the [automatic scaling](../scale.md#auto-scale) algorithm based on the average utilization and average load per zone. It can change depending on the restrictions set by the user:

* `min_zone_size` (minimum zone size): The zone can't have less instances than specified in `min_zone_size`.
   
   This restriction allows you to maintain a reserve of instances in the zone in case of a sudden load increase.
   
   You may specify `min_zone_size=0`. In this case, the zone may be empty.

* `max_size` (maximum size of the whole group): The group can't have more instances than specified in `max_size` (in total for all zones).
   
   By limiting the number of instances in an automatically scaled group you can control your finance costs.

### Examples {#ex-auto-scale}

**The `min_zone_size` restriction is taken into account during allocation**

Let's say `min_zone_size` is equal to 2, and the automatic scaling algorithm calculated that you need 0 instances in the zone. In this case, you'll have 2 instances in the zone, because that's the minimum allowed number of instances in the zone.

**The `min_zone_size` and `max_size` restrictions are taken into account during allocation**

Say you have a `min_zone_size` of 5, `max_size` of 20, and the automatic scaling algorithm allocated instances across zones as follows: 15 + 10 + 5 instances.

1. You have 30 instances in total. This is 10 instances more than `max_size`. The algorithm removes instances from each zone until 10 are removed in total.
   
   The more instances there are in a zone, the more instances you can remove from it. However, at least 5 instances must remain in every zone.

1. One possible allocation option is 9 + 6 + 5.
   
   6 instances are removed from the largest zone (15 before, 9 after), 4 are removed from the medium zone (10 before, 6 after), and nothing is removed from the smallest group, because it already has the minimum allowable number of instances (5).
