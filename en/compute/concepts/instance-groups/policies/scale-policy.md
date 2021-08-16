# Scaling policy

When creating an instance group, you can choose how to increase and decrease the number of VM in the group.

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

Key | Value
--- | ---
`fixed_scale` | A group of fixed-size instances.
`size`* | Number of instances in the group.<br>Valid values are from 0 to 100.

\* Required field.

## auto_scale {#auto-scale-policy}

The `auto_scale` key defines an automatically scalable instance group. The initial size of the group is defined in the `initial_size` key. You can create a group with the desired number of instances within the available [quotas and limits](../../limits.md).

Example of a YAML file entry:

```yaml
scale_policy:
  auto_scale:
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

Key | Value
--- | ---
`auto_scale` | An automatically scaled instance group.
`initial_size`* | Initial number of instances in the group.<br>Valid values are from 0 to 100.
`max_size` | Maximum number of instances in the group.<br>Valid values are from 0 to 100.
`min_zone_size` | Minimum number of instances in one availability zone.<br>Valid values are from 0 to 100.
`measurement_duration`* | Time in seconds allotted for averaging metrics based on CPU load. If the average load at the end of the interval is higher than `cpu_utilization_rule.utilization_target`, {{ ig-name }} increases the number of instances in the group.<br>Valid values are from 60 to 600 seconds.
`warmup_duration`* | The warmup time of the instance. During this time, traffic is sent to the instance, but CPU utilization metrics aren't considered.<br>Valid values are from 0 to 600 seconds.
`stabilization_duration` | The minimum amount of time to monitor CPU utilization before {{ ig-name }} can reduce the number of instances in the group. During this time, the group is not resized, even if the average CPU utilization drops below the `cpu_utilization_rule.utilization_target` value.<br>Valid values are from 60 to 1800 seconds.
`cpu_utilization_rule`* | Sets the target CPU utilization to run scaling based on the average CPU utilization in the instance group.
`utilization_target`* | Target CPU utilization to be supported by {{ ig-name }}.<br>If the average CPU utilization is below the target value, {{ ig-name }} will reduce the number of instances until it reaches `min_zone_size` in each availability zone.<br>If the average CPU utilization is higher than the target value, {{ ig-name }} will create instances until it reaches `max_size`.<br>Valid values are from 10 to 100.

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

Key | Value
--- | ---
`fixed_scale` | A group of fixed-size instances.
`size`* | Number of instances in the group.<br>Valid values are from 0 to 100.
`test_auto_scale` | Test auto scaling parameters.
`initial_size`* | Initial number of instances in the group. It's only used for validating the parameters of the group being created.<br>Valid values are from 1 to 100.
`max_size` | Maximum number of instances in the group.<br>Valid values are from 0 to 100.
`min_zone_size` | Minimum number of instances in one availability zone.<br>Valid values are from 0 to 100.
`measurement_duration`* | Time in seconds allotted for averaging metrics based on CPU load. If the average load at the end of the interval is higher than `cpu_utilization_rule.utilization_target`, {{ ig-name }} increases the number of instances in the group.<br>Valid values are from 60 to 600 seconds.
`warmup_duration`* | The warmup time of the instance. During this time, traffic is sent to the instance, but CPU utilization metrics aren't considered.<br>Valid values are from 0 to 600 seconds.
`stabilization_duration` | The minimum amount of time to monitor CPU utilization before {{ ig-name }} can reduce the number of instances in the group. During this time, the group is not resized, even if the average CPU utilization drops below the `cpu_utilization_rule.utilization_target` value.<br>Valid values are from 60 to 1800 seconds.
`cpu_utilization_rule`* | Sets the target CPU utilization to run scaling based on the average CPU utilization in the instance group.
`utilization_target`* | Target CPU utilization to be supported by {{ ig-name }}.<br>If the average CPU utilization is below the target value, {{ ig-name }} will reduce the number of instances until it reaches `min_zone_size` in each availability zone.<br>If the average CPU utilization is higher than the target value, {{ ig-name }} will create instances until it reaches `max_size`.<br>Valid values are from 10 to 100.

\* Required field.

