# Allocation policy

When creating an instance group, you can choose the {{ yandex-cloud }} regions and availability zones to host your instances.

A region is a specific location where you can deploy VM instances. Each region consists of one or more zones. Only one region is currently available. You can read more about {{ yandex-cloud }} availability zones [here](../../../../overview/concepts/geo-scope.md).


| Region | Zones | Location |
| ----- | ----- | ----- |
| `{{ region-id }}` | `{{ region-id }}-a`<br/>`{{ region-id }}-b`<br/>`{{ region-id }}-c` | Vladimir region, Moscow region, Ryazan region |



You cannot directly migrate VM instances to other availability zones; however, you can [update a group](../../../operations/instance-groups/deploy/rolling-update.md) with new zone values.

The allocation policy is defined in the `allocation-policy` key in the YAML file. Its value is a list of zones defined in the `zones` key. You can specify any available zones to evenly distribute the VM instances.

Here is how a YAML file entry may look like:

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
| `zones` | Zone list, with each zone defined in the `zone_id` key as a `key-value` pair |
| `zone_id` | Zone ID |