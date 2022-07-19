# Allocation policy

{% if product == "cloud-il" %}

{% include [one-az-disclaimer](../../../../_includes/overview/one-az-disclaimer.md) %}

{% endif %}

When creating an instance group, you can choose the {{ yandex-cloud }} regions and availability zones to host your instances.

A region is a specific geographic location where you can deploy instances. Each region consists of one or more zones. Only one region is currently available. [More about the geo scope of {{ yandex-cloud }}](../../../../overview/concepts/geo-scope.md).

{% if product == "yandex-cloud" %}

| Region | Zones | Location |
| ----- | ----- | ----- |
| `{{ region-id }}` | `{{ region-id }}-a`<br/>`{{ region-id }}-b`<br/>`{{ region-id }}-c` | Vladimir region, Moscow region, and Ryazan region. |

{% endif %}

{% if product == "cloud-il" %}

| Region | Zones | Location |
| ----- | ----- | ----- |
| `{{ region-id }}` | `{{ region-id }}-a` | Tirat Carmel, Israel |

{% endif %}

You can't move instances to other availability zones, but you can [update a group](../../../operations/instance-groups/deploy/rolling-update.md) with new zone values.

The allocation policy is defined in the `allocation-policy` key in the YAML file. The value can be the list of zones defined in the `zones` key. You can specify any available zones to evenly distribute the group instances across.

Example of a YAML file entry:

```
...
allocation_policy:
    zones:
        - zone_id: {{ region-id }}-a
        - zone_id: {{ region-id }}-b
        - zone_id: {{ region-id }}-c
...
```

Where:

| Key | Value |
| ----- | ----- |
| `zones` | Zone list. Each zone is defined in the `zone_id` key as a `key-value` pair. |
| `zone_id` | Zone ID. |