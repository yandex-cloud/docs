---
title: Adding another network interface to a virtual machine
description: Follow this guide to add another network interface to a VM.
---

# Adding another network interface to a virtual machine


A virtual machine can have one or more [network interfaces](../../concepts/network.md). For more information on the maximum number of VM network interfaces, see [{#T}](../../concepts/limits.md).

You can add network interfaces to either [running](#add-to-running) or [stopped](#add-to-stopped) VMs. To maintain [network connectivity](../../../vpc/concepts/routing.md#rt-vm), we recommend adding network interfaces to stopped VMs.

## Adding a network interface to a stopped VM {#add-to-stopped}

To add another network interface to your virtual machine:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for adding a network interface to a virtual machine:

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

      Save the ID of the subnet you want to attach to the VM's network interface being added. The subnet must be in the same [availability zone](../../../overview/concepts/geo-scope.md) as the VM.

  1. Get a list of all [security groups](../../../vpc/concepts/security-groups.md) in the default folder:

      {% include [add-network-interface-cli-list-sgs](../../../_includes/compute/add-network-interface-cli-list-sgs.md) %}

      Save the IDs of the security groups you want to attach to the VM's network interface being added. The security groups must be in the same [cloud network](../../../vpc/concepts/network.md#network) as the subnet being attached.

  1. Get a list of used network interface numbers for the selected VM by specifying its ID:

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

- API {#api}

  {% include [add-network-interface-api](../../../_includes/compute/add-network-interface-api.md) %}

{% endlist %}

Now your VM features a new network interface. [Make sure](#test) it works.


## Adding a network interface to a running VM {#add-to-running}

{% note info %}

{% include [add-network-interface-hotplug-preview-note](../../../_includes/compute/add-network-interface-hotplug-preview-note.md) %}

{% endnote %}

To add another network interface to your virtual machine:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for adding a network interface to a virtual machine:

      ```bash
      yc compute instance attach-network-interface --help
      ```

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

      Save the ID of the VM you want to add another network interface to.

  1. Get a list of all [subnets](../../../vpc/concepts/network.md#subnet) in the default folder:

      {% include [add-network-interface-cli-list-subnets](../../../_includes/compute/add-network-interface-cli-list-subnets.md) %}

      Save the ID of the subnet you want to attach to the VM's network interface being added. The subnet must be in the same [availability zone](../../../overview/concepts/geo-scope.md) as the VM.

  1. Get a list of all [security groups](../../../vpc/concepts/security-groups.md) in the default folder:

      {% include [add-network-interface-cli-list-sgs](../../../_includes/compute/add-network-interface-cli-list-sgs.md) %}

      Save the IDs of the security groups you want to attach to the VM's network interface being added. The security groups must be in the same [cloud network](../../../vpc/concepts/network.md#network) as the subnet being attached.

  1. Get a list of used network interface numbers for the selected VM by specifying its ID:

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
  1. Run this command to get information about the state of VM's network interfaces:

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

To make it active, [restart](./vm-stop-and-start.md#restart) the VM. For Windows OS, restarting the VM is the only way to activate the interface.

If your VM is running Linux and you cannot restart it, you can activate the network interface without restarting the VM. To avoid network connectivity loss, configure settings from the [serial console](../serial-console/index.md):

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Enable](../serial-console/index.md#turn-on-for-current-instance) access to the serial console on your VM.

      When creating a user for authenticating on the VM through the serial console, add this user to the `sudo` group using the `sudo usermod -a -G sudo <username>` command.

  1. Connect to the VM's serial console [via the CLI](../serial-console/connect-cli.md#connect-to-serial-console) or [SSH](../serial-console/connect-ssh.md#connect-to-serial-console).

  1. Activate the network interface you have added:

      ```bash
      sudo ip link set <interface_name> up
      ```

      Where `<interface_name>` is the name of the inactive interface in Linux, e.g., `eth2`. You can view the names of network interfaces in the Linux terminal using the `ip a` command.

  1. Get DHCP settings for the new interface:

      ```bash
      sudo dhclient <interface_name>
      ```

  1. Delete the default route for the new network interface from the [VM's route table](../../../vpc/concepts/routing.md#rt-vm):

      ```bash
      sudo ip route del default dev <interface_name>
      ```

  1. [Disable](../serial-console/disable.md) access to the VM's serial console if you no longer need it.

{% endlist %}

Now the attached network interface is active.


## Make sure the new network interface works properly {#test}

To test the new network interface:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Connect](../vm-connect/ssh.md#vm-connect) to the VM over SSH.
  1. Run this command to get information about the state of VM's network interfaces:

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

  1. To view the [VM's route table](../../../vpc/concepts/routing.md#rt-vm), run this command:

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

  1. [Connect](../vm-connect/rdp.md) to the VM via RDP.
  1. To get information about the state of the VM's network interfaces, run this command in PowerShell:

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