---
title: How to move a VM to a different availability zone
description: Follow this guide to move a VM to a different availability zone.
---

# Moving a VM to a different availability zone

When creating a VM, you can choose the {{ yandex-cloud }} [availability zone](../../../overview/concepts/geo-scope.md) where it will be located.

You can move an existing VM to a different availability zone using a special command in the [management console]({{ link-console-main }}) or the [CLI](../../../cli/cli-ref/managed-services/compute/instance/relocate.md) or by creating its copy in the target availability zone using [disk snapshots](../../concepts/snapshot.md).


{% include [relocate-note](../../../_includes/compute/relocate-note.md) %}


{% note warning %}

The `{{ region-id }}-d` zone does not support VMs based on the Intel Broadwell [platform](../../concepts/vm-platforms.md). To move such VMs to the `{{ region-id }}-d` zone, do one of the following:

* Take a disk snapshot and use it to create a new VM in the `{{ region-id }}-d` zone on a different platform.
* Stop the VM, change the platform, and move the VM by running `relocate`.

{% endnote %}

## Moving a VM using disk snapshots {#relocate-snapshots}

To move a VM to a different availability zone using snapshots, create its copy in the target availability zone and delete the original one.

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

## Moving a VM using a special command {#relocate-command}

When a VM is moved to a different availability zone using the management console or the CLI, its metadata and ID will be preserved. The VM will be moved to the new availability zone together with all the disks attached to it.

{% note info %}

The time it takes to move a VM to a different availability zone depends on the size of its disks. It takes about 10 minutes to move a 100 GB disk.

In some cases, the migration may take longer if you are moving it to the `{{ region-id }}-d` availability zone.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  {% note warning %}

  Currently, the management console only allows moving VMs from the `{{ region-id }}-c` availability zone. To move VMs from other availability zones, use the CLI or disk snapshots.

  {% endnote %}

  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. In the line with the appropriate VM, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.compute.button_relocate-to-another-zone }}**. In the window that opens:

      1. In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, choose the availability zone to move the VM to, e.g., `{{ region-id }}-d`.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, configure each [network interface](../../concepts/network.md) of your VM as follows:
          1. In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the subnet that corresponds to the selected availability zone.
          1. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, choose a method for public IP address assignment:
              * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP address pool. In this case, you can enable [DDoS protection](../../../vpc/ddos-protection/index.md) in additional settings.
              * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
              * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`: Do not assign a public IP address.

          1. Select the [appropriate security groups in the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**](../../../vpc/concepts/security-groups.md) field.
          1. To set up an internal IP address for a VM and enable DDoS protection, expand the **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** section and select a method for internal IP address assignment in the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field:
              * `{{ ui-key.yacloud.common.label_auto }}`: Assign a random IP address from the pool of IP addresses available in the selected subnet.
              * `{{ ui-key.yacloud.common.label_list }}`: Select an internal IP address from the list of previously reserved IP addresses. Click **{{ ui-key.yacloud.component.internal-v4-address-field.button_internal-address-reserve }}** to reserve an internal IP address in the selected subnet if needed.
          1. Enable the **{{ ui-key.yacloud.common.field_ddos-protection-provider }}** option, if needed. The option is available if you previously selected the automatic IP assignment method in the public address settings.

      1. Click **{{ ui-key.yacloud.compute.instances.button_start-instance-relocation }}** to start moving the VM to a different availability zone.

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
      +----------------------+-----------------------+----------------------+----------------+---------------+-------------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |       RANGE       |
      +----------------------+-----------------------+----------------------+----------------+---------------+-------------------+
      | bucqps2lt75g******** | subnet-{{ region-id }}-a1 | c64pv6m0aqq6******** |                | {{ region-id }}-a | [192.168.11.0/24] |
      | e2lrucutusnd******** | subnet-{{ region-id }}-a2 | c64pv6m0aqq6******** |                | {{ region-id }}-a | [192.168.12.0/24] |
      | e2lv9c6aek1d******** | subnet-{{ region-id }}-a3 | c64pv6m0aqq6******** |                | {{ region-id }}-a | [192.168.13.0/24] |
      | bltign9kcffv******** | default-{{ region-id }}-b | c64pv6m0aqq6******** |                | {{ region-id }}-b | [192.168.1.0/24]  |
      +----------------------+-----------------------+----------------------+----------------+---------------+-------------------+
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

      ```text
      +----------------------+---------+---------------+---------+---------------+-------------+
      |          ID          |  NAME   |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
      +----------------------+---------+---------------+---------+---------------+-------------+
      | a7lh48f5jvlk******** | my-vm-1 | {{ region-id }}-a | RUNNING |               | 192.168.0.7 |
      | epdsj30mndgj******** | my-vm-2 | {{ region-id }}-b | RUNNING |               | 192.168.1.7 |
      +----------------------+---------+---------------+---------+---------------+-------------+
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
         mac_address: d0:0d:24:**:**:**
         subnet_id: bucqps2lt75g********
         primary_v4_address:
           address: 192.168.11.23
           one_to_one_nat:
             address: 158.160.**.***
             ip_version: IPV4
       - index: "1"
         mac_address: d0:1d:24:**:**:**
         subnet_id: e2lrucutusnd********
         primary_v4_address:
           address: 192.168.12.32
       - index: "2"
         mac_address: d0:2d:24:**:**:**
         subnet_id: e2lv9c6aek1d********
         primary_v4_address:
           address: 192.168.13.26
     ...
     ```

  1. Move the VM to a different availability zone:

      ```bash
      yc compute instance relocate <VM_ID> \
        --destination-zone-id <availability_zone_ID> \
        --network-interface subnet-id=<subnet_ID>,security-group-ids=<security_group_ID>
      ```

      Where:

      * `<VM_ID>`: ID of the VM to move to a different availability zone.
      * `--destination-zone-id`: ID of the [availability zone](../../../overview/concepts/geo-scope.md) to move the VM to.
      * `--network-interface`: VM [network interface](../../concepts/network.md) settings:
          * `subnet-id`: ID of the subnet in the availability zone to move the VM to.
          * `security-group-ids`: ID of the [security group](../../../vpc/concepts/security-groups.md) to link to the VM you are moving. You can link multiple security groups to a single VM by providing a comma-separated list of security group IDs in `[id1,id2]` format.

          If a VM has multiple network interfaces, specify the `--network-interface` parameter as many times as needed (for each network interface).

      For more information about the `yc compute instance relocate` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/relocate.md).

      Examples:

      ```bash
      yc compute instance relocate a7lh48f5jvlk******** \
        --destination-zone-id {{ region-id }}-b \
        --network-interface \
          subnet-id=bltign9kcffv********,security-group-ids=c646ev94tb6k********
      ```

      In this example, we are moving a VM named `my-vm-1` from the `{{ region-id }}-a` availability zone to `{{ region-id }}-b`.

      Result:

      ```text
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
      fqdn: my-vm-1.{{ region-id }}.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

      If you are moving a VM with a [disk in a placement group](../../concepts/disk-placement-group.md), use this command:

      ```bash
      yc compute instance relocate <VM_ID> \
        --destination-zone-id <availability_zone_ID> \
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

      For more information about the `yc compute instance relocate` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/relocate.md).

  Please note that connecting VM's [network interfaces](../../concepts/network.md) to new subnets changes their IP addressing. If you need to specify internal IP addresses for the VM's network interfaces, use the `ipv4-address=<internal_IP_address>` property of the `network-interface` parameter; for public IP addresses, use the `nat-address=<public_IP_address>` property. Other than that, setting up network interface parameters when moving a VM to a different availability zone is similar to setting up the same parameters when creating a VM.

{% endlist %}

{% note info %}

If the VM disks are being written to, moving them may end in an error. In this case, stop writing to the disks or shut down the VM and restart the move.

{% endnote %}

### Examples {#examples}

#### Moving a VM to a different zone {#jump-from-a-to-d}

In this example, we are moving a VM named `my-vm-1` from the `{{ region-id }}-a` availability zone to `{{ region-id }}-d`.

```bash
yc compute instance relocate a7lh48f5jvlk******** \
  --destination-zone-id {{ region-id }}-d \
  --network-interface \
    subnet-id=bltign9kcffv********,security-group-ids=c646ev94tb6k********
```

Result:

```text
done (3m15s)
id: a7lh48f5jvlk********
folder_id: aoeg2e07onia********
created_at: "2023-10-13T19:47:40Z"
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
fqdn: my-vm-1.{{ region-id }}.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}
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
