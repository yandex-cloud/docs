---
title: "How to move a VM to a different availability zone"
description: "Follow this guide to move a VM to a different availability zone."
---

# Moving a VM to a different availability zone

When creating a VM, you can choose the {{ yandex-cloud }} [availability zone](../../../overview/concepts/geo-scope.md) where it will be located.

You can move a VM instance to a different availability zone by running a [CLI command](../../../cli/cli-ref/managed-services/compute/instance/relocate.md) or creating its copy in the appropriate availability zone using [disk snapshots](../../concepts/snapshot.md).

{% include [relocate-note](../../../_includes/compute/relocate-note.md) %}

## Moving VM instances using disk snapshots {#relocate-snapshots}

To move a VM instance to a different availability zone using snapshots, create a copy of the VM instance in the destination availability zone and then delete the original one.

### Create a snapshot of each of the VM's disks {#create-snapshot}

#### Prepare the disks {#prepare-disks}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

#### Create snapshots {#create}

To [create](../disk-control/create-snapshot.md) a disk snapshot:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

Repeat the steps to create a snapshot of each disk.

### Create a VM in a different availability zone with the disks from the snapshots {#create-vm}

To [create](../vm-create/create-from-snapshots.md) a VM in a different availability zone with the disks from the snapshots:

{% include [create-from-snapshot](../../../_includes/compute/create-from-snapshot.md) %}

### Delete the original VM {#delete-vm}

To [delete](vm-delete.md) the original VM:

{% include [delete-vm](../../../_includes/compute/delete-vm.md) %}

## Moving VM instances using the CLI {#relocate-cli}

When a VM instance is moved to a different availability zone using the CLI, its metadata and ID will be preserved. The VM instance will be moved to the new availability zone together with all the disks attached to it.

{% note info %}

The time it takes to move a VM instance to a different availability zone depends on the size of its disks. It takes about 10 minutes to move a 100 GB disk.

In some cases, the process may take longer if moving to the `{{ region-id }}-d` availability zone.

{% endnote %}

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Get a list of all subnets in the default folder:

   ```bash
   yc vpc subnet list
   ```

   Result:

   ```bash
   +----------------------+-----------------------+----------------------+----------------+---------------+------------------+
   |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
   +----------------------+-----------------------+----------------------+----------------+---------------+------------------+
   | bucqps2lt75g******** | default-{{ region-id }}-a | c64pv6m0aqq6******** |                | {{ region-id }}-a | [192.168.0.0/24] |
   | bltign9kcffv******** | default-{{ region-id }}-b | c64pv6m0aqq6******** |                | {{ region-id }}-b | [192.168.1.0/24] |
   | fo2e120dga7n******** | default-{{ region-id }}-c | c64pv6m0aqq6******** |                | {{ region-id }}-c | [192.168.2.0/24] |
   +----------------------+-----------------------+----------------------+----------------+---------------+------------------+
   ```

1. Get a list of all security groups in the default folder:

   ```bash
   yc vpc sg list
   ```

   Result:

   ```bash
   +----------------------+---------------------------------+--------------------------------+----------------------+
   |          ID          |              NAME               |          DESCRIPTION           |      NETWORK-ID      |
   +----------------------+---------------------------------+--------------------------------+----------------------+
   | c646ev94tb6k******** | my-sg-group                     |                                | c64pv6m0aqq6******** |
   | c64r84tbt32j******** | default-sg-c64pv6m0aqq6******** | Default security group for     | c64pv6m0aqq6******** |
   |                      |                                 | network                        |                      |
   +----------------------+---------------------------------+--------------------------------+----------------------+
   ```

1. Get a list of all VMs in the default folder:

   ```bash
   yc compute instance list
   ```

   Result:

   ```bash
   +----------------------+---------+---------------+---------+---------------+-------------+
   |          ID          |  NAME   |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
   +----------------------+---------+---------------+---------+---------------+-------------+
   | a7lh48f5jvlk******** | my-vm-1 | {{ region-id }}-a | RUNNING |               | 192.168.0.7 |
   | epdsj30mndgj******** | my-vm-2 | {{ region-id }}-b | RUNNING |               | 192.168.1.7 |
   +----------------------+---------+---------------+---------+---------------+-------------+
   ```

1. View a description of the CLI command for moving a VM instance to a different availability zone:

   ```bash
   yc compute instance relocate --help
   ```

1. Move the VM instance to a different availability zone:

   ```bash
   yc compute instance relocate <VM_ID> \
     --destination-zone-id <availability_zone_ID> \
     --network-interface \
       subnet-id=<subnet_ID>,security-group-ids=<security_group_ID>
   ```

   Where:
   
   * `<VM_ID>`: ID of the VM instance to be moved to a different availability zone.
   * `--destination-zone-id`: ID of the [availability zone](../../../overview/concepts/geo-scope.md) to move the VM instance to.
   * `subnet-id`: ID of the subnet in the availability zone to move the VM instance to.
   * `security-group-ids`: ID of the [security group](../../../vpc/concepts/security-groups.md) to be linked to the VM instance you move. You can link multiple security groups to a single VM instance. To do this, provide a comma-separated list of security group IDs in `[id1,id2]` format.

   For more information about the `yc compute instance relocate` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/relocate.md).

   Please note that a VM's relocation to a new subnet changes its IP addressing. If you need to specify a VM's internal IP address, use the `ipv4-address=<internal IP>` property and, if its public IP address, use the `nat-address=<public IP>` property of the `network-interface` parameter. In other respects, setting the network interface parameters of a VM you are migrating is similar to creating an instance.

   For example:

   ```bash
   yc compute instance relocate a7lh48f5jvlk******** \
     --destination-zone-id {{ region-id }}-b \
     --network-interface \
       subnet-id=bltign9kcffv********,security-group-ids=c646ev94tb6k********
   ```

   In this example, a VM instance named `my-vm-1` is moved from the `{{ region-id }}-a` availability zone to the `{{ region-id }}-b` availability zone.

   Result:

   ```bash
   done (3m15s)
   id: a7lh48f5jvlk********
   folder_id: aoeg2e07onia********
   created_at: "2023-10-13T19:47:40Z"
   name: my-vm-1
   zone_id: {{ region-id }}-b
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
     device_name: a7lp7jpslu59********
     auto_delete: true
     disk_id: a7lp7jpslu59********
   network_interfaces:
     - index: "0"
       mac_address: d0:0d:11:**:**:**
       subnet_id: bltign9kcffv********
       primary_v4_address:
         address: 192.168.1.17
       security_group_ids:
         - c646ev94tb6k********
   gpu_settings: {}
   fqdn: my-vm-1.ru-central1.internal
   scheduling_policy: {}
   network_settings:
     type: STANDARD
   placement_policy: {}
   ```

   {% note info %}

   If writing data to the VM disks, their move may end in an error. In this case, stop the disk write operation or shut down the VM instance and restart the move process.

   {% endnote %}

