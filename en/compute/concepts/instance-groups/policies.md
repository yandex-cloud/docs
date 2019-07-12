# Policies

When creating an instance group, you need to define _policies_ for deploying and scaling instances and selecting zones.

The policy description and [instance template](instance-template.md) description are passed to the CLI as a YAML file when creating or updating an instance group, via the `--file` flag. This is convenient for passing values consisting of multiple strings. For more information, see [#T](../../operations/instance-groups/create-fixed-group.md).

## Allocation policy {#allocation-policy}

When creating an instance group, you can choose the regions and availability zones of Yandex.Cloud for hosting instances.

A region is a specific geographic location where you can deploy instances. Each region consists of one or more zones. Only one region is currently available. [Learn more about the Cloud geography](../../../overview/concepts/geo-scope.md).

Regions:

| Region | Zones | Location |
| ----- | ----- | ----- |
| `ru-central1` | `ru-central1-a`<br/>`ru-central1-b`<br/>`ru-central1-c` | Vladimir, Ryazan, and Moscow regions. |

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

The deployment policy is a set of restrictions that is defined in the `deploy-policy` key in the YAML file. Each restriction is set in its own key as a `key-value` pair.

Example of a YAML file entry:

```
...
deploy-policy:
    max_creating: 10
    max_deleting: 10
    max_unavailable: 10
    max_expansion: 0
    startup_duration: 30
...
```

Keys:

| Key | Value |
| ----- | ----- |
| `max_creating` | The maximum number of instances that can be created at the same time. |
| `max_deleting` | The maximum number of instances that can be deleted at the same time. |
| `max_unavailable` | The maximum number of instances in the `RUNNING` state that can be removed in order to reduce the target size of the group. |
| `max_expansion` | The maximum number of instances that can be additionally allocated in order to expand the target size of the group. If the `max_unavailable` key is not specified or is zero, then the `max_expansion` key value must be non-zero. |
| `startup_duration` | Startup duration of an instance in the group. |

## Scaling policy {#scale-policy}

When creating an instance group, you can choose how to increase or decrease the number of instances in the group to handle the current load on the service.

Only the [fixed-sized](scale.md#fixed-scale) scaling policy is supported for instance groups at this time.

An application's scaling policy is defined in the `scale_policy` key.

### fixed_scale {#fixed-scale-policy}

The `fixed_scale` key defines a fixed-size group. The value can only be the group size that is defined in the `size` key. You can specify any number of instances necessary to handle the current load on the service.
When creating a group, keep the [limits](../limits.md) in mind.

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
| `fixed_scale` | A fixed-size group. |
| `size` | Number of instances in the group. Each group may contain a maximum of 1,000 instances. |

