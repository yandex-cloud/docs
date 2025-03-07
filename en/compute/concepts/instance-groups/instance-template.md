---
title: '{{ compute-full-name }} instance template'
description: In this tutorial, you will learn what a {{ compute-name }} instance template is.
---

# Instance template

When creating a group, you need to describe an _instance template_, which is the basic instance configuration used for deploying all instances in the group.

Both the template and [policy](policies/index.md) description are provided to the CLI in a YAML file using the `--file` flag when creating or updating an instance group. This is a convenient method to provide values that consist of multiple strings. For more information, see [{#T}](../../operations/instance-groups/create-fixed-group.md).

You can set variable values for the instance template. For more information, see [{#T}](variables-in-the-template.md).

## Computing resources {#types}

When describing a template, you specify the computing resources to allocate to each instance, i.e., the number and guaranteed performance of processor cores (vCPUs) and the amount of RAM. You can choose the computing resources that are appropriate for the expected load. For more information, see [{#T}](../performance-levels.md).

You can also configure the template to create [preemptible](../preemptible-vm.md) instances, which are cheaper than regular ones. Preemptible instances can only be autohealed if there is enough computing resources in the availability zone. If the resources are insufficient, {{ ig-name }} will resume autohealing as soon as the resources become available; this, however, may take a longer time.

You can enable a [software-accelerated network](../software-accelerated-network.md) for group instances. This will transfer the processing of VM network traffic to additional compute cores.

## Disks and file storages {#disks}

Each instance must have at least one disk attached, which is a boot disk. Each boot disk is created automatically and attached to a single instance when creating an instance group. For more information, see [{#T}](../disk.md).

You can also attach additional disks to each instance. You can create an additional disk along with an instance group. You can create an empty disk or restore it from a snapshot or an image. You can only attach or detach additional disks when creating or updating a group. You can [update secondary disks](./deploy/secondary-disk.md) by updating [YAML specification](./specification.md).

{% note alert %}

When you delete a VM, its disks are also deleted from the group. You can delete VMs during [scaling](scale.md) and [automatic recovery](autohealing.md).

{% endnote %}

In addition to disks, you can also attach [file storages](../filesystem.md) to instances within a group. File storages allow configuring an instance to handle [stateful workloads](./stateful-workload.md) by saving the states of applications running on the instance to the storage independent of the instance group.

After attaching a file storage to a VM in the group, [mount](../../operations/filesystem/attach-to-vm.md) it on the VM's operating system. You can attach file storages using the [CLI](../../../cli/quickstart.md), [{{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md), or [API](../../api-ref/). For more information, see [{#T}](../../operations/instance-groups/create-with-filesystem.md).

## Network {#network}

When creating a group, you can:

* Set the network for the entire group.
* Set subnets for each instance in the group.

A [service account](../../../iam/concepts/users/service-accounts.md) used to perform operations in {{ ig-name }} should have a [role](../../../vpc/security/index.md) for accessing network and subnets where the instance group is located. For more information, see [{#T}](access.md).

You can create a group without specifying any subnets for its instances if the availability zone selected for each instance contains exactly one subnet for the specified network.

{% note info %}

In addition to subnets created by you, a cloud network can host automatically created subnets. For example, the [{{ sf-name }}](../../../functions/concepts/networking.md#user-network), [{{ serverless-containers-name }}](../../../serverless-containers/concepts/networking.md), and [{{ api-gw-name }}](../../../api-gateway/concepts/networking.md#user-network) service subnets, or [reserved addresses](../../../managed-kubernetes/concepts/network.md#network-resources) for {{ managed-k8s-name }} cluster pods and services.

{% endnote %}

You can also configure a public IP address for each instance. This allows the instance to connect to other services over the internet. For more information, see [{#T}](../network.md).

You can specify the [appropriate security groups](../../../vpc/concepts/security-groups.md) in a template or configure them individually for each instance in the group.

## Metadata {#metadata}

You can use a template to describe the metadata service parameters and the VM metadata for the instances in the group. For example, in the `user-data` key, you can describe the system users to be added or the [software installation scripts](../../operations/vm-create/create-with-cloud-init-scripts.md#examples) to be run when creating a new VM. Read more about the metadata supported by {{ compute-name }} in [{#T}](../vm-metadata.md).

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
  filesystem_specs:
    - mode: READ_WRITE
      device_name: sample-fs
      filesystem_id: epdccsrlalon********
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
  service_account_id: ajegtlf2q28a********
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: DISABLED
    gce_http_token: DISABLED
    aws_v1_http_token: DISABLED
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
          ssh_authorized_keys:
            - ssh-ed25519 AAAAB3...
...
```

{% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

Keys (the table lists keys that directly define the base instance configuration):

Key | Value
----- | -----
`platform_id` | ID of the instance's hardware platform.
`resources_spec.memory` | Amount of RAM available to the instance, specified in bytes. The maximum value is 274877906944 (275 GB).
`resources_spec.cores` | Number of cores available to the instance. The value depends on the [platform](../vm-platforms.md) type.
`resources_spec.core_fraction` | Basic [vCPU performance level](../performance-levels.md).
`boot_disk_spec` | Boot disk parameters.
`boot_disk_spec.disk_spec.mode` | Disk access mode.</br>– `READ_ONLY`: Read access.</br>– `READ_WRITE`: Read and write access.
`boot_disk_spec.disk_spec.image_id` | ID of the image to create the disk from.
`boot_disk_spec.disk_spec.type_id` | ID of the disk type. To get a list of available disk types, use the [diskTypes](../../api-ref/DiskType/list.md) request.
`boot_disk_spec.disk_spec.size` | Size of the disk, specified in bytes. Acceptable values are in the range from 4194304 (4 MB) to 4398046511104 (4 TB).
`boot_disk_spec.preserve_after_instance_delete` | Option to preserve the disk on instance deletion.</br>– `true`: Preserve the disk on instance deletion.</br>– `false`: Delete the disk together with the instance.
`secondary_disk_specs` | (Optional) Secondary disks parameters.
`secondary_disk_specs.name` | (Optional) Secondary disk name. In the same specification, names should be assigned either to all secondary disks or none of them. For more information, see [{#T}](./deploy/secondary-disk.md).
`secondary_disk_specs.mode` | Disk access mode.</br>– `READ_ONLY`: Read access.</br>– `READ_WRITE`: Read and write access.
`secondary_disk_specs.disk_spec.preserve_after_instance_delete` | Option to preserve the disk on instance deletion.</br>– `true`: Preserve the disk on instance deletion.</br>– `false`: Delete the disk together with the instance.
`secondary_disk_specs.disk_spec.type_id` | ID of the disk type. To get a list of available disk types, use the [diskTypes](../../api-ref/DiskType/list.md) request.
`secondary_disk_specs.disk_spec.size` | Size of the disk, specified in bytes. Acceptable values are in the range from 4194304 (4 MB) to 4398046511104 (4 TB).
`filesystem_specs` | (Optional) File storage parameters.
`filesystem_specs.mode` | File storage access mode: </br>– `READ_ONLY`: Read access.</br>– `READ_WRITE`: Read and write access (default).
`filesystem_specs.device_name` | Device name for attaching the file storage to the VM, e.g., `sample-fs`. After attaching a file storage to a VM in the group, [mount](../../operations/filesystem/attach-to-vm.md) it on the VM's operating system. For more information, see [{#T}](../../operations/instance-groups/create-with-filesystem.md).
`filesystem_specs.filesystem_id` | File storage ID.
`network_interface_specs.network_id` | Cloud network ID.
`network_interface_specs.subnet_ids` | IDs of cloud subnets.
`network_interface_specs.ip_version` | IP version for the public IP address.
`network_interface_specs.security_group_ids` | Security group IDs.
`network_settings.type` | (Optional) Network type.</br>– `SOFTWARE_ACCELERATED`: Software-accelerated network.</br>– `STANDARD`: Standard network (default).
`metadata_options` | (Optional) [Metadata service parameters](../vm-metadata.md#metadata-formats).
`metadata_options.gce_http_endpoint` | (Optional) Access metadata using the Google Compute Engine format.</br>- `enabled`: Enabled.</br>- `disabled`: Disabled.
`metadata_options.gce_http_token` | (Optional) Access {{ iam-name }} credentials using the Google Compute Engine format.</br>- `enabled`: Enabled.</br>- `disabled`: Disabled. 
`metadata` | (Optional) Metadata for a template instance. For more information, see [{#T}](../vm-metadata.md).
`metadata.user-data` | Additional settings for instance initialization. In the example, the settings are described for the `cloud-init` program.
`placement_policy` | (Optional) [VM placement group](../placement-groups.md) parameters.
`placement_policy.placement_group_id` | Placement group ID. VM instances will reside in data center server racks depending on the selected placement strategy:</br>– `spread` placement strategy ensures that each VM instance resides in a separate server rack in one of the availability zones.</br>– `partition` placement strategy evenly distributes VM instances among the group's partitions and ensures that VM instances from different partitions reside in different server racks in one of the availability zones.
`service_account_id` | (Optional) [Service account](../../../iam/concepts/users/service-accounts.md) attached to the VMs in the group that enables them to use cloud resources. Using a service account enables flexible configuration of access permissions for resources.</br>For more granular management of access permissions, attach different service accounts with different permissions to the instance group and VMs in the group.

For information about the technical restrictions of {{ ig-name }}, see [{#T}](../limits.md).

#### See also {#see-also}

* [{#T}](../vm-metadata.md)
* [Creating a VM with a custom configuration script](../../operations/vm-create/create-with-cloud-init-scripts.md)