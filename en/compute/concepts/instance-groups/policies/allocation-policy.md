# Allocation policy


When creating an instance group, you can choose the {{ yandex-cloud }} [availability zones](../../../../overview/concepts/geo-scope.md) to host your VM instances and list tags for VM instances within each availability zone.

You cannot directly migrate VM instances to other availability zones; however, you can [update a group](../../../operations/instance-groups/deploy/rolling-update.md) with new zone values.

## Tags {#tags}

_Tags_ are used for logical labeling of VM instances within an availability zone. You can provide a list of tags to an instance group using a [YAML specification](../specification.md). After you do that, each VM instance in the availability zone will get a unique tag from the list.

Using tags, you can ensure more granular declarative management of instances in the group. You can use tags as [system variables](../variables-in-the-template.md#first-stage), such as in a VM name. If you remove a tag from the list in the YAML specification, applying the configuration will also remove the instance labeled with this tag from the group. This will not change the group size, as a new instance will be created with the next available tag from the list. Tags also help keep the configuration defined when resizing the group: each VM instance will be assigned sequential tags from the list based on the number of VM instances in the availability zone.

You can also use tags in variables to [create instance groups with fixed IP addresses](../../../operations/instance-groups/create-with-fixed-ip.md).

## Specification {#specification}

The allocation policy is set in the `allocation-policy` key in the YAML specification. Availability zones are listed in the `zones` key, and tags, in the `instance_tags_pool` key. You can specify any available zones: instances in the group will be evenly distributed across them.

Here is an example of a YAML specification entry:

```yaml
...
allocation_policy:
  zones:
    - zone_id: {{ region-id }}-a
      instance_tags_pool:
      - first-tag
      - second-tag
    - zone_id: {{ region-id }}-b
      instance_tags_pool:
      - third-tag
      - fourth-tag
    - zone_id: {{ region-id }}-d
      instance_tags_pool:
      - fifth-tag
      - sixth-tag
...
```

Where:

Key | Value
----- | -----
`zones` | List of zones. Each zone is represented in the `zone_id` key by a `key:value` pair.
`zone_id` | Zone ID
`instance_tags_pool` | (Optional) List of instance tags in the group.<br/>Limitations:<ul><li>The number of tags cannot be less than the `size` key value in the `scale_policy` section for fixed-size instance groups and the `max_size` key value in the `scale_policy` section for automatically scaled instance groups.</li><li>Tags must be unique for the entire group and not just within a single zone.</li><li>Each tag must be from 3 to 50 characters long.</li><li>It may contain lowercase Latin letters, numbers, hyphens, and underscores.</li></ul>

### Example {#example}

In the example, a YAML specification describes a [group of fixed-size instances](../../../operations/instance-groups/create-fixed-group.md). The instances are hosted in the same availability zone and their names include tags from the `instance_tags_pool` list.

```yaml
name: first-fixed-group
service_account_id: ajeujptarqa4********
description: "This instance group was created from YAML config."
instance_template:
  name: production-{instance.tag}
  platform_id: standard-v3
  resources_spec:
    memory: 2g
    cores: 2
  boot_disk_spec:
    mode: READ_WRITE
    disk_spec:
      image_id: fd8v80pep5m9********
      type_id: network-hdd
      size: 5g
  network_interface_specs:
    - network_id: enpgf5vu9dd7********
      primary_v4_address_spec: {}
  scheduling_policy:
    preemptible: false
deploy_policy:
  max_unavailable: 1
  max_expansion: 0
scale_policy:
  fixed_scale:
    size: 3
allocation_policy:
  zones:
    - zone_id: {{ region-id }}-a
      instance_tags_pool:
      - first
      - second
      - third
```

### See also {#see-also}

* [{#T}](healing-policy.md)
* [{#T}](scale-policy.md)
* [{#T}](deploy-policy.md)
* [{#T}](../../../operations/instance-groups/create-with-fixed-ip.md)
