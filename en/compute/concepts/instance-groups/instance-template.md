# Instance template

When creating a group, you need to describe an _instance template_, which is the basic instance configuration used for deploying all instances in the group.

Both the template and [policy](policies/index.md) description are provided to the CLI in a YAML file using the `--file` flag when creating or updating an instance group. This is a convenient method to provide values that consist of multiple strings. For more information, see [{#T}](../../operations/instance-groups/create-fixed-group.md).

You can set variable values for the instance template. For more information, see [{#T}](variables-in-the-template.md).

## Computing resources {#types}

When describing a template, you specify the computing resources to allocate to each instance, i.e., the number and guaranteed performance of processor cores (vCPUs) and the amount of RAM. You can choose the computing resources that are appropriate for the expected load. For more information, see [{#T}](../performance-levels.md).

You can also use a template to enable creating [preemptible](../preemptible-vm.md) instances, which are cheaper than regular ones. Preemptible instances can only be autohealed if the computing resources in the availability zone allow for this. If the resources are insufficient, {{ ig-name }} will resume autohealing as soon as the resources become available; this, however, may take a long time.

You can enable a [software-accelerated network](../software-accelerated-network.md) for group instances. This will transfer the processing of VM network traffic to additional compute cores.

## Disks {#disks}

Each instance must have at least one disk attached, which is a boot disk. Each boot disk is created automatically and attached to a single instance when creating an instance group. For more information, see [{#T}](../disk.md).

You can also attach additional disks to each instance. You can create an additional disk along with an instance group. You can create an empty disk or restore it from a snapshot or an image. You can only attach or detach additional disks when creating or updating a group. You can [update secondary disks](./deploy/secondary-disk.md) by updating [YAML specification](./specification.md).

{% note alert %}

When you delete a VM, its disks are also deleted from the group. You can delete VMs during [scaling](scale.md) and [automatic recovery](autohealing.md).

{% endnote %}

## Network {#network}

When creating a group, you can:

* Set the network for the entire group.
* Set subnets for each instance in the group.

You can create a group without specifying any subnets for its instances if the availability zone selected for each instance contains exactly one subnet for the specified network.

You can also configure a public IP address for each instance. This allows the instance to connect to other services over the internet. For more information, see [{#T}](../network.md).

You can specify the [appropriate security groups](../../../vpc/concepts/security-groups.md) in a template or configure them individually for each instance in the group.

## Metadata {#metadata}

You can use a template to describe the metadata for the instances in the group. For example, you can use the `user-data` key to describe the system users to be created on new instance startup. For more information about the metadata supported by {{ compute-name }}, see [{#T}](../vm-metadata.md).

## Template description in a YAML file {#instance-template}

A template describes the configuration of the base instance. It is defined in the `instance_template` key in a YAML file.

Here is how a YAML file entry may look like:

```yaml
...
instance_template:
  platform_id: standard-v3
  resources_spec:
    memory: 2G
    cores: 2
    core_fraction: 20
  boot_disk_spec:
    mode: READ_WRITE
    disk_spec:
      image_id: jk9ib7ecsbrj********
      type_id: network-hdd
      size: 50G
      preserve_after_instance_delete: false
  secondary_disk_specs:
    - name: disk-2
      mode: READ_WRITE
      disk_spec:
        preserve_after_instance_delete: false
        type_id: network-hdd
        size: 21474836480
  network_interface_specs:
    - network_id: adv1rq7pmi05********
      subnet_ids:
        - u8zxv2v5f3rr********
      primary_v4_address_spec: {
        one_to_one_nat_spec: {
          ip_version: IPV4
        }
      }
      security_group_ids:
        - enps0ar5s3ti********
  network_settings:
    type: SOFTWARE_ACCELERATED
  placement_policy:
    placement_group_id: rmppvhrgm77g********
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
          sudo: 'ALL=(ALL) NOPASSWD:ALL'
          ssh-authorized-keys:
            - ssh-ed25519 AAAAB3...
...
```

{% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

Keys (the table lists keys that directly define the base instance configuration):

| Key | Value |
----- | -----
| `platform_id` | ID of the instance's hardware platform. |
| `resources_spec.memory` | Amount of RAM available to the instance, specified in bytes. The maximum value is 274877906944 (275 GB). |
| `resources_spec.cores` | Number of cores available to the instance. The value depends on the [platform](../vm-platforms.md) type. |
| `resources_spec.core_fraction` | Basic [vCPU performance level](../performance-levels.md). |
| `boot_disk_spec` | Boot disk parameters. |
| `boot_disk_spec.disk_spec.mode` | Disk access mode.</br>– `READ_ONLY`: Read access.</br>– `READ_WRITE`: Read and write access. |
| `boot_disk_spec.disk_spec.image_id` | ID of the image that will be used for disk creation. |
| `boot_disk_spec.disk_spec.type_id` | ID of the disk type. To get a list of available disk types, use the [diskTypes](../../api-ref/DiskType/list.md) request. |
| `boot_disk_spec.disk_spec.size` | Size of the disk, specified in bytes. Acceptable values are in the range from 4194304 (4 MB) to 4398046511104 (4 TB). |
| `boot_disk_spec.preserve_after_instance_delete` | Option to preserve the disk on instance deletion.</br>– `true`: Preserve the disk on instance deletion.</br>– `false`: Delete the disk together with the instance. |
| `secondary_disk_specs` | (Optional) Secondary disks parameters. |
| `secondary_disk_specs.name` | (Optional) Secondary disk name. In the same specification, names should be assigned either to all secondary disks or none of them. For more information, see [{#T}](./deploy/secondary-disk.md). |
| `secondary_disk_specs.mode` | Disk access mode.</br>– `READ_ONLY`: Read access.</br>– `READ_WRITE`: Read and write access. |
| `secondary_disk_specs.disk_spec.preserve_after_instance_delete` | Option to preserve the disk on instance deletion.</br>– `true`: Preserve the disk on instance deletion.</br>– `false`: Delete the disk together with the instance. |
| `secondary_disk_specs.disk_spec.type_id` | ID of the disk type. To get a list of available disk types, use the [diskTypes](../../api-ref/DiskType/list.md) request. |
| `secondary_disk_specs.disk_spec.size` | Size of the disk, specified in bytes. Acceptable values are in the range from 4194304 (4 MB) to 4398046511104 (4 TB). |
| `network_interface_specs.network_id` | Cloud network ID. |
| `network_interface_specs.subnet_ids` | IDs of cloud subnets. |
| `network_interface_specs.ip_version` | IP version for the public IP address. |
| `network_interface_specs.security_group_ids` | Security group IDs. |
| `network_settings.type` | (Optional) Network type.</br>– `SOFTWARE_ACCELERATED`: Software-accelerated network.</br>– `STANDARD`: Standard network (default). |
| `metadata` | Metadata for a template instance. For more information, see [{#T}](../vm-metadata.md). |
| `metadata.user-data` | Additional settings for instance initialization. In the example, the settings are described for the `cloud-init` program. |
| `placement_policy` | (Optional) [VM placement group](../placement-groups.md) parameters. |
| `placement_policy.placement_group_id` | Placement group ID. VM instances will be hosted in data center server racks depending on the selected placement strategy:</br>– `Spread` placement strategy ensures that each VM instance is hosted in a separate server rack in one of the availability zones.</br>– `Partition` placement strategy provides even allocation of VM instances across group partitions and ensures that VM instances from different partitions reside in different server racks in one of the availability zones. |

For information about the technical restrictions of {{ ig-name }}, see [{#T}](../limits.md).
