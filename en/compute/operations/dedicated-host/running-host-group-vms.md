# Creating a VM in a group of dedicated hosts

A created VM will be linked to one of the [dedicated hosts](../../concepts/dedicated-host.md) in the group. When the VM is stopped, it won't be available on the group hosts, and when it's restarted, it may be linked to a different host from the group.

If you don't have a group of dedicated hosts, [create](create-host-group.md) one.

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

      ```bash
      +----------------------+------+---------------+--------+---------------------+------+
      |          ID          | NAME |     ZONE      | STATUS |        TYPE         | SIZE |
      +----------------------+------+---------------+--------+---------------------+------+
      | abcdefg1hi23gkl16dnf |      | {{ region-id }}-a | READY  | intel-6230-c66-m454 |    2 |
      +----------------------+------+---------------+--------+---------------------+------+
      ```

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

   1. Run the command to create a VM:

      ```bash
      yc compute instance create \
        --host-group-id <ID of the dedicated host group> \
        --zone <availability zone> \
        --network-interface subnet-name=<subnet name>
      ```

      Where:

      * `host-group-id`: ID of the dedicated host group.
      * `zone` is the [availability zone](../../../overview/concepts/geo-scope.md) to place the group of dedicated hosts in.
      * `network-interface subnet-name` is the name of the subnet in the availability zone.

      To specify VM properties, use the parameters for the `yc compute instance create` command as described in the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/create.md). For more information, see [{#T}](../../concepts/vm.md) and [{#T}](../index.md#vm-create).

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

{% if product == "cloud-il" %}

## Example of creating a virtual machine in a group of dedicated hosts with a local NVMe disk {#host-vm-nvme}

Before creating a VM, [create](create-host-group.md) a group of dedicated hosts and get its ID using the `yc compute host-group list` [CLI command](../../../cli/cli-ref/managed-services/compute/host-group/list.md).

Create a VM with the following characteristics:
* Location: Dedicated host group.
* Platform: Intel Cascade Lake.
* VCPU cores: 32.
* RAM: 252 GB
* Number of NVMe disks: 2.
* NVMe disk size: 1600 GB.
* Operating system: [Windows Server 2019 Datacenter](/marketplace/products/yc/windows-server-2019-datacenter).

To do this, follow these steps:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Create a YAML file named `metadata.yaml`, for example, to include the administrator password for the VM being created:

      ```bash
      #ps1
      net user administrator '<password>'
      ```

   1. Run the command to create a VM:

      ```bash
      yc compute instance create \
        --cloud-id <cloud ID> \
        --folder-id <folder ID> \
        --zone <availability zone> \
        --name <VM name> \
        --platform standard-v2 \
        --cores 32 \
        --memory 352 \
        --host-group-id <ID of the dedicated host group> \
        --network-interface subnet-id=<subnet ID> \
        --attach-local-disk "size=1717986918400" \
        --attach-local-disk "size=1717986918400" \
        --metadata-from-file user-data=metadata.yaml \
        --create-boot-disk name=rds-c1-d1-sas-boot-disk,size=1000,image-folder-id=standard-images,image-family=windows-2019-dc-gvlk
      ```

      Where:

      * `cloud-id`: [ID of the cloud](../../../resource-manager/operations/cloud/get-id.md).
      * `folder-id`: ID of the folder.
      * `zone` is the availability zone to place the group of dedicated hosts in.
      * `name`: VM name.
      * `platform` is a VM platform.
      * `cores`: The number of vCPUs.
      * `memory`: The amount of RAM.
      * `host-group-id`: ID of the dedicated host group.
      * `network-interface subnet-id`: Subnet ID in the availability zone that will be hosting the VM.
      * `attach-local-disk`: Attached local disk size.
      * `metadata-from-file user-data`: Path to file with the administrator password.
      * `create-boot-disk`: Boot disk parameters.

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

{% endlist %}

{% endif %}
