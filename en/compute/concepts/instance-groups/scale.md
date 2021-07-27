---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Scaling types

Choose the instance group scaling type when creating each group. The type determines whether the number of instances in the group will change automatically or manually.

## Manually scaled groups {#fixed-scale}

You can create fixed size instance groups and manage their size manually based on your current computing needs.

## Automatically scaled groups {#auto-scale}

When creating an automatically scaled group, you specify the target metric value, and the service continuously re-adjusts the number of instances so that the average metric value within the same [availability zone](../../../overview/concepts/geo-scope.md) doesn't deviate much:

* If the average metric value rises above the target, {{ ig-name }} creates new instances in the group.

* If the average value decreases so that it's below the target value with a smaller group, then {{ ig-name }} deletes the unnecessary instances.

    For example, there are 4 instances in an availability zone with an average metric value of 70 and target value of 80. {{ ig-name }} doesn't reduce the group size, because as you delete an instance, the average value surpasses the target value: 4 × 70 / 3 = 93.3. When the average value drops to 60, {{ ig-name }} deletes one instance since the average value doesn't surpass the target: 4 × 60 / 3 = 80.

For automatically scaled groups, assign [common scaling settings](#auto-scale-settings) and [metric](#metrics) settings.

### Common settings {#auto-scale-settings}

To reduce adjustment sensitivity, {{ ig-name }} lets you configure:

* *Stabilization period*: After the number of instances in the group increases, instances aren't deleted until the end of the stabilization period, even if the average metric value is fairly low.

* *Warm-up period*: The period during which data from an instance isn't used after it starts. Average metric values for the group are used instead.

    Instances warming up may demonstrate abnormally high load. To ignore these values, specify the appropriate warm-up period.

* *Averaging period*: All metric values are averaged over this period.

    For example, the CPU load may rise to 100% one second and drop to 10% the next. To ignore such surges, {{ ig-name }} uses average values for a specified period, like 1 minute.

You can also set limits on the number of instances per group:

* *Maximum group size*: {{ ig-name }} won't create more instances if a group already contains this many.
* *Minimum size in a single availability zone*: {{ ig-name }} won't delete instances from an availability zone if there are only this many instances in the zone.

### Metrics for automatic scaling {#metrics}

You can use the following metrics for automatic scaling:

* [CPU utilization](#cpu-utilization).
* [Custom metrics](#custom-metrics) from [{{ monitoring-full-name }}](/docs/monitoring/).

#### CPU utilization {#cpu-utilization}

{{ ig-name}} can control the group size to maintain average CPU utilization at the target level. Average CPU utilization is calculated for instances in the same group and availability zone.

Let's look at the algorithm of service actions outside the stabilization period:

1. Calculate average CPU utilization for each instance, except those in the warm-up period. The load is measured several times per minute on every instance. The resulting values are averaged for each instance over the averaging period you set during group creation.

1. Calculate the average load on each instance and additionally average it across availability zones.

   For example, a group of 4 instances is located entirely in one zone. One of the instances starts, while the others are under 90%, 75%, and 85% workload. Average load across the zone: (90+75+85) / 3 = 83.4%

1. Obtain the total load: multiply the resulting average load by the total number of instances. In the example, 83.4 × 4 = 333.6%

1. Divide the total load by the target load level per zone to obtain the number of instances needed (the result is rounded up). Say, for example, the target level is 75%. This means that you need 333.6 / 75 = 4.48 ~ 5 instances.

Based on the approximate results, you need to create another instance. {{ ig-name }} starts this process, and begins calculating the average load again.

#### Custom metrics {#custom-metrics}

If you [save a custom metric](../../../monitoring/operations/metric/add.md) in {{ monitoring-full-name }}, you can use the values from this metric for automatically scaling in {{ ig-name }}.

When saving metrics, specify additional labels in {{ monitoring-name }}:

* `instance_group_id`: The ID of the instance group.
* `zone_id`: The ID of the availability zone if the metric value is calculated for all instances in the same zone.
* `instance_id`: The ID of the instance if the metric value is calculated separately for each instance.

When using this metric, specify the following in {{ ig-name }}:

* _The name of the metric_ that you specified in {{ monitoring-full-name }}.
* _The target metric value_ that {{ ig-name }} should support.
* _The metric type_ that affects how {{ ig-name }} computes the average metric value:
  * `GAUGE`: Used for metrics that show the metric value at a specific point in time, such as the number of requests per second to a server running on an instance. {{ ig-name }} computes the average metric value for the specified averaging period.
  * `COUNTER`: Used for metrics that grow uniformly over time, such as the total number of requests to a server running on an instance. {{ ig-name }} calculates the average metric growth for the specified averaging period.
* _Metric rule type_:
  * `UTILIZATION`: The metric is applied to a single instance. {{ ig-name }} first calculates the average metric value for each instance, then averages the values for instances in one availability zone. This type of metric must have the `instance_id` label.
  * `WORKLOAD`: The metric applies to instances in one availability zone. This type of metric must have the `zone_id` label.

#### See also {#see-also}

- [{#T}](policies/scale-policy.md).
- [{#T}](../../operations/instance-groups/create-fixed-group.md).
- [{#T}](../../operations/instance-groups/create-autoscaled-group.md).

