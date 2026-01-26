* `{instance_group.id}`: Instance group ID.
* `{instance.index}`: Unique instance number in the group that can be any value from 1 to N, where N is the number of instances in the group.
* `{instance.index_in_zone}`: Instance number in the zone. It is unique for a specific instance group within a zone.
* `{instance.short_id}`: Instance ID that is unique within the group. It consists of four alphabetic characters.
* `{instance.zone_id}`: Zone ID.

For example, `prod-{instance.short_id}-{instance_group.id}`. If you do not specify the name, the default value is used: `{instance_group.id}-{instance.short_id}`.