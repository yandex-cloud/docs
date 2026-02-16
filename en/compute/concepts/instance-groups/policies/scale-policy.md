# Scaling policy

When creating an instance group, you can choose how to increase and decrease the number of instances in the group.

The policy is defined in the `scale_policy` key in the YAML file.

## fixed_scale {#fixed-scale-policy}

The `fixed_scale` key defines a fixed-size instance group. The group size is defined in the `size` key. You can create a group with the required number of instances within the available [quotas and limits](../../limits.md).

Here is how a YAML file entry may look like:

```yaml
...
scale_policy:
  fixed_scale:
    size: 3
...
```

Where:

Key | Value
--- | ---
`fixed_scale` | Fixed-size instance group
`size`* | Number of VM instances in the group.<br>Acceptable values: 0 to 100.

\* This is a required field.

## auto_scale {#auto-scale-policy}

The `auto_scale` key defines an automatically scalable instance group. The initial size of the group is defined in the `initial_size` key. You can create a group with the required number of instances within the available [quotas and limits](../../limits.md).

The VM instance group will be scaled based on the specified metrics: [CPU utilization](../scale.md#cpu-utilization) (the `cpu_utilization_rule` key) and/or [{{ monitoring-full-name }} metrics](../scale.md#monitoring-metrics). If multiple metrics are specified in the file, the largest estimated VM instance group size is used.

Here is how a YAML file entry may look like:

```yaml
scale_policy:
  auto_scale:
    auto_scale_type: REGIONAL
    initial_size: 5
    max_size: 15
    min_zone_size: 3
    measurement_duration: 30s
    warmup_duration: 60s
    stabilization_duration: 120s
    cpu_utilization_rule:
      utilization_target: 75
    custom_rules:
    - rule_type: WORKLOAD
      metric_type: GAUGE
      metric_name: queue.messages.stored_count
      labels:
        queue: dj6000000002********
      target: 5
```

Where:

Key | Value
--- | ---
`auto_scale` | Automatically scaled instance group
`auto_scale_type` | [Type of automatic scaling](../scale.md#auto-scale-type).<br/>The possible values are: <ul><li>`ZONAL` (zonal scaling): For each [availability zone](../../../../overview/concepts/geo-scope.md), its own [average scaling metric value](../scale.md#average-metric) and required number of instances are calculated.</li><li>`REGIONAL` (regional scaling): The metric value and the number of instances are calculated for the entire group.</li></ul> The default value is `ZONAL`.
`initial_size`* | Initial number of instances in the group.<br>The values range from 1 to 100.
`max_size` | Maximum number of VM instances in the group.<br>Acceptable values: 0 to 100.
`min_zone_size` | Minimum number of VM instances per availability zone.<br>Acceptable values: 0 to 100.
`measurement_duration` | Utilization measurement period: The value of each metric is computed as the average of all measurements taken during the period in question. If this value exceeds the target [scaling metric](../scale.md#metrics) value, {{ ig-name }} will increase the number of VM instances in the group.<br>The acceptable values range from 60 to 600 seconds. The default value is 60 seconds.
`warmup_duration` | Instance warmup period. This is a period of time following startup during which the traffic is routed to the VM, while the values of metrics from this VM are not used to scale the group. The average values of the group metrics are used instead.<br>The acceptable values range from 0 to 600 seconds. The default value is zero seconds.
`stabilization_duration` | Stabilization period. After the number of VM instances increases, the group size does not decrease until the stabilization period ends, even if the [average scaling metric value](../scale.md#average-metric) drops below the target level.<br>The acceptable values range from 60 to 1,800 seconds.
`cpu_utilization_rule` | Sets the target CPU utilization to run scaling based on the average CPU utilization in the instance group.
`utilization_target` | Target CPU utilization to be supported by {{ ig-name }}.<br>If the average CPU utilization is below the target value, {{ ig-name }} will reduce the number of instances until it reaches `min_zone_size` in each availability zone.<br>If the average CPU utilization is higher than the target value, {{ ig-name }} will be creating instances until it reaches `max_size`.<br>The values range from 10 to 100.
`custom_rules` | List of [metrics from {{ monitoring-full-name }}](../scale.md#monitoring-metrics) for automatic scaling. It can include up to three metrics.
`rule_type` | Metric rule type:<ul><li>`UTILIZATION`: For metrics describing resource utilization per VM instance.</li><li>`WORKLOAD`: For metrics describing total workload on all VM instances.</li></ul>For more information, see [{#T}](../scale.md#monitoring-metrics).
`metric_type` | Type of metric:<ul><li>`GAUGE`: Metric reflects the value at particular time point.</li><li>`COUNTER`: Metric exhibits a monotonous growth over time.</li></ul>For more information, see [{#T}](../scale.md#monitoring-metrics).
`metric_name` | Name of the metric in {{ monitoring-name }}.
`labels` | Metrics [labels](../../../../monitoring/concepts/data-model.md#label) from {{ monitoring-name }}.
`target` | Target metric value by which {{ ig-name }} calculates the number of required VM instances. For more information, see [{#T}](../scale.md#monitoring-metrics). 

\* This is a required field.

## test_auto_scale {#test-auto-scale-policy}

The `test_auto_scale` key defines a fixed-size instance group with autoscaling testing enabled. The **{{ ui-key.yacloud.common.monitoring }}** tab charts present recommendations on how much to increase or decrease the number of instances depending on the selected metric value; the actual number of instances always remains equal to the `size` key value. You can create a group with the required number of instances within the available [quotas and limits](../../limits.md).

```yaml
scale_policy:
  fixed_scale:
    size: 5
  test_auto_scale:
    initial_size: 5
    max_size: 15
    min_zone_size: 3
    measurement_duration: 30s
    warmup_duration: 60s
    stabilization_duration: 120s
    cpu_utilization_rule:
      utilization_target: 75
```

For `test_auto_scale`, use the same keys [as for `auto_scale`](#auto-scale-policy).

## Use cases {#examples}

* [{#T}](../../../tutorials/vm-autoscale/index.md)

#### See also {#see-also}

* [{#T}](healing-policy.md)
* [{#T}](allocation-policy.md)
* [{#T}](deploy-policy.md)
