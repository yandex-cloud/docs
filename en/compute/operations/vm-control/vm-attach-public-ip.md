# Binding a public IP to a virtual machine

If you created a virtual machine without a public IP, you can bind it to an IP [you reserved](../../../vpc/operations/get-static-ip.md) in {{ vpc-name }} or to one automatically selected by {{ compute-name }} from among available IPs.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
   1. Select **{{ compute-name }}**.
   1. Select the VM.
   1. Under **Network interface**, in the top right-hand corner, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Add public IP**.
   1. In the window that opens:
      * In the **Public IP** field, choose **Auto** assignment of IP addresses or choose a reserved address from a **List**
         * (option) If you selected **Auto** under **Public IP**, enable the **DDoS protection** option. For more information, see [{#T}](../../../vpc/ddos-protection/index.md).
      * If you selected **List** in the **Public IP** field, select the address that you would like to bind to your VM.
      * Click **Add**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To attach a public IP address to a VM, run the CLI command below:

   ```bash
   yc compute instance add-one-to-one-nat
     --id=<instance_ID> 
     --network-interface-index=<instance_network_interface_index> 
     --nat-address=<IP address>
   ```

   Where:

   * `id`: VM instance ID. You can get a list of IDs of instances in a folder using the [CLI command](../../../cli/cli-ref/managed-services/compute/instance/list.md) `yc compute instance list`.
   * `network-interface-index`: VM instance's network interface index. By default: `0`.
   * `nat-address`: Public IP address to assign to the VM instance. You can get a list of public IPs reserved for instances in a folder using the [CLI command](../../../cli/cli-ref/managed-services/vpc/address/list.md) `yc vpc address list`. By default, a public IP address is assigned automatically.

   Usage example:

   ```bash
   yc compute instance add-one-to-one-nat
     --id=fhmsbag62tafcus1a12c 
     --network-interface-index=0
     --nat-address=51.250.9.203
   ```

   Result:

   ```bash
   id: fhmsbag62tafcus1a12c
   folder_id: b1gv87ssvu497lpgjh5o
   created_at: "2022-05-06T10:41:56Z"
   name: steel-machine
   description: for work
   zone_id: {{ region-id }}-a
   platform_id: standard-v3
   resources:
     memory: "1073741824"
     cores: "2"
     core_fraction: "20"
   status: RUNNING
   boot_disk:
     mode: READ_WRITE
     device_name: fhmeihe6vgg1smqp763q
     auto_delete: true
     disk_id: fhmeihe6vgg1smqp763q
   network_interfaces:
   - index: "0"
     mac_address: d0:0d:1c:5a:a0:61
     subnet_id: e9bn57jvjnbujnmk3mba
     primary_v4_address:
       address: 10.128.0.23
       one_to_one_nat:
         address: 51.250.9.203
         ip_version: IPV4
     security_group_ids:
     - enpcuhcljhb0jq9s3sb7
   fqdn: steel-machine.{{ region-id }}.internal
   scheduling_policy:
     preemptible: true
   network_settings:
     type: STANDARD
   placement_policy: {}
   ```

   For more information about the `yc compute instance add-one-to-one-nat` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/add-one-to-one-nat.md).

{% endlist %}
