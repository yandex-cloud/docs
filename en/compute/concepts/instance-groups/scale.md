# Scaling types

Choose the instance group scaling type when creating each group. The type determines how the number of instances in the group is changed: [automatically](#auto-scale) or [manually](#fixed-scale).

## Manually scaled groups {#fixed-scale}

You can [create fixed-size instance groups](../../operations/instance-groups/create-fixed-group.md) and manage their size manually based on your current computing needs.

## Automatically scaled groups {#auto-scale}

When [creating an automatically scaled instance group](../../operations/instance-groups/create-autoscaled-group.md), you specify the target metric value, while the service continuously re-adjusts the number of instances:

* If the average metric value rises above the target, {{ ig-name }} creates new instances in the group.
* If the average value decreases so that it's below the target value with a smaller group, then {{ ig-name }} deletes unnecessary instances.

This is done to ensure that the average metric value within the same [availability zone](../../../overview/concepts/geo-scope.md) or the entire group (depending on the [automatic scaling type](#auto-scale-type)) does not deviate much from the target value.

> For example, there are 4 instances in an availability zone with an average metric value of 70 and target value of 80. {{ ig-name }} doesn't reduce the group size, because as you delete an instance, the average value surpasses the target value: 4 × 70 / 3 = 93.3. When the average value drops to 60, {{ ig-name }} deletes one instance since the average value doesn't surpass the target: 4 × 60 / 3 = 80.

For automatically scaled groups, assign [common scaling settings](#auto-scale-settings) and [metric](#metrics) settings.

### Type of automatic scaling {#auto-scale-type}

The service can adjust the number of instances separately in each [availability zone](../../../overview/concepts/geo-scope.md) specified in the group settings or in the entire instance group:

* If _zonal_ scaling is used, the service calculates for each availability zone its own average metric value for scaling and the required number of instances. The default type of automatic scaling is zonal.
* If _regional_ scaling is used, the metric value and the number of instances are calculated for the entire group. To change the group's auto scaling type to regional, pass the [`auto_scale` scaling policy](policies/scale-policy.md#auto-scale-policy) with the `auto_scale_type: REGIONAL` key.

### General settings {#auto-scale-settings}

To reduce adjustment sensitivity, {{ ig-name }} lets you configure:

* *Stabilization period*: After the number of instances in the group increases, instances aren't deleted until the end of the stabilization period, even if the average metric value is fairly low.

* *Warm-up period*: The period during which the following isn't used after an instance starts.
  * [CPU utilization](#cpu-utilization).
  * [Monitoring metric](#monitoring-metrics) values that are applied according to the `UTILIZATION` rule.

  Average metric values for the group are used instead.

* *Utilization measurement period*: The metric value is calculated as the average of all measurements made during the specified period.

  > For example, the CPU load may rise to 100% one second and drop to 10% the next. To ignore such surges, {{ ig-name }} uses average values for a given period, such as 1 minute.

You can also set limits on the number of instances per group:

* *Maximum group size*: {{ ig-name }} won't create more instances if a group already contains this many.
* *Minimum size in a single availability zone*: {{ ig-name }} won't delete instances from an availability zone if there are only this many instances in the zone.

### Metrics for automatic scaling {#metrics}

You can use the following metrics for automatic scaling:

* [CPU utilization](#cpu-utilization).
* [Any metrics](#monitoring-metrics) from [{{ monitoring-full-name }}](/docs/monitoring/).

#### CPU utilization {#cpu-utilization}

{{ ig-name }} can control the group size to maintain average CPU utilization within the target level. The average CPU utilization is calculated for an instance separately from each availability zone or from the entire group (for the [zonal or regional scaling](#auto-scale-type) type, respectively).

Let's look at the algorithm of service actions outside the stabilization period:

1. Calculate the average CPU utilization during the specified measurement period for each instance, except those in the warm-up period. The load is measured several times per minute on every instance.

1. Use the obtained values to calculate the average load for each availability zone or across the entire group.

   > For example, a group of 4 instances is located in one availability zone. One of the instances starts, while the others are under 90%, 75%, and 85% workload on average during the measurement period. Average load across the zone: (90+75+85) / 3 = 83.4%

1. Obtain the total load: multiply the resulting average load by the total number of instances.

   > In the example, 83.4 × 4 = 333.6%

1. Divide the total load by the target load level to obtain the number of instances needed (the result is rounded up).

   > Say, for example, the target level is 75%. This means that you need 333.6 / 75 = 4.48 ~ 5 instances. Based on the approximate results, you need to create another instance.

After the number of instances is calculated and changed (if necessary), {{ ig-name }} starts calculating the average load again.

#### Monitoring metrics {#monitoring-metrics}

You can use any {{ monitoring-name }} metrics for automatic scaling in {{ ig-name }}.

When using monitoring metrics, specify the following in {{ ig-name }}:

* _The name of the metric_ that you specified in {{ monitoring-name }}.

* _[Labels](../../../monitoring/concepts/data-model.md#label)_ that you specified in {{ monitoring-name }}:
  * (optional) `folder_id`: ID of the folder. By default, it's the ID of the folder that the group belongs to.
  * (optional) `service`: ID of the service. By default, `custom`. Labels can be used to specify service metrics, such as `service` with the `compute` value for {{ compute-short-name }}.

  Also specify other labels that characterize this metric.

* _The metric type_ that affects how {{ ig-name }} computes the average metric value:
  * `GAUGE`: Used for metrics that show the metric value at a specific point in time, such as the number of requests per second to a server running on an instance. {{ ig-name }} computes the average metric value for the specified averaging period.
  * `COUNTER`: Used for metrics that grow uniformly over time, such as the total number of requests to a server running on an instance. {{ ig-name }} calculates the average metric growth for the specified averaging period.

* _Metric rule type_:

  * `UTILIZATION`: The metric characterizes resource consumption by a single instance.

    The number of instances per availability zone or in the entire group (for the [zonal or regional scaling](#auto-scale-type) type, respectively) by the `UTILIZATION` metric is calculated in the same way as the number of instances by [CPU utilization](#cpu-utilization).

    When delivered in {{ monitoring-name }}, the `UTILIZATION` metric must have the `instance_id` label.

  * `WORKLOAD`: The metric characterizes the total workload on all instances in a single availability zone or the entire group (for the [zonal or regional scaling](#auto-scale-type) type, respectively).

    To calculate the number of instances per availability zone or in the entire group by the `WORKLOAD` metric, the average metric value is divided by the target value and the result is rounded up.

    > For example, there are two instances in an availability zone. The metric characterizes the total number of requests per second (RPS) to all instances. If the target metric value is 200, then, with an average value of 450, {{ ig-name }} will increase the number of instances in the availability zone to three: 450/200 = 2.25 ~ 3 instances.

    The metric value is calculated and used including during the instance warm-up period specified in the [general settings](#auto-scale-settings).

    If zonal scaling is applied to the group, when delivered in {{ monitoring-name }}, the `WORKLOAD` metric must have the `zone_id` label.

* _The target metric value_ that {{ ig-name }} uses to calculate the required number of instances. For `UTILIZATION` metrics, the target value is the desired level of resource consumption by each instance. For `WORKLOAD` metrics, it's the maximum allowed workload on each instance.

#### See also {#see-also}

* [{#T}](policies/scale-policy.md).
* [{#T}](../../operations/instance-groups/create-fixed-group.md).
* [{#T}](../../operations/instance-groups/create-autoscaled-group.md).
