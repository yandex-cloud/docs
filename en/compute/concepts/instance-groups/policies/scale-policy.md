# Scaling policy

When creating an instance group, you can choose how to increase and decrease the number of instances in the group.

The policy is defined in the `scale_policy` key in the YAML file.

## `fixed_scale` key {#fixed-scale-policy}

The `fixed_scale` key defines a group of fixed-size instances. The size of the group is defined in the `size` key. You can create a group with the required number of instances within the available [quotas and limits](../../limits.md).

Here is how a YAML file entry may look like:

```yaml
...
scale_policy:
  fixed_scale:
    size: 3
...
```

Where:

| Key | Value |
--- | ---
| `fixed_scale` | Fixed-size instance group |
| `size`* | Number of instances in the group.<br>Valid values range from 0 to 100. |

\* Required field.

## `auto_scale` key {#auto-scale-policy}

The `auto_scale` key defines an automatically scalable instance group. The initial size of the group is defined in the `initial_size` key. You can create a group with the required number of instances within the available [quotas and limits](../../limits.md).

The VM instance group will be scaled based on specified metrics: [CPU utilization](../scale.md#cpu-utilization) (the `cpu_utilization_rule` key) and/or [metrics from {{ monitoring-full-name }}](../scale.md#monitoring-metrics). If multiple metrics are specified in the file, the largest estimated VM instance group size is used.

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
        queue: dj600000000220a507nq
      target: 5
```

Where:

| Key | Value |
--- | ---
| `auto_scale` | Automatically scaled instance group |
| `auto_scale_type` | [Type of automatic scaling](../scale.md#auto-scale-type).<br/>Valid values: <ul><li>`ZONAL`: For each [availability zone](../../../../overview/concepts/geo-scope.md), its own average metric value for scaling and the required number of instances are calculated.</li><li>`REGIONAL`: The metric value and the number of instances are calculated for the entire group.</li></ul> The default value is `ZONAL`. |
| `initial_size`* | Initial number of instances in the group.<br>Valid values range from 0 to 100. |
| `max_size` | Maximum number of instances in the group.<br>Valid values range from 0 to 100. |
| `min_zone_size` | Minimum number of instances in one availability zone.<br>Valid values range from 0 to 100. |
| `measurement_duration` | Utilization measurement period: The value of each metric is computed as the average of all measurements taken during the period in question. If this value exceeds the target value of the [metric for scaling](../scale.md#metrics), {{ ig-name }} will increase the number of VM instances in the group.<br>The valid values are within 60 and 600 seconds. The default value is 60 seconds. |
| `warmup_duration` | Instance warmup period. This is a period of time following startup during which the traffic is routed to the VM, while the values of metrics from this VM are not used to scale the group. The average values of the group metrics are used instead.<br>The valid values range between 0 and 600 seconds. The default value is 0 seconds. |
| `stabilization_duration` | Stabilization period. After the number of VM instances increases, the group size does not decrease until the end of the stabilization period, even in case the average value of the metric for scaling drops below the target level.<br>The valid values range between 60 and 1800 seconds. |
| `cpu_utilization_rule` | Sets the target CPU utilization to run scaling based on the average CPU utilization in the instance group. |
| `utilization_target` | Target CPU utilization to support by {{ ig-name }}.<br>If the average CPU utilization is below the target value, {{ ig-name }} will reduce the number of instances until it reaches `min_zone_size` in each availability zone.<br>If the average CPU utilization is higher than the target value, {{ ig-name }} will create instances until `max_size` is reached.<br>Valid values range from 10 to 100. |
| `custom_rules` | List of [metrics from {{ monitoring-full-name }}](../scale.md#monitoring-metrics) for automatic scaling. It can include up to three metrics. |
| `rule_type` | Metric rule type:<ul><li>`UTILIZATION`: For metrics of resource utilization per VM instance.</li><li>`WORKLOAD`: For metrics of the total workload on all VM instances.</li></ul>For more information, see [{#T}](../scale.md#monitoring-metrics). |
| `metric_type` | Type of metric:<ul><li>`GAUGE`: Metric shows the value at a certain point in time.</li><li>`COUNTER`: Metric grows uniformly over time.</li></ul>For more information, see [{#T}](../scale.md#monitoring-metrics). |
| `metric_name` | Name of the metric in {{ monitoring-name }}. |
| `labels` | Metrics [labels](../../../../monitoring/concepts/data-model.md#label) from {{ monitoring-name }}. |
| `target` | Target metric value by which {{ ig-name }} calculates the number of required VM instances. For more information, see [{#T}](../scale.md#monitoring-metrics). |

\* Required field.

## `test_auto_scale` key {#test-auto-scale-policy}

The `test_auto_scale` key defines a fixed-size instance group with auto scaling testing enabled. The **{{ ui-key.yacloud.compute.group.switch_monitoring }}** tab charts display the recommended increase or decrease in the number of instances depending on the value of the selected metric, while the actual number of instances always remains equal to the value specified in the `size` key. You can create a group with the required number of instances within the available [quotas and limits](../../limits.md).

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

#### See also {#see-also}

* [{#T}](healing-policy.md)
* [{#T}](allocation-policy.md)
* [{#T}](deploy-policy.md)
