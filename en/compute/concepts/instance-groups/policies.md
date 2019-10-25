# Policies

When creating an instance group, you need to define _policies_ for deploying, checking, and scaling instances and selecting zones.

The policy description and [instance template](instance-template.md) description are passed to the CLI as a YAML file when creating or updating an instance group with the `--file` flag. This is convenient for passing values consisting of multiple strings. For more information, see [{#T}](../../operations/instance-groups/create-fixed-group.md).

## Allocation policy {#allocation-policy}

When creating an instance group, you can choose the regions and availability zones of Yandex.Cloud for hosting instances.

A region is a specific geographic location where you can deploy instances. Each region consists of one or more zones. Only one region is currently available. [Learn more about Yandex.Cloud geography](../../../overview/concepts/geo-scope.md).

Regions:

| Region | Zones | Location |
| ----- | ----- | ----- |
| `ru-central1` | `ru-central1-a`<br/>`ru-central1-b`<br/>`ru-central1-c` | Moscow, Ryazan, and Vladimir regions. |

You can't move instances to other availability zones, but you can [update a group](../../operations/instance-groups/update.md) with new zone values.

The allocation policy is defined in the `allocation-policy` key in the YAML file. The value can be the list of zones defined in the `zones` key. You can specify any available zones to evenly distribute the group instances across.

Example of a YAML file entry:

```
...
allocation_policy:
    zones:
        - zone_id: ru-central1-a
        - zone_id: ru-central1-b
        - zone_id: ru-central1-c
...
```

Keys:

| Key | Value |
| ----- | ----- |
| `zones` | Zone list. Each zone is defined in the `zone_id` key as a `key-value` pair. |
| `zone_id` | Zone ID. |

## Deployment policy {#deploy-policy}

When creating an instance group, you can choose how the instances will be deployed in the group.

The deployment policy is a set of restrictions defined in the `deploy-policy` key in the YAML file. Each restriction is set in its own key as a `key-value` pair.

Example of a YAML file entry:

```
...
deploy_policy:
    max_creating: 10
    max_deleting: 10
    max_unavailable: 10
    max_expansion: 0
    startup_duration: 30s
...
```

Keys:

| Key | Value |
| ----- | ----- |
| `max_creating` | The maximum number of instances that can be created at the same time. |
| `max_deleting` | The maximum number of instances that can be deleted at the same time. |
| `max_unavailable` | The maximum number of instances in the `RUNNING` state that can be removed in order to reduce the target size of the group. |
| `max_expansion` | The maximum number of instances that can be additionally allocated in order to expand the target size of the group. If the `max_unavailable` key is not specified or is zero, then the `max_expansion` key value must be non-zero. |
| `startup_duration` | Startup duration of an instance in the group. The instance starts receiving traffic only after the startup time expires and all the health checks are passed. |

## Scaling policy {#scale-policy}

When creating an instance group, you can choose how to increase or decrease the number of instances in the group.

The policy is defined in the `scale-policy` key in the YAML file.

#### fixed_scale {#fixed-scale-policy}

The `fixed_scale` key defines a group of fixed-size instances. The size of the group is defined in the `size` key. You can create a group with the desired number of instances within the available [quotas and limits](../limits.md).

Example of a YAML file entry:

```
...
scale_policy:
    fixed_scale:
        size: 3
...
```

Keys:

| Key | Value |
| ----- | ----- |
| `fixed_scale` | A group of fixed-size instances. |
| `size`* | Number of instances in the group. Each group may contain a maximum of 100 instances. |

\* Required field.

#### auto_scale {#auto-scale-policy}

The `auto_scale` key defines automatically scalable instance group. The initial size of the group is defined in the `initial_size` key. You can create a group with the desired number of instances within the available [quotas and limits](../limits.md).

Example of a YAML file entry:

```
scale_policy:
    auto_scale:
        initial_size: 5
        max_size: 15
        min_zone_size: 3
        measurement_duration: 30
        warmup_duration: 60
        cooldown_duration: 120
        cpu_utilization_rule:
            utilization_target: 75
```

Keys:

| Key | Value |
| ----- | ----- |
| `auto_scale` | An automatically scaled instance group. |
| `initial_size`* | Initial number of instances in the group. Each group may contain a maximum of 100 instances. |
| `max_size` | Maximum number of instances per instance group. |
| `min_zone_size` | The minimum number of instances per availability zone. |
| `measurement_duration`* | Time in seconds allotted for averaging metrics based on CPU load. If the average load at the end of the interval is higher than `cpu_utilization_rule.utilization_target`, {{ ig-name }} increases the number of instances in the group. |
| `warmup_duration`* | The warmup time of the instance, in seconds. During this time, traffic is sent to the instance, but CPU load metrics aren't considered. |
| `cooldown_duration`* | Minimum amount of time, in seconds, allotted for load monitoring before {{ ig-name }} can reduce the number of instances in the group. During this time, the group doesn't decrease, even if the average load drops below the `cpu_utilization_rule.utilization_target` value. |
| `cpu_utilization_rule`* | Target CPU performance level. |

\* Required field.

