---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Allocation policy

When creating an instance group, you can choose the {{ yandex-cloud }} regions and availability zones to host your instances.

A region is a specific geographic location where you can deploy instances. Each region consists of one or more zones. Only one region is currently available. [More about the geo scope of {{ yandex-cloud }}](../../../../overview/concepts/geo-scope.md).

| Region | Zones | Location |
| ----- | ----- | ----- |
| `ru-central1` | `ru-central1-a`<br/>`ru-central1-b`<br/>`ru-central1-c` | Vladimir region, Moscow region, and Ryazan region. |

You can't move instances to other availability zones, but you can [update a group](../../../operations/instance-groups/update.md) with new zone values.

The allocation policy is defined in the `allocation-policy` key in the YAML file. The value can be the list of zones defined in the `zones` key. You can specify any available zones to evenly distribute the group instances across.

Example of a YAML file entry:

```yaml
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

