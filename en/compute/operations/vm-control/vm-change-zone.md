---
title: How to move a VM to a different availability zone
description: Follow this guide to move a VM to a different availability zone.
---

# Moving a VM to a different availability zone

When creating a VM, you can select a {{ yandex-cloud }} [availability zone](../../../overview/concepts/geo-scope.md) to place it in.

You can move a VM to a different availability zone by creating its copy in the target availability zone using disk snapshots.

You can also move a VM from the `{{ region-id }}-a` and `{{ region-id }}-b` zones to the `{{ region-id }}-d` zone using a special [CLI](../../../cli/cli-ref/compute/cli-ref/instance/relocate.md) command.


{% include [relocate-note](../../../_includes/compute/relocate-note.md) %}


{% note warning %}

The `{{ region-id }}-d` zone does not support VMs based on the Intel Broadwell [platform](../../concepts/vm-platforms.md). To move such VMs to the `{{ region-id }}-d` zone, do one of the following:

* Take a disk snapshot and use it to create a new VM in the `{{ region-id }}-d` zone on a different platform.
* Stop the VM, change the platform, and move the VM by running `yc compute instance relocate`.

{% endnote %}

## Moving a VM using disk snapshots {#relocate-snapshots}

To move a VM to a different availability zone using snapshots, create its copy in the target availability zone and delete the source VM.

### Create a snapshot of each of the VM disks {#create-snapshot}

#### Prepare the disks {#prepare-disks}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

#### Create snapshots {#create}

To [create](../disk-control/create-snapshot.md) a disk snapshot:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

Repeat the steps above to create snapshots of all the disks.

### Create a VM in a different availability zone with the disks from the snapshots {#create-vm}

To [create](../vm-create/create-from-snapshots.md) a VM in a different availability zone with disks from snapshots:

{% include [create-from-snapshot](../../../_includes/compute/create-from-snapshot.md) %}

### Delete the source VM {#delete-vm}

To [delete](vm-delete.md) a source VM:

{% include [delete-vm](../../../_includes/compute/delete-vm.md) %}

## Moving a VM instance to the {{ region-id }}-d zone using a special command {#relocate-command}

The special CLI command can be used to move a VM instance only to the `{{ region-id }}-d` availability zone. The instance moved this way preserves its ID and metadata. All disks attached to the VM will also be transferred to the new availability zone.

{% note info %}

The time it takes to move a VM to a different availability zone depends on the size of its disks. A 100 GB disk typically takes more than 10 minutes to move.

{% endnote %}

{% list tabs group=instructions %}


- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for moving a VM to a different availability zone:

      ```bash
      yc compute instance relocate --help
      ```

  1. Get a list of all subnets in the default folder:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```text
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      | e2l5iit0t6dr******** | default-{{ region-id }}-b | enpnohfm8jb5******** |                | {{ region-id }}-b | [10.129.0.0/24] |
      | e9b2ljn7h9pj******** | default-{{ region-id }}-a | enpnohfm8jb5******** |                | {{ region-id }}-a | [10.128.0.0/24] |
      | fl8in4sila9i******** | default-{{ region-id }}-d | enpnohfm8jb5******** |                | {{ region-id }}-d | [10.130.0.0/24] |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      ```

  1. Get a list of all security groups in the default folder:

      ```bash
      yc vpc sg list
      ```

      Result:

      ```text
      +----------------------+---------------------------------+--------------------------------+----------------------+
      |          ID          |              NAME               |          DESCRIPTION           |      NETWORK-ID      |
      +----------------------+---------------------------------+--------------------------------+----------------------+
      | enpagmu40nj5******** | my-sg-group                     |                                | enpnohfm8jb5******** |
      | enpe9n88cell******** | default-sg-enpnohfm8jb5******** | Default security group for     | enpnohfm8jb5******** |
      |                      |                                 | network                        |                      |
      +----------------------+---------------------------------+--------------------------------+----------------------+
      ```

  1. Get a list of all VMs in the default folder:

      ```bash
      yc compute instance list
      ```

      Result:

      ```text
      +----------------------+---------+---------------+---------+--------------+-------------+
      |          ID          |  NAME   |    ZONE ID    | STATUS  | EXTERNAL IP  | INTERNAL IP |
      +----------------------+---------+---------------+---------+--------------+-------------+
      | epdi9vnr8i6n******** | my-vm-1 | {{ region-id }}-b | RUNNING | 84.201.166.2 | 10.129.0.31 |
      | epdjhkhtqjfp******** | my-vm-2 | {{ region-id }}-d | RUNNING |              | 10.130.0.6  |
      +----------------------+---------+---------------+---------+--------------+-------------+
      ```

  1. Get a list of [network interfaces](../../concepts/network.md) of the VM in question by specifying the VM ID:

     ```bash
     yc compute instance get <VM_ID>
     ```

     Result:

     ```yml
     ...
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:12:4f:ef:b4
         subnet_id: e2l5iit0t6dr********
         primary_v4_address:
           address: 10.129.0.31
           one_to_one_nat:
             address: 84.201.166.2
             ip_version: IPV4
     ...
     ```

  1. Move the VM to a different availability zone:

      ```bash
      yc compute instance relocate <VM_ID> \
        --destination-zone-id {{ region-id }}-d \
        --network-interface subnet-id=<subnet_ID>,security-group-ids=<security_group_ID>
      ```

      Where:

      * `<VM_ID>`: ID of the VM to move to a different availability zone.
      * `--destination-zone-id`: [Availability zone](../../../overview/concepts/geo-scope.md) ID. Only `{{ region-id }}-d` is supported.
      * `--network-interface`: VM [network interface](../../concepts/network.md) settings:
          * `subnet-id`: ID of the subnet in the availability zone to move the VM to.
          * `security-group-ids`: ID of the [security group](../../../vpc/concepts/security-groups.md) to link to the VM you are moving. You can link multiple security groups to a single VM by providing a comma-separated list of security group IDs in `[id1,id2]` format.

          If a VM has multiple network interfaces, specify the `--network-interface` parameter as many times as needed (for each network interface).

      For more information about the `yc compute instance relocate` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/relocate.md).

      If you are moving a VM with a [disk in a placement group](../../concepts/disk-placement-group.md), use this command:

      ```bash
      yc compute instance relocate <VM_ID> \
        --destination-zone-id {{ region-id }}-d \
        --network-interface subnet-id=<subnet_ID>,security-group-ids=<security_group_ID> \
        --boot-disk-placement-group-id <disk_placement_group_ID> \
        --boot-disk-placement-group-partition <partition_number> \
        --secondary-disk-placement disk-name=<disk_name>,disk-placement-group-id=<disk_placement_group_ID>,disk-placement-group-partition=<partition_number>
      ```

      Where:

      * `--boot-disk-placement-group-id`: Disk placement group ID.
      * `--boot-disk-placement-group-partition`: Partition number in the disk placement group with the [partition placement](../../concepts/disk-placement-group.md#partition) strategy.
      * `--secondary-disk-placement`: Placement policy for secondary disks. Parameters:

        * `disk-name`: Disk name.
        * `disk-placement-group-id`: ID of the disk placement group to place the disk in.
        * `disk-placement-group-partition`: Partition number in the disk placement group.

      For more information about the `yc compute instance relocate` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/relocate.md).

  Please note that connecting VM [network interfaces](../../concepts/network.md) to new subnets changes their IP addressing. If you need to specify internal IP addresses for the VM network interfaces, use the `ipv4-address=<internal_IP_address>` property of the `network-interface` parameter; for public IP addresses, use the `nat-address=<public_IP_address>` property. Other than that, setting up network interface parameters when moving a VM to a different availability zone is similar to setting up the same parameters when creating a VM.

{% endlist %}

{% note info %}

Active writes to the VM disks being moved may cause the migration to fail. In this case, stop writing to the disks or shut down the VM and restart the migration.

{% endnote %}

### Examples {#examples}

#### Moving a VM to a different zone {#jump-from-a-to-d}

In this example, we are moving a VM named `my-vm-1` from the `{{ region-id }}-b` availability zone to `{{ region-id }}-d`.

```bash
yc compute instance relocate epdi9vnr8i6n******** \
  --destination-zone-id {{ region-id }}-d \
  --network-interface subnet-id=fl8in4sila9i********,security-group-ids=enpagmu40nj5********
```

Result:

```text
done (1m28s)
id: epdi9vnr8i6n********
folder_id: b1g0ijbfaqsn********
created_at: "2025-11-04T18:44:29Z"
name: my-vm-1
zone_id: {{ region-id }}-d
platform_id: standard-v3
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "50"
status: RUNNING
metadata_options:
  gce_http_endpoint: ENABLED
  aws_v1_http_endpoint: ENABLED
  gce_http_token: ENABLED
  aws_v1_http_token: DISABLED
boot_disk:
  mode: READ_WRITE
  device_name: epdkl5gn20gv********
  auto_delete: true
  disk_id: epdkl5gn20gv********
network_interfaces:
  - index: "0"
    mac_address: d0:0d:12:4f:ef:b4
    subnet_id: fl8in4sila9i********
    primary_v4_address:
      address: 10.130.0.8
    security_group_ids:
      - enpagmu40nj5********
serial_port_settings:
  ssh_authorization: OS_LOGIN
gpu_settings: {}
fqdn: my-vm-1.{{ region-id }}.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}
hardware_generation:
  legacy_features:
    pci_topology: PCI_TOPOLOGY_V1
application: {}
```

#### Moving a VM with disks in a placement group {#jump-with-disk-placement-group}

In this example, we are moving a VM named `my-vm-1` with two disks in the placement group from the `{{ region-id }}-b` availability zone to `{{ region-id }}-d`.

```bash
yc compute instance relocate epd6qtn128k1******** \
  --destination-zone-id {{ region-id }}-d \
  --network-interface \
    subnet-id=fl8glc5v0lqj********,security-group-ids=enp1gjh3q042******** \
  --boot-disk-placement-group-id fv4pfmor782v******** \
  --boot-disk-placement-group-partition 1 \
  --secondary-disk-placement \
    disk-name=disk-two,fv4pfmor782v********,disk-placement-group-partition=2
```

Result:

```text
done (9m0s)
id: epd6qtn128k1********
folder_id: b1gmit33ngp3********
created_at: "2023-12-07T19:30:20Z"
name: my-vm-1
zone_id: {{ region-id }}-d
platform_id: standard-v3
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
metadata_options:
  gce_http_endpoint: ENABLED
  aws_v1_http_endpoint: ENABLED
  gce_http_token: ENABLED
  aws_v1_http_token: DISABLED
boot_disk:
  mode: READ_WRITE
  device_name: epdeqrm6g38j********
  auto_delete: true
  disk_id: epdeqrm6g38j********
secondary_disks:
  - mode: READ_WRITE
    device_name: epdi54snn7t6********
    disk_id: epdi54snn7t6********
network_interfaces:
  - index: "0"
    mac_address: d0:0d:6d:76:e1:12
    subnet_id: fl8glc5v0lqj********
    primary_v4_address:
      address: 10.130.0.12
    security_group_ids:
      - enp1gjh3q042********
gpu_settings: {}
fqdn: my-vm-1.{{ region-id }}.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}
```
