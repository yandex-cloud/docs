* `{instance_group.id}`: Instance group ID.
* `{instance.index}`: Unique instance number in the instance group. Possible values: 1 to N, where N is the number of instances in the group.
* `{instance.index_in_zone}`: Instance number in a zone. It's unique for a specific instance group within the zone.
* `{instance.short_id}`: Instance ID that is unique within the group. Consists of four letters.
* `{instance.zone_id}`: Zone ID.

For example, `prod-{instance.short_id}-{instance_group.id}`. If not specified, the default value is used: `{instance_group.id}-{instance.short_id}`.