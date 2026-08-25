# Manually assigning a public IP address to a {{ baremetal-name }} server

There is no [DHCP server](../../baremetal/concepts/dhcp.md#dhcp-public-subnet) in the [dedicated public subnet](../../baremetal/concepts/public-network.md#public-subnet) of [{{ baremetal-name }} servers](../../baremetal/concepts/servers.md). Therefore, on the network interface of the server connected to such a subnet, you should manually set a static public IP address from the subnet address range, plus specify the default gateway address and DNS servers.

{% include [public-subnet-address-info](../../_includes/baremetal/public-subnet-address-info.md) %}

{% note info %}

The steps described in this guide also apply to the [ephemeral public subnet](../../baremetal/concepts/public-network.md#ephemeral-public-subnet) if its DHCP server was off when the server was rented. The ephemeral public subnet is always `/31` in size and consists of these two addresses: the first one is the default gateway address, and the second one is the server's public IP address. For more information, see [{#T}](../../baremetal/concepts/dhcp.md#dhcp-ephemeral-public-subnet).

For Windows servers, you have to manually assign a public IP address in any ephemeral /31 public subnet, even if its DHCP server is on. This is because the Windows DHCP client cannot issue addresses in /31 subnets.

{% endnote %}

To learn more about networks in {{ baremetal-full-name }}, see [{#T}](../../baremetal/concepts/network.md).

In this guide, you will learn how to manually configure a public IP address on the network interface of a {{ baremetal-name }} server connected to a dedicated public subnet. This example uses servers running Ubuntu 24.04 LTS, AlmaLinux 9, and Windows Server 2022. If using another OS, you will follow the same steps, but the way you configure network interfaces may differ. For network interface configuration steps in other operating systems, refer to the relevant OS guides.

To assign a public IP address to a {{ baremetal-name }} server manually:

1. [Get your cloud ready](#before-you-begin).
1. [Order a dedicated public subnet](#create-public-subnet).
1. [Rent a {{ baremetal-name }} server](#rent-server).
1. [Obtain the public subnet parameters](#get-subnet-params).
1. [Connect to the server via the KVM console](#connect-via-kvm).
1. [Identify the public network interface](#identify-interface).
1. [Assign a static public IP address to the network interface](#assign-ip).
1. [Test network connectivity](#validate-connectivity).

See also [How to cancel a server rent](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of the proposed solution includes:

* Fee for renting a {{ baremetal-name }} server.
* Fee for renting a {{ baremetal-full-name }} dedicated public subnet.

For more information, see [{{ baremetal-full-name }} pricing](../../baremetal/pricing.md).

{% note warning %}

The minimum rent period for a dedicated public subnet is one month from the order date. You cannot delete such a subnet during the first month after ordering it.

{% endnote %}

## Order a dedicated public subnet {#create-public-subnet}

Order a [dedicated public subnet](../../baremetal/concepts/public-network.md#public-subnet) of size `/29` in the `{{ region-id }}-m3` server pool:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are going to create your infrastructure.
  1. [Navigate]({{ link-console-main }}/link/baremetal) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets_v16CV }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-public-subnet-full }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_zone-id }}** field, select the [availability zone](../../overview/concepts/geo-scope.md) where the subnet will be available.
  1. In the **{{ ui-key.yacloud.baremetal.field_hardware-pool-id }}** field, select the `{{ region-id }}-m3` server pool.
  1. In the subnet size field, select `/29`.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter the subnet name: `my-public-subnet`.
  1. Click **{{ ui-key.yacloud.baremetal.label_create-public-subnet }}**.

{% endlist %}

For more information on renting a public subnet, see [this section](../../baremetal/operations/reserve-public-subnet.md).

## Rent a {{ baremetal-name }} server {#rent-server}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. {% include [server-lease-step2](../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. Click **{{ ui-key.yacloud.baremetal.label_create-server }}** and, in the window that opens, select `{{ ui-key.yacloud_components.baremetal.StockConfigurations }}` and a suitable {{ baremetal-name }} server [configuration](../../baremetal/concepts/server-configurations.md) in the `{{ region-id }}-m3` server pool.

      Do it by selecting the `{{ region-id }}-m3` server pool in the filter on the right side of the window, under **{{ ui-key.yacloud_components.baremetal.poolFilter }}**.

      To select the suitable server configuration, click the section with its name in the central part of the screen.

      {% include [server-lease-save-with-assembling-tip](../../_includes/baremetal/instruction-steps/server-lease-save-with-assembling-tip.md) %}

  1. In the server configuration window that opens:

      1. {% include [server-lease-step5](../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
      1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select the image of the operating system you will be configuring the network interface in (`Ubuntu 24.04`, `AlmaLinux 9`, or `Windows Server 2022`).
      1. {% include [server-lease-step8](../../_includes/baremetal/instruction-steps/server-lease-step8.md) %}
      1. Under **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}**:
          1. In the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field, select `{{ ui-key.yacloud.baremetal.label_public-ip-from-dedicated-subnet }}`.
          1. In the public subnet selection field that appears, specify the previously created `my-public-subnet`.

      1. Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../_includes/baremetal/server-lease-access.md) %}

      1. Under **{{ ui-key.yacloud.baremetal.title_section-server-info }}**, in the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter the server name: `my-server`.
      1. {% include [server-lease-step13](../../_includes/baremetal/instruction-steps/server-lease-step13.md) %}

{% endlist %}

{% note info %}

Server setup and OS installation may take up to 45 minutes. The server will have the `Provisioning` status during this time. After OS installation is complete, the server status will change to `Ready`.

{% endnote %}

## Obtain the public subnet parameters {#get-subnet-params}

Before configuring the network interface, find out the parameters of the dedicated public subnet the server is connected to: CIDR, default gateway address, and range of available public IP addresses.

1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
1. [Navigate]({{ link-console-main }}/link/baremetal) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
1. In the left-hand panel, select ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets_v16CV }}** and open the `my-public-subnet` information page.
1. Write down the CIDR values, default gateway address, and range of available public IP addresses.

   For a subnet of size `/29` (eight IP addresses in CIDR):

   * The first IP address in the range is the subnet address.
   * The second IP address in the range is the default gateway address.
   * From the third to second-last one are addresses available for server network interfaces.
   * The last IP address in the range is the [broadcast](https://en.wikipedia.org/wiki/Broadcast_address) (`broadcast`) address.

   For example, if the subnet CIDR is `198.51.100.104/29`:

   * Subnet IP address: `198.51.100.104`.
   * Default gateway IP address: `198.51.100.105`.
   * Available addresses: From `198.51.100.106` to `198.51.100.110`.
   * Broadcast address: `198.51.100.111`.

   These values ​​will be used in example commands further on in this guide. Replace them with the values you got for your subnet.

## Connect to the server via the KVM console {#connect-via-kvm}

Before you configure a public IP address, the server is not accessible from the Internet, so you will not be able to connect to it via [SSH](../../compute/operations/vm-connect/ssh.md) or [RDP](../../compute/operations/vm-connect/rdp.md). To connect to the server, use the KVM console.

1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
1. [Navigate]({{ link-console-main }}/link/baremetal) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
1. Next to `my-server`, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.baremetal.label_kvm-console_37Kma }}**.

    A window with a KVM console terminal will open.

    If the terminal does not appear, try [restarting](../../baremetal/operations/servers/server-stop-and-start.md#restart) the server.

1. Authenticate to the server using the administrator password saved when renting the server (`root` for Linux, `Administrator` for Windows).

    {% include [kvm-paste-tip](../../_includes/baremetal/kvm-paste-tip.md) %}

    If you did not save the administrator password, you can create a new one as per [this guide](../../baremetal/operations/servers/reset-password.md) or [reinstall](../../baremetal/operations/servers/reinstall-os-from-marketplace.md) the server OS.

For more on connecting to a server via the KVM console, see [this section](../../baremetal/operations/servers/server-kvm.md).

## Identify the public network interface {#identify-interface}

To figure out which of the server's network interfaces is connected to the public network, match the interface name against the MAC address listed in the [management console]({{ link-console-main }}) on the server info page under **{{ ui-key.yacloud.baremetal.title_section-network-interfaces }}**

Write down the MAC address of the public network interface: you will need it for configuration.

{% list tabs group=operating_system %}

- Ubuntu/Debian/AlmaLinux {#linux}

  In the KVM console terminal, run this command:

  ```bash
  ip a
  ```

  Result:

  ```text
  ...
  2: etx1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
      link/ether 00:25:90:c8:03:f8 brd ff:ff:ff:ff:ff:ff
      altname enp2s0f0
      inet6 fe80::225:90ff:fec8:3f8/64 scope link
          valid_lft forever preferred_lft forever
  3: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
      link/ether 00:25:90:c8:03:f9 brd ff:ff:ff:ff:ff:ff
      altname enp2s0f1
      inet6 fe80::225:90ff:fec8:3f9/64 scope link
          valid_lft forever preferred_lft forever
  ...
  ```

  In this example, the public MAC address from the management console is `00:25:90:c8:03:f9`, so the server's public network interface is `eth2`.

- Windows Server {#windows}

  In PowerShell, run:

  ```powershell
  Get-NetAdapter | Format-Table Name, InterfaceDescription, MacAddress, Status
  ```

  Result:

  ```text
  Name       InterfaceDescription                          MacAddress         Status
  ----       --------------------                          ----------         ------
  Ethernet   Mellanox ConnectX-4 Lx Adapter #1             00-25-90-C8-03-F8  Up
  Ethernet 2 Mellanox ConnectX-4 Lx Adapter #2             00-25-90-C8-03-F9  Up
  ```

  In this example, the public MAC address from the management console is `00:25:90:c8:03:f9`, so the server's public network interface is `Ethernet 2`.

{% endlist %}

{% note warning %}

If the rented server supports [MC-LAG](../../baremetal/concepts/mc-lag.md) and is installed from a [custom image](../../baremetal/concepts/images.md#user-images), the physical network interfaces are not automatically combined into aggregation groups. In which case we recommend to start by [configuring an aggregation group](../../baremetal/operations/servers/set-up-mc-lag.md) for a pair of public interfaces and then assign a static public IP address to the bond interface. In the bond interface settings, you should specify the MAC address of one of the physical interfaces of the aggregation group as the MAC address.

{% endnote %}

## Assign a static public IP address to the network interface {#assign-ip}

{% list tabs group=operating_system %}

- Ubuntu/Debian (Netplan) {#ubuntu}

  1. In the KVM console terminal, learn the name of the [Netplan](https://netplan.io/) configuration file:

      ```bash
      ls /etc/netplan/
      ```

      Result:

      ```text
      50-cloud-init.yaml
      ```
  1. Open the configuration file:

      ```bash
      nano /etc/netplan/50-cloud-init.yaml
      ```
  1. Update the public network interface settings:

      ```yaml
      network:
        version: 2
        ethernets:
          ... # This example shows only the public interface configuration.
          etx2:
            match:
              macaddress: "00:25:90:c8:03:f9"
            dhcp4: false # Disable DHCP on the interface
            set-name: "etx2"
            addresses: # Set a static public IP address and subnet mask
              - 198.51.100.106/29
            routes: # Set the default route through the public subnet gateway
              - to: default
                via: 198.51.100.105
            nameservers: # Set DNS servers
              addresses: [77.88.8.8, 77.88.8.1]
      ```

      Where:

      * `match.macaddress`: MAC address of the public network interface.
      * `dhcp4`: `false` disables DHCP on the interface.
      * `addresses`: Public IP address from the range of available subnet addresses, with the subnet mask in CIDR format.
      * `routes.to: default` and `via`: Default route through the public subnet gateway address.
      * `nameservers.addresses`: DNS server addresses.

      To save the changes and exit the text editor, press **Ctrl + X** and confirm saving changes to the `50-cloud-init.yaml` file.
  1. Make sure the configuration is correct:

      ```bash
      netplan try
      ```

      If the configuration is free of errors, the utility will temporarily apply it and prompt you to confirm the changes. Confirm the changes by pressing **ENTER**.
  1. Apply the new configuration:

      ```bash
      netplan apply
      ```

- AlmaLinux/RHEL/CentOS (NetworkManager) {#almalinux}

  To configure the network interface, use `nmcli`. You can also use the `nmtui` graphical utility, which provides an interactive text interface to go with NetworkManager.

  1. View the list of network connections in the KVM console terminal:

      ```bash
      nmcli connection show
      ```

      Result:

      ```text
      NAME         UUID                                  TYPE      DEVICE
      System etx1  5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03  ethernet  etx1
      System etx2  5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e04  ethernet  etx2
      ```

      Find the connection name for the public network interface. In this example, `System etx2`.
  1. Set a static public IP address, default gateway, and DNS servers for the connection:

      ```bash
      nmcli connection modify "System etx2" \
        ipv4.method manual \
        ipv4.addresses 198.51.100.106/29 \
        ipv4.gateway 198.51.100.105 \
        ipv4.dns "77.88.8.8 77.88.8.1" \
        connection.autoconnect yes
      ```

      Where:

      * `ipv4.method manual`: Disables DHCP and switches the connection to static configuration mode.
      * `ipv4.addresses`: Public IP address from the range of available subnet addresses, with the subnet mask in CIDR format.
      * `ipv4.gateway`: Public subnet gateway address.
      * `ipv4.dns`: DNS server addresses separated by spaces.
      * `connection.autoconnect yes`: Automatically activates the connection on system boot.
  1. Activate the connection:

      ```bash
      nmcli connection up "System etx2"
      ```

- Windows Server (GUI) {#windows-gui}

  1. In the KVM console, go **Start** → **Control Panel** → **Network and Internet** → **Network and Sharing Center**.
  1. In the left-hand panel, select **Change adapter settings**.
  1. In the list that opens, find the network adapter matching the public network interface, e.g., `Ethernet 2`, right-click it and select **Properties**.
  1. In the list of connection components, select **Internet Protocol Version 4 (TCP/IPv4)** and click **Properties**.
  1. Select **Use the following IP address** and fill out the fields:

      * **IP address**: Public IP address from the range of available subnet addresses, e.g., `198.51.100.106`.
      * **Subnet mask**: Subnet mask matching the CIDR notation, e.g., `/29`: `255.255.255.248`.
      * **Default gateway**: Public subnet gateway address, e.g., `198.51.100.105`.
  1. Select **Use the following DNS server addresses** and fill out the fields:

      * **Preferred DNS server**: `77.88.8.8`.
      * **Alternate DNS server**: `77.88.8.1`.
  1. Click **OK** in both windows to save the settings.

- Windows Server (PowerShell) {#windows-cli}

  In the PowerShell terminal in the KVM console:

  1. Remove the existing IPv4 configuration on the public network interface if you got it over DHCP:

      ```powershell
      Set-NetIPInterface -InterfaceAlias "Ethernet 2" -Dhcp Disabled
      Remove-NetIPAddress -InterfaceAlias "Ethernet 2" -AddressFamily IPv4 -Confirm:$false
      Remove-NetRoute -InterfaceAlias "Ethernet 2" -AddressFamily IPv4 -Confirm:$false
      ```
  1. Set a static public IP address and default gateway:

      ```powershell
      New-NetIPAddress -InterfaceAlias "Ethernet 2" `
        -IPAddress 198.51.100.106 `
        -PrefixLength 29 `
        -DefaultGateway 198.51.100.105
      ```

      Where:

      * `-InterfaceAlias`: Name of the public network interface.
      * `-IPAddress`: Public IP address from the range of available subnet addresses.
      * `-PrefixLength`: Subnet mask prefix length (for `/29`: `29`).
      * `-DefaultGateway`: Public subnet gateway address.
  1. Set DNS servers for the interface:

      ```powershell
      Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" `
        -ServerAddresses ("77.88.8.8","77.88.8.1")
      ```

{% endlist %}

## Test network connectivity {#validate-connectivity}

Make sure the network interface got a public IP address and the server has access to the internet.

{% list tabs group=operating_system %}

- Ubuntu/Debian/AlmaLinux {#linux}

  1. Check that the specified IP address has been assigned to the network interface:

      ```bash
      ip a | grep etx2
      ```

      Result:

      ```text
      3: etx2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
          inet 198.51.100.106/29 brd 198.51.100.111 scope global etx2
      ```
  1. Check the route table:

      ```bash
      ip r
      ```

      Result:

      ```text
      default via 198.51.100.105 dev etx2 proto static
      198.51.100.104/29 dev etx2 proto kernel scope link src 198.51.100.106
      ```
  1. Check the DNS settings:

      ```bash
      resolvectl status
      ```
  1. Check internet connectivity:

      ```bash
      ping ya.ru -c 5
      ```

      Result:

      ```text
      PING ya.ru (77.88.55.88) 56(84) bytes of data.
      64 bytes from ya.ru (77.88.55.88): icmp_seq=1 ttl=55 time=3.45 ms
      64 bytes from ya.ru (77.88.55.88): icmp_seq=2 ttl=55 time=3.22 ms
      ...

      --- ya.ru ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4006ms
      rtt min/avg/max/mdev = 3.215/3.337/3.452/0.085 ms
      ```

- Windows Server {#windows}

  1. In PowerShell, check that the specified IP address has been assigned to the network interface:

      ```powershell
      Get-NetIPAddress -InterfaceAlias "Ethernet 2" -AddressFamily IPv4
      ```
  1. Check the route table:

      ```powershell
      Get-NetRoute -InterfaceAlias "Ethernet 2" -AddressFamily IPv4
      ```
  1. Check the DNS settings:

      ```powershell
      Get-DnsClientServerAddress -InterfaceAlias "Ethernet 2"
      ```
  1. Check internet connectivity:

      ```powershell
      Test-NetConnection ya.ru -InformationLevel Detailed
      ```

{% endlist %}

Once a public IP address is assigned, you can connect to the server from the internet via that IP address using [SSH](../../compute/operations/vm-connect/ssh.md) (for Linux) or [RDP](../../compute/operations/vm-connect/rdp.md) (for Windows).

## How to cancel a rent {#clear-out}

You cannot delete a {{ baremetal-name }} server or a dedicated public subnet. Instead, you can choose not to renew their rent.

To stop paying for the resources you created:

1. [Cancel](../../baremetal/operations/servers/server-lease-cancel.md) rent renewal for the {{ baremetal-name }} server you created earlier.
1. After the minimum rent period (one month from the order date) has expired, delete the dedicated public subnet.

#### See also {#see-also}

* [{#T}](../../baremetal/concepts/public-network.md)
* [{#T}](../../baremetal/concepts/dhcp.md)
* [{#T}](../../baremetal/operations/reserve-public-subnet.md)
* [{#T}](../../baremetal/operations/servers/set-up-mc-lag.md)
* [{#T}](../../baremetal/tutorials/bms-simple-subnet.md)
