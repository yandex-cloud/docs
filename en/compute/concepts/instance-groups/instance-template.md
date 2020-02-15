# Instance template

When creating a group, you need to describe an _instance template_, which is the basic instance configuration used for deploying all the instances in the group.

The template description and [policy](policies.md) description are passed to the CLI in a YAML file when creating or updating an instance group with the `--file` flag. This is convenient for passing values that consist of multiple strings. For more information, see [{#T}](../../operations/instance-groups/create-fixed-group.md).

## Computing resources {#types}

When describing a template, you specify the computing resources to allocate to each instance: the number and guaranteed performance of processor cores (vCPUs) and the amount of RAM. You can choose the computing resources that are appropriate for the expected load. For more information, see [{#T}](../performance-levels.md).

You can also use the template to enable the creation of [preemptible](../preemptible-vm.md) instances, which are cheaper than the regular instances. Preemptible instances can only be auto-healed if the computing resources in the availability zone allow for this. If the resources are insufficient, {{ ig-name }} will resume auto-healing as soon as the resources become available, but this may take a long time.

## Disks {#disks}

At least one disk must be attached to each instance: the boot disk. Each boot disk is created automatically and attached to only one instance when creating an instance group.

You can also attach additional disks to each instance. You can create an additional disk along with an instance group. The new disk can be empty, or you can restore it from a snapshot or image. You can only attach or detach additional disks when creating or updating a group. For more information, see [{#T}](../disk.md).

{% note alert %}

When you delete a VM, its disks are deleted from the group. VMs can be deleted during the [scaling](scale.md) and [automatic recovery](autohealing.md) process.

{% endnote %}

## Network {#network}

When creating a group, you can:

- Set the network for the group itself.
- Set subnets for each instance in the group.

You can create a group without specifying any subnets for its instances if the availability zone selected for each instance contains exactly one subnet for the specified network.

You can also configure a public IP address for each instance. This allows the instance to interact with other services over the internet. For more information, see [{#T}](../network.md).

## Metadata {#metadata}

The template can be used to describe the metadata for the instances in the group. For example, you can use the `user-data` key to describe the system users to be created on new instance startup. Read more about the metadata supported by {{compute-name}} in [{#T}](../vm-metadata.md).

## Template description in a YAML file {#instance-template}

A template describes the configuration of the base instance. It is defined in the `instance_template` key  in a YAML file.

Example of a YAML file entry:

```yaml
...
instance_template:
  platform_id: standard-v1
  resources_spec:
    memory: 2G
    cores: 1
    core_fraction: 5
  boot_disk_spec:
    mode: READ_WRITE
    disk_spec:
      image_id: ff8nb7ecsbrj76dfaa8b
      type_id: network-hdd
      size: 50G
  network_interface_specs:
    - network_id: rnp6rq7pmi0542gtuame
      subnet_ids:
        - e9b9v2v5f3rrpuot2mvl
      primary_v4_address_spec: {
        one_to_one_nat_spec: {
          ip_version: IPV4
        }
      }
  metadata:
    user-data: |-
      #cloud-config
      write_files:
        - path: /var/lib/cloud/scripts/per-boot/01-run-load-generator.sh
          permissions: '0555'
          content: |
            #!/bin/bash
            docker run -d --net=host -p 80:80 openresty/openresty:alpine
      users:
        - name: my-user
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh-authorized-keys:
            - ssh-rsa AAAAB3...
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
| `type_id` | ID of the disk type. To get a list of available disk types, use the request [diskTypes](../../api-ref/DiskType/list.md) request. |
| `size` | Size of the disk, specified in bytes. Acceptable values are in the range from 4194304 (4 MB) to 4398046511104 (4 TB). |
| `network_id` | ID of the network. |
| `subnet_ids` | IDs of cloud subnets. |
| `ip_version` | IP version for the public IP address. |
| `metadata` | Metadata for a template instance. Read more in [{#T}](../vm-metadata.md). |
| `user-data` | Additional settings for instance initialization. In the example, the settings are described for the `cloud-init` program. |

For information about the technical restrictions of {{ ig-name }}, see [{#T}](../limits.md).

