---
title: Adding another network interface to a virtual machine
description: Follow this guide to add another network interface to a VM.
---

# Adding another network interface to a virtual machine


A VM can have one or more [network interfaces](../../concepts/network.md). For more information on the maximum number of VM network interfaces, see [this section](../../concepts/limits.md).

You can add network interfaces to either [running](#add-to-running) or [stopped](#add-to-stopped) VMs. To maintain [network connectivity](../../../vpc/concepts/routing.md#rt-vm), we recommend adding network interfaces to stopped VMs.

{% note tip %}

If you want to assign a public IP address to a VM, use [this guide](vm-attach-public-ip.md).

{% endnote %}

## Adding a network interface to a stopped VM {#add-to-stopped}

To add another network interface to your VM:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the VM belongs to.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Select the VM to which you want to add an additional network interface.
  1. On the **{{ ui-key.yacloud.common.overview }}** tab, under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, click **{{ ui-key.yacloud.compute.instance.overview.button_add-network-interface }}**.
  1. In the window that opens, specify the network interface properties:

     * **{{ ui-key.yacloud.compute.instances.field_network-interface-index }}**: Responsible for the order in which network interfaces are connected. Each VM network interface must have a unique number.
     * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: Enter the ID of a subnet in the new VM's availability zone. Alternatively, select a [cloud network](../../../vpc/concepts/network.md#network) from the list. If there is no subnet, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}** and [create](../../../vpc/operations/subnet-create.md) one.
     * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select the IP address assignment method:

       * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`: Assign a random IP address from the {{ yandex-cloud }} IP address pool. In this case, you can enable [DDoS protection](../../../vpc/ddos-protection/index.md) using the appropriate option.
       * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`: Select a public IP address from the list of previously reserved static IP addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
       * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`: Do not assign a public IP address.

     * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**: Select [security groups](../../../vpc/concepts/security-groups.md). If you leave this field empty, the virtual machine will be assigned the default security group.
     * Expand **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** and select a method for assigning internal addresses in the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field:

       * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`: To assign a random IP address from the pool of IP addresses available in the selected subnet.
       * `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`: To manually assign a private IP address to the VM.
       * Enable **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**, if required. The option is available if you previously selected the automatic IP assignment method in the public address settings.

     * Optionally, create records for your VM in the [DNS zone](../../../dns/concepts/dns-zone.md):
     
       * Expand **{{ ui-key.yacloud.dns.label_dns-internal-settings }}** and click **{{ ui-key.yacloud.dns.button_add-record }}**.
       * Specify a zone, FQDN, and TTL for the record. When setting the FQDN, you can enable `{{ ui-key.yacloud.dns.label_auto-select-zone }}` for the zone.
       
         You can add multiple records to [internal DNS zones](../../../dns/concepts/dns-zone.md). For more information, see [Cloud DNS integration with Compute Cloud](../../../dns/concepts/compute-integration.md).

       * To create another record, click **{{ ui-key.yacloud.dns.button_add-record }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for adding a network interface to a virtual machine:

      ```bash
      yc compute instance attach-network-interface --help
      ```

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

      Save the ID of the VM you want to add another network interface to.

  1. Stop the selected VM by specifying its ID:

      ```bash
      yc compute instance stop <VM_ID>
      ```

  1. Get a list of all [subnets](../../../vpc/concepts/network.md#subnet) in the default folder:

      {% include [add-network-interface-cli-list-subnets](../../../_includes/compute/add-network-interface-cli-list-subnets.md) %}

      Save the ID of the subnet you want to link to the VM network interface being added. The subnet must be in the same [availability zone](../../../overview/concepts/geo-scope.md) as the VM.

  1. Get a list of all [security groups](../../../vpc/concepts/security-groups.md) in the default folder:

      {% include [add-network-interface-cli-list-sgs](../../../_includes/compute/add-network-interface-cli-list-sgs.md) %}

      Save the IDs of the security groups you want to link to the VM network interface being added. The security groups must be in the same [cloud network](../../../vpc/concepts/network.md#network) as the subnet being linked.

  1. Get a list of network interface numbers in use for the selected VM by specifying the VM ID:

      ```bash
      yc compute instance get <VM_ID>
      ```

      Result:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:b8:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.7
            one_to_one_nat:
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:ad:b8:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address: {}
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

      In the above example, the network interfaces numbered `0` and `1` (the `index` field values) are already in use.

  1. Add a new network interface to the selected VM:

      {% include [add-network-interface-the-cli-command](../../../_includes/compute/add-network-interface-the-cli-command.md) %}

      Result:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:b8:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.7
            one_to_one_nat:
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:ad:b8:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.4.20
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
        - index: "2"
          mac_address: d0:2d:b8:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address: {}
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

  1. To assign IP addresses to the new interface, start the VM by specifying its ID:

      ```bash
      yc compute instance start <VM_ID>
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, add the new `network_interface` section and `allow_stopping_for_update` parameter in the `yandex_compute_instance` resource description:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        network_interface {
          index     = <interface_number>
          subnet_id = "<subnet_ID>"
        }

        allow_stopping_for_update = true
        ...
      }
      ```

      Where:

      * `index`: Network interface number. Specify any number between `0` and `15` except the ones already used. By default, the first network interface gets `0`.
      * `subnet_id`: [Subnet](../../../vpc/concepts/network.md#subnet) ID.
      * `allow_stopping_for_update`: Parameter to allow your VM to stop for updates.

      For more information about `yandex_compute_instance` properties, see [this provider guide]({{ tf-provider-resources-link }}/compute_instance).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create and update all the required resources. You can check the update using the [management console]({{ link-console-main }}).

- API {#api}

  {% include [add-network-interface-api](../../../_includes/compute/add-network-interface-api.md) %}

{% endlist %}

Now your VM features a new network interface. [Make sure](#test) it works.


## Adding a network interface to a running VM {#add-to-running}

{% note info %}

{% include [add-network-interface-hotplug-preview-note](../../../_includes/compute/add-network-interface-hotplug-preview-note.md) %}

{% endnote %}

To add another network interface to your VM:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for adding a network interface to a virtual machine:

      ```bash
      yc compute instance attach-network-interface --help
      ```

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

      Save the ID of the VM you want to add another network interface to.

  1. Get a list of all [subnets](../../../vpc/concepts/network.md#subnet) in the default folder:

      {% include [add-network-interface-cli-list-subnets](../../../_includes/compute/add-network-interface-cli-list-subnets.md) %}

      Save the ID of the subnet you want to link to the VM network interface being added. The subnet must be in the same [availability zone](../../../overview/concepts/geo-scope.md) as the VM.

  1. Get a list of all [security groups](../../../vpc/concepts/security-groups.md) in the default folder:

      {% include [add-network-interface-cli-list-sgs](../../../_includes/compute/add-network-interface-cli-list-sgs.md) %}

      Save the IDs of the security groups you want to link to the VM network interface being added. The security groups must be in the same [cloud network](../../../vpc/concepts/network.md#network) as the subnet being linked.

  1. Get a list of network interface numbers in use for the selected VM by specifying the VM ID:

      ```bash
      yc compute instance get <VM_ID>
      ```

      Result:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

      In the above example, the network interfaces numbered `0` and `1` (the `index` field values) are already in use.

  1. Add a new network interface to the selected VM:

      {% include [add-network-interface-the-cli-command](../../../_includes/compute/add-network-interface-the-cli-command.md) %}

      Result:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
        - index: "2"
          mac_address: d0:2d:1a:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address:
            address: 192.168.4.17
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

- API {#api}

  {% include [add-network-interface-api](../../../_includes/compute/add-network-interface-api.md) %}

{% endlist %}

Now your VM features a new network interface. The new interface is currently inactive as you added it to a running VM. To make sure it is inactive:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Connect](../vm-connect/ssh.md#vm-connect) to the VM over SSH.
  1. Run this command to get information about the state of VM network interfaces:

      ```bash
      ip a
      ```

      Result:

      ```txt
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
          link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
          inet 127.0.0.1/8 scope host lo
             valid_lft forever preferred_lft forever
          inet6 ::1/128 scope host
             valid_lft forever preferred_lft forever
      ...
      4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
          link/ether d0:2d:1a:f4:20:ef brd ff:ff:ff:ff:ff:ff
          altname enp140s0
          altname ens10
      ```

      `state DOWN` for the `eth2` interface indicates that it is inactive.

- Windows {#windows}

  1. [Connect](../vm-connect/rdp.md) to the VM via RDP.
  1. To start **Device Manager**, run this command in PowerShell:

      ```powershell
      devmgmt.msc
      ```

  1. In the **Device Manager** window that opens, expand **Network adapters**. The newly added network interface has an exclamation mark next to it and is inactive.

{% endlist %}

To make it active, [restart](./vm-stop-and-start.md#restart) the VM. The only way to activate a network interface in a Windows VM is to restart that VM.

If your VM is on Linux and you cannot restart it, you can activate the network interface without restarting the VM. To avoid network connectivity loss, configure settings from the [serial console](../../concepts/serial-console.md):

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Enable](../serial-console/index.md#enable) access to the serial console on your VM.

      When creating a user for authenticating on the VM through the serial console, add this user to the `sudo` group using the `sudo usermod -a -G sudo <username>` command.

  1. [Connect](../serial-console/connect-ssh.md) to the VM serial console using the {{ yandex-cloud }} CLI or over SSH.

  1. Activate the network interface you added:

      ```bash
      sudo ip link set <interface_name> up
      ```

      Where `<interface_name>` is the name of the inactive interface in Linux, e.g., `eth2`. You can view the names of network interfaces in the Linux terminal using the `ip a` command.

  1. Get DHCP settings for the new interface:

      ```bash
      sudo dhclient <interface_name>
      ```

  1. Delete the default route for the new network interface from the [VM route table](../../../vpc/concepts/routing.md#rt-vm):

      ```bash
      sudo ip route del default dev <interface_name>
      ```

  1. [Disable](../serial-console/index.md#disable) access to the VM serial console if you no longer need it.

{% endlist %}

Now the network interface you added is active.


## Make sure the new network interface works properly {#test}

To test the new network interface:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Connect](../vm-connect/ssh.md#vm-connect) to the VM over SSH.
  1. Run this command to get information about the state of VM network interfaces:

      ```bash
      ip a
      ```

      Result:

      ```txt
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
          link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
          inet 127.0.0.1/8 scope host lo
             valid_lft forever preferred_lft forever
          inet6 ::1/128 scope host
             valid_lft forever preferred_lft forever
      2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          link/ether d0:0d:b8:99:4f:fa brd ff:ff:ff:ff:ff:ff
          altname enp138s0
          altname ens8
          inet 192.168.2.7/24 metric 100 brd 192.168.2.255 scope global eth0
             valid_lft forever preferred_lft forever
          inet6 fe80::d20d:b8ff:fe99:4ffa/64 scope link
             valid_lft forever preferred_lft forever
      3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          link/ether d0:2d:b8:99:4f:fa brd ff:ff:ff:ff:ff:ff
          altname enp139s0
          altname ens9
          inet 192.168.4.20/24 metric 200 brd 192.168.4.255 scope global eth1
             valid_lft forever preferred_lft forever
          inet6 fe80::d22d:b8ff:fe99:4ffa/64 scope link
             valid_lft forever preferred_lft forever
      4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          link/ether d0:ad:b8:99:4f:fa brd ff:ff:ff:ff:ff:ff
          altname enp140s0
          altname ens10
          inet 192.168.1.28/24 metric 300 brd 192.168.1.255 scope global eth2
             valid_lft forever preferred_lft forever
          inet6 fe80::d2ad:b8ff:fe99:4ffa/64 scope link
             valid_lft forever preferred_lft forever
      ```

      `state UP` for the `eth0`, `eth1`, and `eth2` interfaces indicates that they are running and active.

  1. To view the [VM route table](../../../vpc/concepts/routing.md#rt-vm), run this command:

      ```bash
      ip r
      ```

      Result:

      ```txt
      default via 192.168.2.1 dev eth0 proto dhcp src 192.168.2.7 metric 100
      default via 192.168.4.1 dev eth1 proto dhcp src 192.168.4.20 metric 200
      default via 192.168.1.1 dev eth2 proto dhcp src 192.168.1.28 metric 300
      192.168.1.0/24 dev eth2 proto kernel scope link src 192.168.1.28 metric 300
      192.168.1.1 dev eth2 proto dhcp scope link src 192.168.1.28 metric 300
      192.168.1.2 dev eth2 proto dhcp scope link src 192.168.1.28 metric 300
      192.168.2.0/24 dev eth0 proto kernel scope link src 192.168.2.7 metric 100
      192.168.2.1 dev eth0 proto dhcp scope link src 192.168.2.7 metric 100
      192.168.2.2 dev eth0 proto dhcp scope link src 192.168.2.7 metric 100
      192.168.4.0/24 dev eth1 proto kernel scope link src 192.168.4.20 metric 200
      192.168.4.1 dev eth1 proto dhcp scope link src 192.168.4.20 metric 200
      192.168.4.2 dev eth1 proto dhcp scope link src 192.168.4.20 metric 200
      ```

      The routes for all the network interfaces are configured.

      {% note info %}

      If the network interfaces you added are inactive or you can no longer [connect](../vm-connect/ssh.md) to your VM, see [Troubleshooting](../../qa/troubleshooting.md).

      {% endnote %}


- Windows {#windows}

  1. [Connect](../vm-connect/rdp.md) to the VM over RDP.
  1. To get information about the state of the VM network interfaces, run this command in PowerShell:

      ```powershell
      ipconfig /all
      ```

      Result:

      ```txt
      Windows IP Configuration

         Host Name . . . . . . . . . . . . : windows-vm
         Primary Dns Suffix  . . . . . . . :
         Node Type . . . . . . . . . . . . : Hybrid
         IP Routing Enabled. . . . . . . . : No
         WINS Proxy Enabled. . . . . . . . : No
         DNS Suffix Search List. . . . . . : {{ region-id }}.internal
                                             auto.internal

      Ethernet adapter Ethernet:

         Connection-specific DNS Suffix  . : {{ region-id }}.internal
         Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter
         Physical Address. . . . . . . . . : D0-2D-7E-E7-46-C5
         DHCP Enabled. . . . . . . . . . . : Yes
         Autoconfiguration Enabled . . . . : Yes
         Link-local IPv6 Address . . . . . : fe80::788f:1f20:e4e4:2f17%10(Preferred)
         IPv4 Address. . . . . . . . . . . : 192.168.4.23(Preferred)
         Subnet Mask . . . . . . . . . . . : 255.255.255.0
         Lease Obtained. . . . . . . . . . : Sunday, May 5, 2024 8:33:25 AM
         Lease Expires . . . . . . . . . . : Wednesday, June 11, 2160 3:05:02 PM
         Default Gateway . . . . . . . . . : 192.168.4.1
         DHCP Server . . . . . . . . . . . : 192.168.4.2
         DHCPv6 IAID . . . . . . . . . . . : 181415294
         DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2D-C8-FA-25-D0-0D-7E-E7-46-C5
         DNS Servers . . . . . . . . . . . : 192.168.4.2
         NetBIOS over Tcpip. . . . . . . . : Enabled
         Connection-specific DNS Suffix Search List :
                                             {{ region-id }}.internal
                                             auto.internal

      Ethernet adapter eth0:

         Connection-specific DNS Suffix  . : {{ region-id }}.internal
         Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter #2
         Physical Address. . . . . . . . . : D0-0D-7E-E7-46-C5
         DHCP Enabled. . . . . . . . . . . : Yes
         Autoconfiguration Enabled . . . . : Yes
         Link-local IPv6 Address . . . . . : fe80::5e90:6d59:693:3d74%5(Preferred)
         IPv4 Address. . . . . . . . . . . : 192.168.1.27(Preferred)
         Subnet Mask . . . . . . . . . . . : 255.255.255.0
         Lease Obtained. . . . . . . . . . : Sunday, May 5, 2024 8:33:23 AM
         Lease Expires . . . . . . . . . . : Wednesday, June 11, 2160 3:05:02 PM
         Default Gateway . . . . . . . . . : 192.168.1.1
         DHCP Server . . . . . . . . . . . : 192.168.1.2
         DHCPv6 IAID . . . . . . . . . . . : 131075350
         DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2D-C8-FA-25-D0-0D-7E-E7-46-C5
         DNS Servers . . . . . . . . . . . : 192.168.1.2
         NetBIOS over Tcpip. . . . . . . . : Enabled
         Connection-specific DNS Suffix Search List :
                                             {{ region-id }}.internal
                                             auto.internal

      Ethernet adapter Ethernet 2:

         Connection-specific DNS Suffix  . : {{ region-id }}.internal
         Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter #3
         Physical Address. . . . . . . . . : D0-1D-7E-E7-46-C5
         DHCP Enabled. . . . . . . . . . . : Yes
         Autoconfiguration Enabled . . . . : Yes
         Link-local IPv6 Address . . . . . : fe80::851a:86ae:28fd:90ce%11(Preferred)
         IPv4 Address. . . . . . . . . . . : 192.168.2.15(Preferred)
         Subnet Mask . . . . . . . . . . . : 255.255.255.0
         Lease Obtained. . . . . . . . . . : Sunday, May 5, 2024 8:33:25 AM
         Lease Expires . . . . . . . . . . : Wednesday, June 11, 2160 3:05:02 PM
         Default Gateway . . . . . . . . . : 192.168.2.1
         DHCP Server . . . . . . . . . . . : 192.168.2.2
         DHCPv6 IAID . . . . . . . . . . . : 198188414
         DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-2D-C8-FA-25-D0-0D-7E-E7-46-C5
         DNS Servers . . . . . . . . . . . : 192.168.2.2
         NetBIOS over Tcpip. . . . . . . . : Enabled
         Connection-specific DNS Suffix Search List :
                                             {{ region-id }}.internal
                                             auto.internal
      ```

      All the network interfaces are running and active.

{% endlist %}

#### See also {#see-also}

* [{#T}](./vm-attach-public-ip.md)
* [{#T}](./vm-set-static-ip.md)
* [{#T}](../../../vpc/operations/set-static-ip.md)
