# Scaling types

When creating each instance group, you will need to choose its scaling type, which determines whether the number of instances in the group will change [automatically](#auto-scale) or [manually](#fixed-scale).

{% note info %}

If you [pause processes](stopping-pausing.md) (switch them to the `PAUSED` [status](statuses.md#group-statuses)) in an instance group, it will not scale up.

{% endnote %}

## Manually scaled groups {#fixed-scale}

You can [create fixed-size instance groups](../../operations/instance-groups/create-fixed-group.md) and manage their size manually based on your current computing needs.

## Automatically scaled groups {#auto-scale}

When [creating an automatically scaled instance group](../../operations/instance-groups/create-autoscaled-group.md), you specify the target metric value, while the service continuously re-adjusts the number of instances:

* If the [average metric value](#average-metric) exceeds the target, {{ ig-name }} will create new instances in the group.
* If the average value decreases below the target value with a smaller group, {{ ig-name }} will delete unnecessary instances.

This is done to ensure that the average metric value within the same [availability zone](../../../overview/concepts/geo-scope.md) or the entire group (depending on the [automatic scaling type](#auto-scale-type)) does not differ much from the target value.

> For example, let's assume there are 4 instances in an availability zone with an average metric value of 70 and target value of 80. {{ ig-name }} will not reduce the group size, because as you delete an instance, the average value will be larger than the target one: 4 × 70 / 3 = 93.3. When the average value drops to 60, {{ ig-name }} will delete one instance since the average value does not surpass the target: 4 × 60 / 3 = 80.

If multiple metrics are specified in the settings, the largest estimated instance group size is used.

For automatically scaled groups, you need to specify [common scaling settings](#auto-scale-settings) and [metric](#metrics) settings.

### Type of automatic scaling {#auto-scale-type}

{{ ig-name }} can adjust the number of instances separately in each [availability zone](../../../overview/concepts/geo-scope.md) specified in the group settings or in the entire instance group:

* With _zonal_ scaling, {{ ig-name }} will calculate the [average metric value](#average-metric) for scaling and required number of instances separately for each availability zone. This type of automatic scaling is used by default.
* With _regional_ scaling, the metric value and the number of instances are calculated for the entire group. To change the group auto scaling type to regional, [specify the `auto_scale` scaling policy](policies/scale-policy.md#auto-scale-policy) with the `auto_scale_type: REGIONAL` key.


### General settings {#auto-scale-settings}

To reduce adjustment sensitivity, with {{ ig-name }}, you can configure:
* *Stabilization period*: After the number of VMs increases, the group size will not decrease until the stabilization period ends, even if the [average metric value](#average-metric) has dropped low enough.
* *Warm-up period*: Period during which the VM, upon its start, will not use:

  * [CPU utilization](#cpu-utilization).
  * [Monitoring metric](#monitoring-metrics) values that are applied according to the `UTILIZATION` rule.

  Average metric values for the group will be used instead.
* *Utilization measurement period*: Metric value will be calculated as an average of all measurements taken during the specified period.

  > For example, the CPU load may rise to 100% in one second and then drop to 10%. To ignore such surges, {{ ig-name }} will use average values for the specified period, such as one minute.

You can also set limits on the number of instances per group:
* *Maximum group size*: {{ ig-name }} will not create more instances if a group already contains this many.
* *Minimum size in a single availability zone*: {{ ig-name }} will not delete instances from an availability zone if there are only this many instances in the zone.

### Metrics for automatic scaling {#metrics}

You can use the following metrics for automatic scaling:

* [CPU utilization](#cpu-utilization).
* [Any metrics](#monitoring-metrics) from [{{ monitoring-full-name }}](../../../monitoring/index.yaml).

#### CPU utilization {#cpu-utilization}

{{ ig-name }} can control the group size to maintain average CPU utilization within the target level. The average CPU utilization is calculated for an instance separately from each availability zone or from the entire group (for the [zonal or regional scaling type](#auto-scale-type), respectively).

Here is what {{ ig-name }} will do outside the stabilization period:
1. Calculate the average CPU utilization during the specified measurement period for each instance, except those that are still warming up. The load is measured several times per minute on every instance.
1. Use the obtained values to calculate the average load for each availability zone or across the entire group.

   > For example, let's assume there is a group of four instances located in one availability zone. One of the instances starts, while the others are under 90%, 75%, and 85% workload on average during the measurement period. The average load across the zone is: (90+75+85) / 3 = 83.4%

1. Obtain the total load, i.e., multiply the resulting average load by the total number of instances.

   > In our example, it is 83.4 × 4 = 333.6%

1. Divide the total load by the target load level to obtain the number of instances required (the result is rounded up).

   > Say, for example, the target level is 75%. This means that you need 333.6 / 75 = 4.48 ~ 5 instances. Based on the approximate results, you need to create another instance.

Once the number of instances is calculated and changed (if required), {{ ig-name }} will start calculating the average load again.

#### Monitoring metrics {#monitoring-metrics}

You can use up to three {{ monitoring-name }} metrics for automatic scaling in {{ ig-name }}. To read the metrics, the [service account](../../../iam/concepts/users/service-accounts.md) linked to the instance group needs at least the `monitoring.viewer` [role](../../../monitoring/security/index.md#monitoring-viewer).

When using monitoring metrics, specify the following in {{ ig-name }}:
* _Metric name_ you specified in {{ monitoring-name }}.
 * _[Labels](../../../monitoring/concepts/data-model.md#label)_ you specified in {{ monitoring-name }}:
  * (optional) `folder_id`: ID of the folder. By default, it is the ID of the folder the group belongs to.
  * (optional) `service`: ID of the service. The default value is `custom`. Labels can be used to specify service metrics, such as `service` with the `compute` value for {{ compute-short-name }}.

  You will also need specify other labels for this metric:

* _Metric type_ that affects how {{ ig-name }} will calculate the [average metric value](#average-metric):
  * `GAUGE`: Used for metrics that show the metric value at a specific point in time, such as the number of requests per second to a server running on an instance. {{ ig-name }} computes the average metric value for the specified averaging period.
  * `COUNTER`: Used for metrics that grow uniformly over time, such as the total number of requests to a server running on an instance. {{ ig-name }} calculates the average metric growth for the specified averaging period.
* _Metric rule type_:
  * `UTILIZATION`: Metric will show resource consumption by a single instance.

    The number of instances per availability zone or in the entire group (for the [zonal or regional scaling type](#auto-scale-type), respectively) by the `UTILIZATION` metric is calculated in the same way as the number of instances by [CPU utilization](#cpu-utilization).

    When delivered in {{ monitoring-name }}, the `UTILIZATION` metric must have the `instance_id` label.

  * `WORKLOAD`: Metric will show the total workload on all instances in a single availability zone or the entire group (for the [zonal or regional scaling type](#auto-scale-type), respectively).

    To calculate the number of instances per availability zone or in the entire group by the `WORKLOAD` metric, the average metric value is divided by the target value, and the result is rounded up.

    > For example, let's assume there are two instances in an availability zone. The metric shows the total number of requests per second (RPS) to all instances. If the target metric value is 200, then, with an average value of 450, {{ ig-name }} will increase the number of instances in the availability zone to three: 450/200 = 2.25 ~ 3 instances.

    The metric value is also calculated and used during the instance warm-up period specified in the [general settings](#auto-scale-settings).

    If zonal scaling is applied to the group, when delivered in {{ monitoring-name }}, the `WORKLOAD` metric must have the `zone_id` label.
* _Target metric value_ by which {{ ig-name }} calculates the required number of VM instances. For `UTILIZATION` metrics, the target value is the required level of resource consumption by each instance. For `WORKLOAD` metrics, it is the maximum allowed workload on each instance.

### Calculating the average metric value {#average-metric}

The average metric value is calculated using an [_exponential moving average_](https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average). This makes autoscaling sensitive to metric spikes while smoothing out peaks.

The _normal average_ is calculated using the following formula:

$$\begin{array}{c}
\frac{\int_a^b f(x)dx}{b - a}
\end{array}{}
,
$$

where $f(x)$ is the function of the metric in the $[ a, b ]$ time range.

There may be spikes in metric values over the entire $[ a, b ]$ time range. The normal average is calculated without regard to when the spike occurred — whether closer to the beginning or end of the time range. This can cause a VM group to scale excessively and increase the costs of resources.

To account for the time of a metric spike, an exponential moving average is used:

$$\begin{array}{c}
\frac{\int_a^b f(x)w(x)dx}{\int_a^b w(x)dx}
\end{array}{}
,
$$

where $w(x)$ is the $w(x) = k^{-(x - a)}$, $k \in (0, 1)$ weight function allowing you to assign larger weights to the $f(x)$ function values at the end of the $b$ segment, i.e., closer to the current time.

The $k$ factor depends on how long the metric is measured and is calculated using this formula:

$$\begin{array}{c}
k=\frac{1}{exp(10/t)}
\end{array}{}
,
$$

where $t$ is the time of measuring the metric in seconds, $t = b - a$.

#### See also {#see-also}

* [{#T}](policies/scale-policy.md)
* [{#T}](../../operations/instance-groups/create-fixed-group.md)
* [{#T}](../../operations/instance-groups/create-autoscaled-group.md)
