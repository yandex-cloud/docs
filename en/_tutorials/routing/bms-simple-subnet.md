# Establishing network connectivity in a {{ baremetal-full-name }} private subnet

If you set up routing for a [private subnet](../../baremetal/concepts/network.md#private-subnet) and assigned it a [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing), the network interfaces of [{{ baremetal-name }} servers](../../baremetal/concepts/servers.md) connected to this subnet will get IP addresses from the range specified in the subnet’s CIDR settings via [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol).

However, if you did not set up routing for a private subnet, this subnet functions as an [OSI](https://en.wikipedia.org/wiki/OSI_model) L2 network, where DHCP does not work, and you need to assign IP addresses manually in the server network interface settings to establish network connectivity. 

This is because the DHCP server becomes part of a private subnet only once the subnet is routable and connected to a [virtual network segment](../../baremetal/concepts/network.md#vrf-segment) (VRF).

{% note info %}

If the server OS is installed from [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}) images, all physical interfaces on this server are configured to use DHCP for IP address assignment by default.

{% endnote %}

To learn more about networks in {{ baremetal-full-name }}, see [{#T}](../../baremetal/concepts/network.md).

In this tutorial, you will learn how to manually disable DHCP on a network interface from a {{ baremetal-name }} server private subnet and assign it a static IP address. You will also learn to re-enable DHCP on the server's network interface after routing is enabled in this subnet.

In this example, you will use {{ baremetal-name }} servers running Linux Ubuntu 24.04 LTS. If using another OS, you will follow the same steps, but the way you configure network interfaces may differ. For network interface configuration steps in other operating systems, refer to the relevant OS tutorials

To configure network connectivity in a {{ baremetal-full-name }} subnet:

1. [Get your cloud ready](#before-you-begin).
1. [Create a private subnet](#create-subnet).
1. [Lease {{ baremetal-name }} servers](#rent-servers).
1. [Manually configure the network interfaces](#setup-interfaces).
1. [Create a VRF segment and enable routing in the private subnet](#setup-vrf).
1. [Enable DHCP on the network interfaces](#re-enable-dhcp).

See also [How to cancel server lease](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of the proposed solution includes the {{ baremetal-name }} server lease fee (see [{{ baremetal-full-name }} pricing](../../baremetal/pricing.md)).

## Create a private subnet {#create-subnet}

Create a private subnet in the `{{ region-id }}-m3` [server pool](../../baremetal/concepts/servers.md#server-pools):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are going to create your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}** and click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-pool }}** field, select the `{{ region-id }}-m3` server pool.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter the subnet name: `subnet-m3`.
  1. Without enabling the **{{ ui-key.yacloud.baremetal.title_routing-settings }}** option, click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

{% endlist %}


## Lease {{ baremetal-name }} servers {#rent-servers}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. {% include [server-lease-step2](../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-config }}**, click the `{{ ui-key.yacloud.baremetal.servers.ConfigurationField.poolFilter_frWLA }}` filter and select the `{{ region-id }}-m3` server pool.
  1. {% include [server-lease-step5](../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
  1. {% include [server-lease-step6](../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select the `Ubuntu 24.04` image.
  1. {% include [server-lease-step6-substep](../../_includes/baremetal/instruction-steps/server-lease-step6-substep.md) %}
  1. Under **Network settings**:

     1. In the **{{ ui-key.yacloud.baremetal.field_subnet-id }}** field, select `subnet-m3` you created earlier.
     1. In the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field, select `{{ ui-key.yacloud.baremetal.label_public-ip-no }}`.
  1. Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      {% include [server-lease-access](../../_includes/baremetal/server-lease-access.md) %}

  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-info }}**, in the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter the server name: `server-m3-1`.
  1. {% include [server-lease-step12](../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}
  1. Similarly, lease one more server named `server-m3-2` in the `{{ region-id }}-m3` server pool.

{% endlist %}

{% note info %}

Getting servers ready and installing operating systems on them may take up to 45 minutes. The servers will have the `Provisioning` status during this time. After OS installation is complete, the server status will change to `Ready`.

{% endnote %}

## Manually configure the network interfaces {#setup-interfaces}.

Since the DHCP server is disabled in the `subnet-m3` private subnet, the {{ baremetal-name }} servers you created have no internal IP addresses assigned or network connectivity established.

At this stage, you will connect to the servers and modify the settings of their network interfaces linked to the private subnet by disabling DHCP and assigning them static IP addresses.

No public IP addresses were assigned to the servers, so you cannot connect to them [over SSH](../../compute/operations/vm-connect/ssh.md). To connect to the servers, you will use the KVM console.

### Configure the network interfaces to use static IP addresses {#enable-static}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Next to `server-m3-1`, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
  
      The KVM console terminal window will open, showing a login prompt:
      
      ```
      server-m3-1 login:
      ```

      If you do not see this prompt, try [restarting](../../baremetal/operations/servers/server-stop-and-start.md#restart) the server.

      Perform all further actions described in this step in the KVM console terminal:

      1. Specify `root` for the username and press **ENTER**.
      1. Paste the password received when leasing the server in the password input line and press **ENTER**. Note that when typing or pasting a password in Linux, the characters you enter will not appear on the screen.

          {% include [kvm-paste-tip](../../_includes/baremetal/kvm-paste-tip.md) %}

          Result:

          ```text
          Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-53-generic x86_64)
          ...
          root@server-m3-1:~# _
          ```

          If you did not save the server administrator password, you can create a new password following [this guide](../../baremetal/operations/servers/reset-password.md) or [reinstall](../../baremetal/operations/servers/reinstall-os-from-marketplace.md) the server OS.
      1. View a list of the server's network interfaces and find the interface connected to the private subnet:

          ```bash
          ip a
          ```

          Result:

          ```text
          ...
          5: etx2: <BROADCAST, MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ma state UP group default qlen 1000
              link/ether 00:02:09:35:fd:31 brd ff:ff:ff:ff:ff:ff
              altname enp6s0d1
              inet6 fe80::202:c9ff:fe35:fd31/64 scope link
                  valid_lft forever preferred_lft forever
          ...
          ```

          Since the server has no public IP address, its only active network interface (with the `state UP` status) is the one connected to the private subnet. In the example above, this interface has the `etx2` ID. In the next step, you will assign a static IP address to this interface.

          {% note tip %}

          To make sure the correct network interface is selected, use its MAC address. You can [view](../../baremetal/operations/servers/get-info.md) the MAC address of your {{ baremetal-name }} server’s network interface on the server information page under **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}**.

          {% endnote %}

      1. Open the server network interface configuration file:

          ```bash
          nano /etc/netplan/50-cloud-init.yaml
          ```
      1. In the file, edit the network interface settings:

          ```yaml
          network:
            version: 2
            ethernets:
              ... # This example shows only the configuration of the interface you need to set up.
              etx2:
                match:
                  macaddress: "00:02:09:35:fd:31"
                dhcp4: false # Here, opt out of using DHCP.
                addresses: # Set the interface static IP address in this section.
                  - 192.168.1.101/24
                set-name: "etx2"
          ```

          For the `etx2` interface, configure the following settings:

          * Change the `dhcp4` value to `false` to opt out of using DHCP and set the interface IP address statically.
          * Add the `addresses` section with the internal static IP address assigned to the server. Each server's address must be unique within the subnet.

              {% note info %}

              {% include [internal-addressing-rules](../../_includes/baremetal/internal-addressing-rules.md) %}

              {% endnote %}

          To save the changes and exit the text editor, press **Ctrl + X** and confirm saving changes to the `50-cloud-init.yaml` file.
      1. Apply your changes:

          ```bash
          netplan apply
          ```
      1. Make sure the network interface was assigned an IP address. To do this, run the following command and filter the output by the interface ID:

          ```bash
          ip a | grep etx2
          ```

          Result:

          ```text
          5: etx2: <BROADCAST,MULTICAST, UP,LOWER_UP> mtu 1500 qdisc ma state UP group default qlen 1000
              inet 192.168.1.101/24 brd 192.168.1.255 scope global etx2
          ```

          The network interface is configured to use the `192.168.1.101` static IP address in `subnet-m3`.
  1. Similarly, configure the `server-m3-2` network interface by assigning it the `192.168.1.102/24` static IP address in the netplan settings.

{% endlist %}

### Test network connectivity between the servers {#validate-connectivity}

By reconfiguring the network interfaces of the servers in the private subnet, you established network connectivity between them. Here is how you can test it:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Next to `server-m3-1`, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
  1. Authenticate as the `root` user in the KVM console terminal with the password you saved when leasing the server.
  1. In the KVM console terminal, run the `ping` command to make sure you can access `server-m3-2` by its IP address, `192.168.1.102`:

      ```bash
      ping 192.168.1.102 -c 5
      ```

      Result:

      ```text
      PING 192.168.1.102 (192.168.1.102) 56(84) bytes of data.
      64 bytes from 192.168.1.102: icmp_seq=1 ttl=64 time=3.90 ms
      64 bytes from 192.168.1.102: icmp_seq=2 ttl=64 time=0.235 ms
      64 bytes from 192.168.1.102: icmp_seq=3 ttl=64 time=0.222 ms
      64 bytes from 192.168.1.102: icmp_seq=4 ttl=64 time=0.231 ms
      64 bytes from 192.168.1.102: icmp_seq=5 ttl=64 time=0.235 ms

      --- 192.168.1.102 ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4086ms
      rtt min/avg/max/mdev = 0.222/0.964/3.899/1.467 ms
      ```

      Network connectivity between the servers has been established with zero packet loss.

{% endlist %}

## Create a VRF segment and enable routing in the private subnet {#setup-vrf}

To enable the DHCP server in the private subnet, create a virtual network segment (VRF) and enable routing in the subnet by linking it to that VRF.


### Create a virtual network segment (VRF) {#create-vrf}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** and click **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, name your VRF segment: `my-vrf`.
  1. Click **{{ ui-key.yacloud.baremetal.label_create-network }}**.

{% endlist %}

### Connect the private subnet to the VRF segment {#connect-subnet-to-vrf} 

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}**.
  1. Next to `subnet-m3`, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. In the window that opens:
  
      1. Enable **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
      1. In the **{{ ui-key.yacloud.baremetal.field_network-id }}** field, select the previously created segment, `my-vrf`.
      1. In the **{{ ui-key.yacloud.baremetal.field_CIDR }}** field, specify `192.168.1.0/24`.
      1. In the **{{ ui-key.yacloud.baremetal.field_gateway }}** field, keep the default value, `192.168.1.1`.
      1. Enable the **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** option and in the **{{ ui-key.yacloud.baremetal.field_dhcp-ip-range }}** field that appears, leave the default values, `192.168.1.1` — `192.168.1.254`.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}

## Enable DHCP on the network interfaces {#re-enable-dhcp}

After you enabled routing in the private subnet and connected it to the VRF segment, a DHCP server starts automatically in this subnet. To allow network interfaces of your {{ baremetal-name }} servers to obtain IP addresses via DHCP, you need to enable DHCP in their configuration.

{% note info %}

The DHCP server that serves VRF-enabled private subnets can only assign IP addresses to physical interfaces of trusted {{ baremetal-name }} servers. Therefore, you cannot assign IP addresses from a private subnet to containers or VMs running on your server.

{% endnote %}

### Enable DHCP {#enable-dhcp}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Next to `server-m3-1`, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
  1. Authenticate as the `root` user in the KVM console terminal with the password you saved when leasing the server. Perform all further actions described in this step in the KVM console terminal:
  
      1. Open the server network interface configuration file:

          ```bash
          nano /etc/netplan/50-cloud-init.yaml
          ```
      1. In the file, edit the settings of the network interface connected to the private subnet:

          ```yaml
          network:
            version: 2
            ethernets:
              ... # This example shows only the configuration of the interface connected to the private subnet.
              etx2:
                match:
                  macaddress: "00:02:09:35:fd:31"
                dhcp4: true # Here, enable DHCP.
                # Comment out or delete the addresses section.
                # addresses:
                #   - 192.168.1.101/24
                set-name: "etx2"
          ```

          Configure the following settings for the interface:

          * Change the `dhcp4` value to `true` to enable DHCP for automatic IP address assignment on this interface.
          * Comment out or delete the `addresses` section with the internal static IP address assigned to the server.

          To save the changes and exit the text editor, press **Ctrl + X** and confirm saving changes to the `50-cloud-init.yaml` file.
      1. Apply your changes:

          ```bash
          netplan apply
          ```
      1. Make sure the network interface was assigned an IP address. To do this, run the following command and filter the output by the interface ID:

          ```bash
          ip a | grep etx2
          ```

          Result:

          ```text
          5: etx2: <BROADCAST,MULTICAST, UP,LOWER_UP> mtu 1500 qdisc ma state UP group default qlen 1000
              inet 192.168.1.2/24 metric 100 brd 192.168.1.255 scope global dynamic etx2
          ```

          The `server-m3-1` network interface is assigned the `192.168.1.2` IP address in the private subnet named `subnet-m3`.
  1. Similarly, configure the `server-m3-2` network interface and save the IP address assigned to it in the private subnet. In our example, this is `192.168.1.3`.

{% endlist %}

### Test network connectivity between the servers {#revalidate-connectivity}

Make sure the servers retained network connectivity after obtaining IP addresses in the private subnet via DHCP.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Next to `server-m3-1`, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
  1. Authenticate as the `root` user in the KVM console terminal with the password you saved when leasing the server.
  1. In the KVM console terminal, run the `ping` command to make sure you can access `server-m3-2` by the IP address you saved in the previous step (`192.168.1.3` in our example):

      ```bash
      ping 192.168.1.3 -c 5
      ```

      Result:

      ```text
      PING 192.168.1.3 (192.168.1.3) 56(84) bytes of data.
      64 bytes from 192.168.1.3: icmp_seq=1 ttl=64 time=0.271 ms
      64 bytes from 192.168.1.3: icmp_seq=2 ttl=64 time=0.215 ms
      64 bytes from 192.168.1.3: icmp_seq=3 ttl=64 time=0.262 ms
      64 bytes from 192.168.1.3: icmp_seq=4 ttl=64 time=0.223 ms
      64 bytes from 192.168.1.3: icmp_seq=5 ttl=64 time=0.208 ms

      --- 192.168.1.3 ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4106ms
      rtt min/avg/max/mdev = 0.208/0.235/0.271/0.025 ms
      ```

      Network connectivity between the servers has been established with zero packet loss.

{% endlist %}

## How to cancel server lease {#clear-out}

You cannot delete {{ baremetal-name }} servers. Instead, you can choose not to renew their lease.

To stop paying for the resources you created, [cancel](../../baremetal/operations/servers/server-lease-cancel.md) the lease of the {{ baremetal-name }} servers you created earlier.