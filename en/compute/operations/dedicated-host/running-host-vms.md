---
title: Creating a VM on a dedicated host
description: Use this guide to create a VM on a dedicated host.
---

# Creating a VM on a dedicated host


The VM you create will be linked to the host selected from a group of [dedicated hosts](../../concepts/dedicated-host.md). Once stopped, the VM becomes unavailable on the host, but it will be linked to the same host when you restart it.

If you do not have a group of dedicated hosts yet, [create](create-host-group.md) one.

To create a VM:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
  1. Navigate to **{{ compute-name }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. [Set](../vm-create/create-linux-vm.md) the required VM parameters.
  1. Expand **{{ ui-key.yacloud.compute.instances.create.section_additional }}**.
  1. Next to **{{ ui-key.yacloud.compute.instances.create.field_host-affinity-rules }}**, click **{{ ui-key.yacloud.common.add }}**.
  1. In the **{{ ui-key.yacloud.compute.instances.create.field_affinity-key-type }}** field, select **{{ ui-key.yacloud.compute.instances.create.value_affinity-key-host }}**.
  1. In the **{{ ui-key.yacloud.compute.instances.create.field_affinity-hosts }}** field, specify the IDs of the dedicated hosts the VM will be launched on.

      You can find the IDs of dedicated hosts in the [management console]({{ link-console-main }}) or using the [CLI](../../cli-ref/host-group/list-hosts.md) or [API](../../api-ref/HostGroup/listHosts.md).

      {% include [affinity-host-tip](../../../_includes/compute/affinity-host-tip.md) %}

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get the ID of the dedicated host group to create your VM in:

      ```bash
      yc compute host-group list
      ```

      Result:

      {% include [dedicated-types-cli-output](../../../_includes/compute/dedicated-types-cli-output.md) %}

  1. Retrieve the ID of the group's dedicated host to create your VM on:

      ```bash
      yc compute host-group list-hosts <dedicated_host_group_ID>
      ```

      Result:

      ```text
      +----------------------+----------------------+
      |          ID          |      SERVER ID       |
      +----------------------+----------------------+
      | fhm1ab2mhnf3******** | fhmlabct12vp******** |
      | fhmabcun12kb******** | fhm1a2bcsl13******** |
      +----------------------+----------------------+
      ```

  1. Get a list of available subnets:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```text
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      | b0c6n43f9lgh******** | default-{{ region-id }}-d | enpe3m3fa00u******** |                | {{ region-id }}-d | [10.130.0.0/24] |
      | e2l2da8a20b3******** | default-{{ region-id }}-b | enpe3m3fa00u******** |                | {{ region-id }}-b | [10.129.0.0/24] |
      | e9bnlm18l70a******** | default-{{ region-id }}-a | enpe3m3fa00u******** |                | {{ region-id }}-a | [10.128.0.0/24] |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      ```

  1. Run this command to create a VM:

      ```bash
      yc compute instance create \
        --host-id <dedicated_host_ID> \
        --zone <availability_zone> \
        --platform <platform_ID> \
        --network-interface subnet-name=<subnet_name> \
        --attach-local-disk size=<disk_size>
      ```

      Where:

      * `--host-id`: Dedicated host ID.
      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) where the group of dedicated hosts resides.
      * {% include [dedicated-cli-platform](../../../_includes/compute/dedicated-cli-platform.md) %}
      * `--network-interface`: VM network interface description:

        * `subnet-name`: Name of the subnet in the availability zone.

      * {% include [dedicated-cli-attach-local-disk](../../../_includes/compute/dedicated-cli-attach-local-disk.md) %}

      To specify other VM properties, use the `yc compute instance create` command parameters as described in the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/create.md). For more information, see [{#T}](../../concepts/vm.md) and [{#T}](../index.md#vm-create).

      Result:

      ```text
      done (41s)
      id: fhm1abc23407********
      folder_id: m4n56op78mev********
      created_at: "2020-10-13T08:00:55Z"
      zone_id: {{ region-id }}-a
      ...
      placement_policy:
        host_affinity_rules:
        - key: yc.hostId
          op: IN
          values:
          - fhm1ab2mhnf3********
      ```

- API {#api}

  1. Get the ID of the dedicated host group using the [list](../../api-ref/HostGroup/list.md) REST API method for the [HostGroup](../../api-ref/HostGroup/index.md) resource or the [HostGroupService/List](../../api-ref/grpc/HostGroup/list.md) gRPC API call.
  1. Get the IDs of dedicated hosts in the group using the [listHosts](../../api-ref/HostGroup/listHosts.md) REST API method for the [HostGroup](../../api-ref/HostGroup/index.md) resource or the [HostGroupService/ListHosts](../../api-ref/grpc/HostGroup/listHosts.md) gRPC API call.
  1. Create a VM using the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}

{% include [dedicated-mount-local-disk](../../../_includes/compute/dedicated-mount-local-disk.md) %}


## Example of creating a VM with a local disk on a dedicated host {#host-vm-nvme}

Before creating a VM:

1. [Create a group of dedicated hosts](create-host-group.md) and get its ID using the `yc compute host-group list` [CLI command](../../../cli/cli-ref/compute/cli-ref/host-group/list.md).
1. Get a list of IDs of dedicated hosts in the group using the `yc compute host-group list-hosts` [CLI command](../../../cli/cli-ref/compute/cli-ref/host-group/list-hosts.md).
1. [Generate a key pair](../vm-connect/ssh.md#creating-ssh-keys) to connect to your VM over SSH.

Create a VM with the following parameters:
* Location: Dedicated host.
* Platform: Intel Ice Lake.
* Number of vCPUs: 64.
* Amount of RAM: 704 GB.
* Number of local disks: 1.
* Local disk size: 3,198,924,357,632 B (~2.91 TB).
* Operating system: [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).

To do this, follow these steps:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Run this command to create a VM:

  ```bash
  yc compute instance create \
    --cloud-id <cloud_ID> \
    --folder-id <folder_ID> \
    --zone <availability_zone> \
    --name <VM_name> \
    --platform standard-v3 \
    --cores 64 \
    --memory 704 \
    --host-id <dedicated_host_ID> \
    --network-interface subnet-id=<subnet_ID> \
    --attach-local-disk "size=3198924357632" \
    --ssh-key <path_to_public_SSH_key_file> \
    --create-boot-disk name=boot-disk,size=1000,image-folder-id=standard-images,image-family=ubuntu-2204-lts
  ```

  Where:

  * `--cloud-id`: [Cloud ID](../../../resource-manager/operations/cloud/get-id.md).
  * `--folder-id`: Folder ID.
  * `--zone`: Availability zone where the group of dedicated hosts resides.
  * `--name`: VM name.
  * `--platform`: VM platform.
  * `--cores`: Number of vCPUs.
  * `--memory`: Amount of RAM.
  * `--host-id`: Dedicated host ID.
  * `--network-interface`: VM network interface description:

    * `subnet-id`: ID of the subnet in the availability zone hosting the VM.

  * `--attach-local-disk`: Description of the local disk being attached:

    * `size`: Disk size.

  * `--ssh-key`: Public SSH key path. The VM will automatically create a user named `yc-user` for this key.
  * `--create-boot-disk`: Boot disk parameters.

  Result:

  ```text
  done (20s)
  id: fhmbdt1jj2k3********
  folder_id: m4n56op78mev********
  created_at: "2023-01-27T12:06:52Z"
  zone_id: {{ region-id }}-a
  ...
  placement_policy:
    host_affinity_rules:
    - key: yc.hostId
      op: IN
      values:
      - fhm1ceqtmivg********
  ```

{% endlist %}

{% include [intel-trademark](../../../_includes/intel-trademark.md) %}