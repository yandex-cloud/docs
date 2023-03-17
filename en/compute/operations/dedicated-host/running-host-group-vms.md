# Creating a VM in a group of dedicated hosts

The VM you create will be linked to one of the [dedicated hosts](../../concepts/dedicated-host.md) in the group. When the VM is stopped, it will not be available on the group hosts, and when it is restarted, it may be linked to a different host from the group.

If you do not have a group of dedicated hosts, [create](create-host-group.md) one.

To create a VM:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Get the group ID for the dedicated host group where you need to create the VM:

      ```bash
      yc compute host-group list
      ```

      Result:

      {% include [dedicated-types-cli-output](../../../_includes/compute/dedicated-types-cli-output.md) %}

   1. Get a list of available subnets:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```bash
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      | b0c6n43f9lgh3695v2k2 | default-{{ region-id }}-c | enpe3m3fa00udao8g5lg |                | {{ region-id }}-c | [10.130.0.0/24] |
      | e2l2da8a20b33g7o73bv | default-{{ region-id }}-b | enpe3m3fa00udao8g5lg |                | {{ region-id }}-b | [10.129.0.0/24] |
      | e9bnlm18l70ao30pvfaa | default-{{ region-id }}-a | enpe3m3fa00udao8g5lg |                | {{ region-id }}-a | [10.128.0.0/24] |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      ```

   1. Run the following command to create a VM:

      ```bash
      yc compute instance create \
        --host-group-id <dedicated_host_group_ID> \
        --zone <availability_zone> \
        --platform <platform_ID> \
        --network-interface subnet-name=<subnet_name> \
        --attach-local-disk size=<disk_size>
      ```

      Where:

      * `--host-group-id`: ID of the dedicated host group.
      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) where the group of dedicated hosts resides.
      * {% include [dedicated-cli-platform](../../../_includes/compute/dedicated-cli-platform.md) %}
      * `--network-interface`: VM network interface description:

         * `subnet-name`: Name of the subnet in the availability zone.

      * {% include [dedicated-cli-attach-local-disk](../../../_includes/compute/dedicated-cli-attach-local-disk.md) %}

      To specify other VM properties, use the `yc compute instance create` command parameters as described in the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/create.md). For more information, see [{#T}](../../concepts/vm.md) and [{#T}](../index.md#vm-create).

      Result:

      ```bash
      done (20s)
      id: fhmbdt1jj2k3ls036909
      folder_id: m4n56op78mev0cljderg
      created_at: "2020-10-13T07:41:19Z"
      zone_id: {{ region-id }}-a
      ...
      placement_policy:
        host_affinity_rules:
        - key: yc.hostGroupId
          op: IN
          values:
          - abcdefg1hi23gkl16dnf
      ```

- API

   1. Find out  the ID of the dedicated host group using the [list](../../api-ref/HostGroup/list.md) method for the `HostGroup` resource.
   1. Create a VM using the [create](../../api-ref/Instance/create.md) method for the `Instance` resource.

{% endlist %}

{% include [dedicated-mount-local-disk](../../../_includes/compute/dedicated-mount-local-disk.md) %}


## Example of creating a VM with a local disk in a group of dedicated hosts {#host-vm-nvme}

Before creating a VM:

1. [Create a group of dedicated hosts](create-host-group.md) and get its ID using the `yc compute host-group list` [CLI command](../../../cli/cli-ref/managed-services/compute/host-group/list.md).
1. [Generate a key pair](../vm-connect/ssh.md#creating-ssh-keys) to connect to the VM via SSH.

Create a VM with the following characteristics:
* Location: Dedicated host group.
* Platform: Intel Ice Lake.
* VCPU cores: 64.
* RAM: 704 GB
* Number of local disks: 2.
* Size of a local disk: 3200 × 10^9^ B (~ 2.91 TB).
* Operating system: [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).

To do this, follow these steps:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Run the following command to create a VM:

   ```bash
   yc compute instance create \
     --cloud-id <cloud_ID> \
     --folder-id <folder_ID> \
     --zone <availability_zone> \
     --name <VM_name> \
     --platform standard-v3 \
     --cores 64 \
     --memory 704 \
     --host-group-id <dedicated_host_group_ID> \
     --network-interface subnet-id=<subnet_ID> \
     --attach-local-disk "size=3200000000000" \
     --attach-local-disk "size=3200000000000" \
     --ssh-key <public_SSH_key_file_path> \
     --create-boot-disk name=boot-disk,size=1000,image-folder-id=standard-images,image-family=ubuntu-2204-lts
   ```

   Where:

   * `--cloud-id`: [ID of the cloud](../../../resource-manager/operations/cloud/get-id.md).
   * `--folder-id`: ID of the folder.
   * `--zone`: Availability zone where the group of dedicated hosts resides.
   * `--name`: VM name.
   * `--platform`: VM platform.
   * `--cores`: Number of vCPUs.
   * `--memory`: Amount of RAM.
   * `--host-group-id`: ID of the dedicated host group.
   * `--network-interface`: VM network interface description:

      * `subnet-id`: ID of the subnet in the availability zone hosting the VM.

   * `--attach-local-disk`: Description of the local disk being attached:

      * `size`: Disk size.

   * `--ssh-key`: Path to the public SSH key. The user `yc-user` will be automatically created on the VM for this key.
   * `--create-boot-disk`: Boot disk parameters.

   Result:

   ```bash
   done (20s)
   id: fhmbdt1jj2k3ls036909
   folder_id: m4n56op78mev0cljderg
   created_at: "2023-01-16T12:46:50Z"
   zone_id: {{ region-id }}-a
   ...
   placement_policy:
     host_affinity_rules:
     - key: yc.hostGroupId
       op: IN
       values:
       - abcdefg1hi23gkl16dnf
   ```

{% endlist %}

{% include [intel-trademark](../../../_includes/intel-trademark.md) %}
