# Scaling policy

When creating an instance group, you can choose how to increase and decrease the number of instances in the group.

The policy is defined in the `scale-policy` key in the YAML file.

## fixed_scale {#fixed-scale-policy}

The `fixed_scale` key defines a group of fixed-size instances. The size of the group is defined in the `size` key. You can create a group with the desired number of instances within the available [quotas and limits](../../limits.md).

Example of a YAML file entry:

```yaml
...
scale_policy:
  fixed_scale:
    size: 3
...
```

Keys:

| Key | Value |
| --- | --- |
| `fixed_scale` | A group of fixed-size instances. |
| `size`* | Number of instances in the group.<br>Valid values are from 0 to 100. |

\* Required field.

## auto_scale {#auto-scale-policy}

The `auto_scale` key defines an automatically scalable instance group. The initial size of the group is defined in the `initial_size` key. You can create a group with the desired number of instances within the available [quotas and limits](../../limits.md).

Example of a YAML file entry:

```yaml
scale_policy:
  auto_scale:
    auto_scale_type: ZONAL
    initial_size: 5
    max_size: 15
    min_zone_size: 3
    measurement_duration: 30
    warmup_duration: 60
    stabilization_duration: 120
    cpu_utilization_rule:
      utilization_target: 75
```

Keys:

| Key | Value |
| --- | --- |
| `auto_scale` | An automatically scaled instance group. |
| `auto_scale_type` | [Type of automatic scaling](../scale.md#auto-scale-type).<br/>Valid values: <ul><li>`ZONAL`: For each [availability zone](../../../../overview/concepts/geo-scope.md), its own average metric value for scaling and the required number of instances are calculated.</li><li>`REGIONAL`: The metric value and the number of instances are calculated for the entire group.</li></ul> Default value: `ZONAL`. |
| `initial_size`* | Initial number of instances in the group.<br>Valid values are from 0 to 100. |
| `max_size` | Maximum number of instances in the group.<br>Valid values are from 0 to 100. |
| `min_zone_size` | Minimum number of instances in one availability zone.<br>Valid values are from 0 to 100. |
| `measurement_duration`* | Utilization measurement period: The value of each metric is computed as the average of all the measurements taken during the period in question. If this value turns out to be greater than `cpu_utilization_rule.utilization_target`, {{ ig-name }} will increase the number of VMs in the group.<br>Valid values are between 60 and 600 seconds. |
| `warmup_duration`* | Instance warmup period. This is a period of time following startup that traffic is routed to the VM but the values of metrics from this VM are not used to scale the group. The average values of the group metrics are used instead.<br>Valid values are between 0 and 600 seconds. |
| `stabilization_duration` | Stabilization period. After the number of VMs increases, the group size does not decrease until the end of a stabilization period even if the average value of the metric has dropped below `cpu_utilization_rule.utilization_target`.<br>Valid values are between 60 and 1800 seconds. |
| `cpu_utilization_rule` | Sets the target CPU utilization to run scaling based on the average CPU utilization in the instance group. |
| `utilization_target` | Target CPU utilization to be supported by {{ ig-name }}.<br>If the average CPU utilization is below the target value, {{ ig-name }} will reduce the number of instances until it reaches `min_zone_size` in each availability zone.<br>If the average CPU utilization is higher than the target value, {{ ig-name }} will create instances until it reaches `max_size`.<br>Valid values are from 10 to 100. |

\* Required field.

## test_auto_scale {#test-auto-scale-policy}

The `test_auto_scale` key defines a group of fixed-size instances with auto scaling testing enabled. The **Monitoring** tab charts display the recommended increase or decrease in the number of instances depending on the value of the selected metric, while the actual number of instances always remains equal to the value specified in the `size` key. You can create a group with the desired number of instances within the available [quotas and limits](../../limits.md).

```yaml
scale_policy:
  fixed_scale:
    size: 5
  test_auto_scale:
    initial_size: 5
    max_size: 15
    min_zone_size: 3
    measurement_duration: 30
    warmup_duration: 60
    stabilization_duration: 120
    cpu_utilization_rule:
      utilization_target: 75
```

Keys:

| Key | Value |
| --- | --- |
| `fixed_scale` | A group of fixed-size instances. |
| `size`* | Number of instances in the group.<br>Valid values are from 0 to 100. |
| `test_auto_scale` | Test auto scaling parameters. |
| `initial_size`* | Initial number of instances in the group. It's only used for validating the parameters of the group being created.<br>Valid values are from 1 to 100. |
| `max_size` | Maximum number of instances in the group.<br>Valid values are from 0 to 100. |
| `min_zone_size` | Minimum number of instances in one availability zone.<br>Valid values are from 0 to 100. |
| `measurement_duration`* | Time in seconds allotted for averaging metrics based on CPU load. If the average load at the end of the interval is higher than `cpu_utilization_rule.utilization_target`, {{ ig-name }} increases the number of instances in the group.<br>Valid values are from 60 to 600 seconds. |
| `warmup_duration`* | Warm-up period for the instance. During this time, traffic is sent to the instance, but CPU utilization metrics aren't considered.<br>Valid values are from 0 to 600 seconds. |
| `stabilization_duration` | The minimum amount of time to monitor CPU utilization before {{ ig-name }} can reduce the number of instances in the group. During this time, the group is not resized, even if the average CPU utilization drops below the `cpu_utilization_rule.utilization_target` value.<br>Valid values are from 60 to 1800 seconds. |
| `cpu_utilization_rule`* | Sets the target CPU utilization to run scaling based on the average CPU utilization in the instance group. |
| `utilization_target`* | Target CPU utilization to be supported by {{ ig-name }}.<br>If the average CPU utilization is below the target value, {{ ig-name }} will reduce the number of instances until it reaches `min_zone_size` in each availability zone.<br>If the average CPU utilization is higher than the target value, {{ ig-name }} will create instances until it reaches `max_size`.<br>Valid values are from 10 to 100. |

\* Required field.
