# Instance template

When creating a group, you need to describe an _instance template_, which is the basic instance configuration that will be used for deploying all the instances in the group.

The template description and [policy](policies.md) description are passed to the CLI in a YAML file when creating or updating an instance group with the `--file` flag. This is convenient for passing values consisting of multiple strings. For more information, see [{#T}](../../operations/instance-groups/create-fixed-group.md).

## Computing resources {#types}

When describing a template, you specify the computing resources to allocate to each instance: the number and guaranteed performance of processor cores (vCPUs) and the amount of RAM. You can choose the computing resources that are appropriate for the expected load. For more information, see [{#T}](../performance-levels.md).

## Disks {#disks}

At least one disk must be attached to each instance, that is, a boot disk. Each boot disk is created automatically and attached to only one instance when creating an instance group.

You can also attach additional disks to each instance. You can create an additional disk along with an instance group. The new disk can be empty, or you can restore it from a snapshot or image. It is only possible to attach or detach additional disks when creating or updating a group. For more information, see [{#T}](../disk.md).

## Network {#network}

When creating a group, you can:

- Set the network for the group itself.
- Set subnets for each instance in the group.

You can create a group without specifying any subnets for its instances if the availability zone selected for each instance contains exactly one subnet for the specified network.

You can also configure a public IP address for each instance. This allows the instance to interact with other services over the internet. For more information, see [{#T}](../network.md).

## Template description in a YAML file {#instance-template}

A template describes the configuration of the base instance. It is defined in the `instance_template` key  in a YAML file.

Example of a YAML file entry:

```
...
instance_template:
    platform_id: standard-v1
    resources_spec:
        memory: 4g
        cores: 1
        core_fraction: 5
    boot_disk_spec:
        mode: READ_WRITE
        disk_spec:
            image_id: fdvk34al8k5nltb58shr
            type_id: network-hdd
            size: 32g
    secondary_disk_specs:
        mode: READ_WRITE
        disk_spec:
            image_id: fdvk34al8k5nltb58shr
            type_id: network-hdd
            size: 32g
    network_interface_specs:
        - network_id: c64mknqgnd8avp6edhbt
          subnet_ids:
              - blt022m2diah5j3rcj8v
          primary_v4_address_spec: {
              one_to_one_nat_spec: {
                  ip_version: IPV4
              }
          }
...
```

{% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

Keys (the table lists keys that directly define the base instance's configuration):

| Key | Value |
| ----- | ----- |
| `platform_id` | ID of the instance's hardware platform. |
| `memory` | The amount of RAM available to the instance, specified in bytes. The maximum value is 274877906944 (275 GB). |
| `cores` | The number of cores available to the instance. The value must be equal to 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, or 32. |
| `core_fraction` | Base CPU performance. The value must be 0, 5, or 100. |
| `mode` | Disk access mode. </br> - `READ_ONLY`: read-only access. </br>- `READ_WRITE`: read/write access. |
| `image_id` | ID of the image that will be used for disk creation. |
| `type_id` | ID of the disk type. To get a list of available disk types, use the [yandex.cloud.compute.v1.diskTypes](../../api-ref/DiskType/list.md) request. |
| `size` | Size of the disk, specified in bytes. Acceptable values are in the range from 4194304 (4 MB) to 4398046511104 (4 TB). |
| `network_id` | ID of the network. |
| `subnet_ids` | IDs of cloud subnets. |
| `ip_version` | IP version for the public IP address. |

For information about the technical restrictions of {{ ig-name }}, see [{#T}](../limits.md).

