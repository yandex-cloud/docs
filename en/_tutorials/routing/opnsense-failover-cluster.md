# Configuring OPNsense firewall in high availability cluster mode on {{ baremetal-full-name }} servers

This solution allows configuring an [OPNsense](https://opnsense.org/) perimeter firewall on {{ baremetal-name }} [servers](../../baremetal/concepts/servers.md). Apart from being the main gateway and a [stateful firewall](https://en.wikipedia.org/wiki/Stateful_firewall), OPNsense will also function as a [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol) server in a highly available configuration.

The idea of this solution is that only the OPNsense [firewall](https://en.wikipedia.org/wiki/Firewall_(computing)) servers are connected to the internet, thus ensuring a secure network segment behind them.

The solution must be fault-tolerant, so a [high availability cluster](https://en.wikipedia.org/wiki/High-availability_cluster) is the proposed configuration. To achieve gateway fault tolerance, the Common Address Redundancy Protocol ([CARP](https://docs.freebsd.org/en/books/handbook/advanced-networking/#carp)) is used.

For the secure network segment clients to automatically get IP addresses and the correct gateway address, the solution employs an ISC DHCPv4 server in a high-availability configuration. With OPNsense, the list of DHCP addresses can be replicated between the cluster servers with the Master and Backup roles.

Solution diagram:

![opnsense-failover-cluster](../../_assets/tutorials/opnsense-failover-cluster.svg)

* [Public {{ baremetal-name }} subnet](../../baremetal/concepts/network.md#public-network) of the `{{ region-id }}-m4` [server pool](../../baremetal/concepts/servers.md#server-pools).
* [Private {{ baremetal-name }} subnet](../../baremetal/concepts/network.md#private-subnet): `opnsense-private-subnet-m4`.
* Two {{ baremetal-name }} servers within the OPNsense cluster: `opnsense-master` and `opnsense-backup`. This guide uses OPNsense firewall version `25.1`.
* One {{ baremetal-name }} server, `vmware-esxi` running the VMware [ESXi](https://en.wikipedia.org/wiki/VMware_ESXi) virtualization platform. This guide uses ESXi hypervisor version `7.0U3g`.
* The `vmware-esxi` server runs a VM instance named `opnsense-tester-vm`. This guide uses a [Linux Ubuntu 24.04](https://releases.ubuntu.com/24.04/) VM created without a graphical user interface (GUI).
* [Installation server](https://en.wikipedia.org/wiki/Jump_server), `jump-server`, required for configuring your OPNsense and ESXi servers and accessing their private IP addresses.

    The installation server must have a [GUI](https://en.wikipedia.org/wiki/Graphical_user_interface) and a [web browser](https://en.wikipedia.org/wiki/Web_browser). To make the configuration process easier for you, in this guide, the role of the installation server will be played by a {{ baremetal-name }} server booted into recovery and diagnostics mode from the [Rescue CD](../../baremetal/operations/servers/rescue-boot.md).

    {% note info %}

    As an alternative to the Rescue CD, you can use a VPN connection to access the private IP addresses of your servers from outside the private subnet. Using a VPN connection on OPNsense servers requires configuring a static route to a network segment outside of the current private subnet.

    {% endnote %}

To configure your OPNsense firewall in high availability cluster mode on {{ baremetal-full-name }} servers:

1. [Get your cloud ready](#before-you-begin).
1. [Create your boot images in {{ baremetal-name }}](#create-images).
1. [Create a private {{ baremetal-name }} subnet](#create-subnet).
1. [Lease {{ baremetal-name }} servers](#rent-servers).
1. [Configure an OPNsense high availability cluster](#setup-opnsense).
1. [Install a hypervisor and create a virtual machine](#setup-esxi).
1. [Test the solution](#test-solution).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of the proposed solution includes: 
* Fee for leasing the {{ baremetal-name }} servers (see [{{ baremetal-full-name }} pricing](../../baremetal/pricing.md)).
* Fee for [data storage](../../storage/concepts/bucket.md) in {{ objstorage-name }} and data [operations](../../storage/operations/index.md) (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).

## Create your boot images in {{ baremetal-name }} {#create-images}

The OPNsense firewall and ESXi hypervisor will be installed on your {{ baremetal-name }} servers from the custom {{ baremetal-name }} boot images you will prepare before you begin deploying the infrastructure.

### Upload the software ISO images to {{ objstorage-full-name }} {#upload-isos}

To create the infrastructure proposed by this solution, you will need [ISO images](https://en.wikipedia.org/wiki/Optical_disc_image) with distributions to install OPNsense and VMware ESXi on your servers.

{% note info %}

{{ yandex-cloud }} does not provide distributions of these software products; you should purchase them yourself.

{% endnote %}

Upload the OPNsense and ESXi distribution images to your [{{ objstorage-name }}](../../storage/index.yaml) bucket:

1. If you have no {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) yet, [create](../../storage/operations/buckets/create.md) a bucket with limited access.
1. Upload the images to your bucket via the [management console](../../storage/operations/objects/upload.md), [AWS CLI](../../storage/tools/aws-cli.md), or [WinSCP](../../storage/tools/winscp.md). In {{ objstorage-name }} terms, the uploaded image files are _objects_.
1. [Get links](../../storage/operations/objects/link-for-download.md) to the images you uploaded. Use these links when creating the boot images in {{ baremetal-name }}.

### Create your boot images in {{ baremetal-name }} {#create-image}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you are going to create your infrastructure in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.baremetal.label_images }}**.
  1. Click **{{ ui-key.yacloud.baremetal.label_load-image }}**.
  1. Enter a name for your OPNsense image. The naming requirements are as follows:

       {% include [name-format](../../_includes/name-format.md) %}

  1. (Optional) Add a description for the image.
  1. Paste the link to the OPNsense image you got in {{ objstorage-name }}.
  1. Click **{{ ui-key.yacloud.baremetal.label_create-image }}**.
  1. Similarly, create an ESXi boot image.

{% endlist %}

## Create a private {{ baremetal-name }} subnet {#create-subnet}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your infrastructure in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}** and click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_server-pool }}** field, select the `{{ region-id }}-m4` server pool.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter a name for the subnet: `opnsense-private-subnet-m4`.
  1. Without enabling the **{{ ui-key.yacloud.baremetal.title_routing-settings }}** option, click **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

{% endlist %}

## Lease {{ baremetal-name }} servers {#rent-servers}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your infrastructure in.
  1. {% include [server-lease-step2](../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. In the **{{ ui-key.yacloud.baremetal.field_server-pool }}** field, select the `{{ region-id }}-m4` server pool.
  1. {% include [server-lease-step5](../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
  
      To test the solution, a configuration with minimum hardware specifications will be enough.
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select `{{ ui-key.yacloud.baremetal.field_choose-no-os }}`.
  1. {% include [server-lease-step6-substep](../../_includes/baremetal/instruction-steps/server-lease-step6-substep.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

      1. In the **{{ ui-key.yacloud.baremetal.field_subnet-id }}** field, select `opnsense-private-subnet-m4`, which you created earlier.
      1. In the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field, select `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}`.
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-info }}** in the **{{ ui-key.yacloud.baremetal.field_name }}** field, enter a name for the server: `opnsense-master`.
  1. {% include [server-lease-step12](../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}
  1. Similarly, lease one more server named `opnsense-backup` in the `{{ region-id }}-m4` server pool.
  1. Similarly, lease two more servers named `vmware-esxi` and `jump-server` in the `{{ region-id }}-m4` server pool. But select `{{ ui-key.yacloud.baremetal.label_public-ip-no }}` in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}** when filling the lease form.

{% endlist %}

{% note info %}

It may take up to 20 minutes to get the servers ready. During this time, the servers will have the `Provisioning` status, then switching to `Ready`.

{% endnote %}


## Configure an OPNsense high availability cluster {#setup-opnsense}

Configuring a high availability cluster involves installing the OPNsense firewall on two {{ baremetal-name }} servers, followed by creating and configuring an OPNsense cluster from those servers.

### Install the OPNsense firewall on your servers {#opnsense-server-installation}

{% note tip %}

To save time, you can run the OPNsense installation on your `opnsense-master` and `opnsense-backup` servers in two different browser windows at the same time. On both of these servers, the installation is performed in the same way.

{% endnote %}

1. [Connect](../../baremetal/operations/servers/server-kvm.md) to the `opnsense-master` server's KVM console.

    {% include [kvm-console-actions-notice](../_tutorials_includes/opnsense-failover-cluster/kvm-console-actions-notice.md) %}

1. In the KVM console window, select **Media** → **Virtual Media Wizard...** in the top menu or click the CD icon. In the window that opens:

      1. In the **CD/DVD Media1** section, click **Browse** and select the OPNsense image you saved earlier in the `user-iso` directory.
      1. Click **Connect CD/DVD**.
      1. Check the **Status** section for the **Virtual CD 1** device to make sure the **Connected To** field now gives the path to the image you selected, and click **Close**.
1. To boot the server up from the selected image, click **Reboot to cdrom** in the top-right corner of the KVM console.
1. Wait for the server to boot up and for the OPNsense interactive shell to initialize – this can take up to ten minutes.

    When the initialization is complete, the terminal screen in the KVM console will prompt you for authentication:

    ```
    login:
    ```
1. Authenticate with the following credentials:

    * Username: `installer`
    * Password: `opnsense`

    {% include [kvm-paste-tip](../../_includes/baremetal/kvm-paste-tip.md) %}
1. In the **Keymap Selection** window, keep the default value, `Continue with default keymap`, and press **Enter**.
1. In the action selection dialog box, select `Install (ZFS)` and press **Enter**.
1. Under **ZFS Configuration**, select `mirror` and press **Enter**.
1. In the next window dedicated to selecting block devices to create a virtual RAID array, use the **up and down arrows** and **space** to select the server HDDs or SSDs, e.g., `sda0` and `sda1`. Press **Enter**.
1. In the potential data loss alert window, confirm you agreement to modify the partition table. Use the **up and down arrows** to select `YES` and press **Enter**.

    This will start OPNsense installation on the server.

    {% note alert %}

    During the installation, do not close or refresh the KVM console window. Otherwise, the installation image will be unmounted from the {{ baremetal-name }} server, and you will have to restart the installation.

    The installation may take up to an hour.

    {% endnote %}
1. Once the installation is complete, select `Root Password` in the **Final Configuration** window to set a password for the `root` user and press **Enter**. Enter and confirm the password.
1. Once you set the password, select `Complete Install` in the **Final Configuration** window and press **Enter**.
1. In the **Installation Complete** window, select `Reboot now` and press **Enter**.
1. In the KVM console window, select **Media** → **Virtual Media Wizard...** in the top menu or click the CD icon. In the window that opens:

      1. Under **CD/DVD Media1**, click **Disconnect**. Check the **Status** section for the **Virtual CD 1** device to make sure the **Connected To** field value has changed to `Not connected`.
      1. Click **Close**.
1. Similarly, install OPNsense on the `opnsense-backup` server.

### Pre-configure your OPNsense servers {#opnsense-basic-config}

Before proceeding to configure the OPNsense cluster, pre-configure the network interfaces of both your OPNsense servers:

1. [Connect](../../baremetal/operations/servers/server-kvm.md) to the OPNsense server's KVM console.

    {% include [kvm-console-actions-notice](../_tutorials_includes/opnsense-failover-cluster/kvm-console-actions-notice.md) %}

1. Authenticate as the `root` user with the password you set when installing the server. If you had not set a password for the `root` user, the default one is `opnsense`.

    If authenticated successfully, you will see a text menu of basic server settings with a list of possible actions.
1. Make sure that network interfaces are set up in the system:

    {% note info %}

    Depending on the {{ baremetal-name }} server configuration, it can be equipped with `Intel` or `Mellanox` network cards. While the OS kernel automatically configures network interfaces for `Intel` cards, configuring network interfaces for `Mellanox` cards may involve additional steps.

    {% endnote %}

    1. Type in `8` (`Shell` option) and press **Enter** to open the OS terminal.
    1. Check for the network interfaces:

        ```bash
        ifconfig
        ```

        If the command output features network interfaces with the `LAN` and `WAN` descriptions (`description`), no additional actions are required. 

        For example:

        ```text
        igb0: flags=1008843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST,LOWER_UP> metric 0 mt
            description: LAN (lan)
            options=4802028<VLAN_MTU,JUMBO_MTU,WOL_MAGIC,HWSTATS,MEXTPG>
            ether 00:25:90:3:a1:fe
            inet 192.168.1.1 netmask Oxffffff00 broadcast 192.168.1.255
            inet6 fe80::225:90ff:fee3:a1fe%igb0 prefixlen 64 scopeid 0x1
            media: Ethernet autoselect (1000baseT ‹full-duplex>)
            status: active
            nd6 options=21<PERFORMNUD,AUTO_LINKLOCAL>

        igb1: flags=1008843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST,LOWER_UP> metric 0 mt
            description: WAN (wan)
            options=4800028<VLAN_MTU,JUMBO_MTU,HWSTATS,MEXTPG>
            ether 00:25:90:3:a1:ff
            inet 94.126.204.143 netmask Oxfffffffe broadcast 94.126.204.143
            inet6 fe80::225:90ff:fee3:a1ff%igb1 prefixlen 64 scopeid 0x2
            media: Ethernet autoselect (1000baseT <full-duplex>)
            status: active
            nd6 options=23<PERFORMNUD,ACCEPT_RTADV,AUTO_LINKLOCAL>
        ```

        In the example above, the `igb0` and `igb1` network interfaces have the descriptions `LAN` and `WAN`, respectively, and IP addresses assigned. In which case you can proceed to the next step.

        {% cut "**What to do if the output features no `LAN` and `WAN` interfaces with addresses assigned.**" %}

        1. Create and open an additional configuration file named `loader.conf.local`:

            ```bash
            ee /boot/loader.conf.local
            ```
        1. Add the following line to the new configuration file:

            ```text
            mlx4en_load="YES"
            ```
        1. Save the changes and close the file. To do this, press the **Esc + Enter** key combination and type `a` in the window that opens.
        1. Reboot the system:

            ```bash
            reboot
            ```
        1. Wait for the system to reboot, authenticate, and go to the OS terminal.
        1. Re-run the `ifconfig` command to make sure the required network interfaces are now available in your system. The `Mellanox` interfaces will have the following IDs: `mlxen0` and `mlxen1`.

        {% endcut %}

    1. Exit the OS terminal:

        ```bash
        exit
        ```
1. Configure the server LAN interface:

    1. Type `2` (`Set interface IP address` option) and press **Enter**:

        ```text
        1 - LAN (igb0 - static, track6)
        2 - WAN (igb1 - dhcp, dhep6)
        ```
    1. Type the LAN interface number and press **Enter**.
    1. `Configure IPv4 address LAN interface via DHCP? [y/N]`:

        Enter `n` to set a static IPv4 address for the interface.
    1. `Enter the new LAN IPv4 address. Press <ENTER> for none`:

        {% list tabs group=host_type %}

        - Master {#master}

          Enter the address: `192.168.1.252`.

        - Backup {#backup}

          Enter the address: `192.168.1.253`.

        {% endlist %}

    1. `Enter the new LAN IPv4 subnet bit count (1 to 32)`:

        Enter the subnet [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) prefix, e.g., `24`.
    1. `For a WAN, enter the new LAN IPv4 upstream gateway address. For a LAN, press <ENTER> for none`:

        Press **Enter** not to set the gateway address.
    1. `Configure IPv6 address LAN interface via WAN tracking? [Y/n]`:

        Enter `n` not to configure an IPv6 address via the Track Interface function.
    1. `Configure IPv6 address LAN interface via DHCP6? [y/N]`:

        Enter `n` not to configure getting an IPv6 address via DHCP6.
    1. `Enter the new LAN IPv6 address. Press <ENTER> for none`:

        Press **Enter** not to set the IPv6 address.
    1. `Do you want to enable the DHCP server on LAN? [y/N]`:

        Enter `n` not to configure the DHCP server. You will configure the DHCP server later via the web interface.
    1. `Do you want to change the web GUI protocol from HTTPS to HTTP? [y/N]`:

        Enter `y` to use HTTP to access the server configuration web interface.
    1. `Restore web GUI access defaults? [y/N]`:

        Enter `y` to use default settings to access the server configuration web interface.

    The OPNsense server settings will be updated; you can configure the OPNsense servers and cluster further via the web interface at the specified addresses:

    {% list tabs group=host_type %}

    - Master {#master}

      ```text
      You can now access the web GUI by opening the following URL in your web browser:

      http://192.168.1.252
      ```

    - Backup {#backup}

      ```text
      You can now access the web GUI by opening the following URL in your web browser:

      http://192.168.1.253
      ```

    {% endlist %}

    {% cut "Additional settings for connection to the web interface via VPN." %}

    1. Type in `8` (`Shell` option) and press **Enter** to open the OS terminal.
    1. Configure the static route to the VPN segment of the network:

        {% list tabs group=host_type %}

        - Master {#master}

          ```bash
          route add <VPN_segment_CIDR> 192.168.1.252
          ```

        - Backup {#backup}

          ```bash
          route add <VPN_segment_CIDR> 192.168.1.253
          ```

        {% endlist %}

        Where `<VPN_segment_CIDR>` is the CIDR of a subnet in the VPN segment, e.g., `172.28.1.0/24`.
    1. Make sure the route has been added:

        ```bash
        netstat -rn4
        ```

        The command output should contain a routing entry in this format:

        {% list tabs group=host_type %}

        - Master {#master}

          ```text
          172.28.2.0/24  192.168.1.252. UGS. mlxen1
          ```

        - Backup {#backup}

          ```text
          172.28.2.0/24  192.168.1.253. UGS. mlxen1
          ```

        {% endlist %}

    {% endcut %}

This concludes the OPNsense server pre-configuration procedures. To further configure the servers and cluster, access the web interface.

### Set up an OPNsense server cluster {#opnsense-cluster-config}

To set up an OPNsense server cluster, you need an installation server (_jump server_) with a graphical user interface and access to the private subnet the cluster hosts are connected to. 

To make the configuration process easier for you, in this guide, the role of this installation server will be played by a `jump-server` server leased earlier and booted into recovery and diagnostics mode from the [Rescue CD](../../baremetal/operations/servers/rescue-boot.md).

{% include [kvm-console-actions-notice](../_tutorials_includes/opnsense-failover-cluster/kvm-console-actions-notice.md) %}

1. [Start](../../baremetal/operations/servers/rescue-boot.md#boot-up) `jump-server` from the Rescue CD by selecting the default boot option, `Boot SystemRescue using default options`, from the SystemRescue main menu.

    Running SystemRescue will launch the SystemRescue OS terminal in the KVM console.

1. To start the SystemRescue GUI, run the `startx` command in the SystemRescue OS terminal.
1. As the `opnsense-private-subnet-m4` private subnet has no DHCP server yet, configure the network interface manually:

    1. In the bottom-right corner of the SystemRescue GUI, right-click the network icon and select `Edit Connections...`.
    1. In the window that opens, under **Ethernet**, select `Wired connection 1` and click the gear icon.
    1. In the settings window that opens, go to the **IPv4 Settings** tab and select `Manual` in the **Method** field.
    1. Under **Addresses**, click **Add**. In the **Address** field, enter `192.168.1.20`; in the **Netmask** field, `24`.
    1. Click **Save**.
1. Make sure that network access to the OPNsense servers is now available. To do this, click the terminal icon in the bottom-left corner of the screen; in the window that opens, run this command:

    ```bash
    ping 192.168.1.252 -c3
    ```

    Result:

    ```bash
    PING 192.168.1.252 (192.168.1.252) 56(84) bytes of data.
    64 bytes from 192.168.1.252: icmp_seq=1 ttl=64 time=0.110 ms
    64 bytes from 192.168.1.252: icmp_seq=2 ttl=64 time=0.127 ms
    64 bytes from 192.168.1.252: icmp_seq=3 ttl=64 time=0.115 ms

    --- 192.168.1.252 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2024ms
    tt min/avg/max/mdev = 0.110/0.117/0.127/0.007 ms
    ```

    Network connectivity with the OPNsense server has now been established.

    {% note tip %}

    If the `ping` command does not return packets from the server, try disabling the `Wired connection 1` network interface and configuring the `Wired connection 2` interface instead. 

    {% endnote %}

1. In the bottom-right corner, click the **Firefox** icon to open the web browser.
1. Configure both your OPNsense servers in the browser window:

    1. In the browser address bar, enter the server address:

        {% list tabs group=host_type %}

        - Master {#master}

          `http://192.168.1.252`

        - Backup {#backup}

          `http://192.168.1.253`

        {% endlist %}

    1. On the authentication page, enter `root` for username and use the password you set when installing the server. If you had not set a password for the `root` user, the default one is `opnsense`.
    1. Specify the high availability cluster settings:

        1. In the main menu, go to the high availability cluster settings: `System` → `High Availability` → `Settings`.
        1. In the **Synchronize all states via** field, select the `LAN` interface.
        1. In the **Sync compatibility** field, select `OPNsense 24.7 or above`.
        1. In the **Synchronize Peer IP** and **Synchronize Config** fields:

            {% list tabs group=host_type %}

            - Master {#master}

              Specify the IP address for your Backup server: `192.168.1.253`.

            - Backup {#backup}

              Specify the IP address for your Master server: `192.168.1.252`.

            {% endlist %}

        1. In the **Remote System Username** field, enter `root` for username.

            {% note info %}

            For synchronization purposes, you can create additional users on OPNsense servers in the `System` → `Access` section of the main menu.

            {% endnote %}

        1. In the **Remote System Password** field, enter the password to the account you specified above.
        1. In the **Services** field, select the services for synchronization. Click `Select All` to select all services, which is a good option to demonstrate what the solution can do.
        1. Click **Apply** to save and apply the changes.
    1. Specify the CARP virtual IP settings:

        1. In the main menu, go to the virtual IP address settings: `Interfaces` → `Virtual IPs` → `Settings`.
        1. Click ![square-plus](../../_assets/console-icons/square-plus.svg) to add a new virtual IP address and do the following in the window that opens:

            * In the **Mode** field, select `CARP`.
            * In the **Interface** field, select `LAN`.
            * In the **Network / Address** field, specify `192.168.1.254/24`.
            * In the **Peer (ipv4)** field:

                {% list tabs group=host_type %}

                - Master {#master}

                  Specify the IP address for your Backup server: `192.168.1.253`.

                - Backup {#backup}

                  Specify the IP address for your Master server: `192.168.1.252`.

                {% endlist %}

            * In the **Password** field, set a password to protect your CARP group.
            
                Use the same password when configuring both servers.
            * In the **VHID Group** field, set the group ID, e.g., `101`.

                Use the same group ID when configuring both servers.
            * Click **Save** to save the virtual IP address settings.
        1. Click **Apply** to apply the changes.
    1. Configure the DHCP server in the private subnet:

        1. In the main menu, go to the DHCP settings: `Services` → `ISC DHCPv4` → `LAN`.
        1. Turn on **Enable DHCP server on the LAN interface**.
        1. In the **Range** field, specify the range of private subnet IP addresses available for clients through your DHCP server, e.g., **from** `192.168.1.100` **to** `192.168.1.199`.
        1. In the **DNS servers** field, specify the domain name server addresses that will be issued to your clients, e.g., `77.88.8.8`.
        1. In the **Gateway** field, specify the IP address for the CARP interface you configured earlier: `192.168.1.254`.
        1. In the **Default lease time (seconds)** field, specify the lease period for the provided IP address, in seconds, e.g., `3600`.
        1. In the **Failover peer IP** field:

            {% list tabs group=host_type %}

            - Master {#master}

              Specify the IP address for your Backup server: `192.168.1.253`.

            - Backup {#backup}

              Specify the IP address for your Master server: `192.168.1.252`.

            {% endlist %}

        1. Click **Save** to save the DHCP server settings.
1. On the `Master` server, synchronize the cluster host settings:

    {% note info %}

    With OPNsense in cluster mode, firewall settings should first be changed on the `Master` host. The `Backup` host will get the updated parameters through change synchronization.

    {% endnote %}

    1. In your web browser address bar, enter the server address: `http://192.168.1.252`.
    1. In the main menu, go to the high availability cluster settings: `System` → `High Availability` → `Status`.
    1. Scroll down the list of services and click ![arrow-rotate-right](../../_assets/console-icons/arrow-rotate-right.svg) under **Synchronize and reconfigure all** (`Restart all services`).

    {% note warning %}

    Change synchronization also restarts the services.

    {% endnote %}

1. Check the CARP group status on both hosts:

    {% list tabs group=host_type %}

    - Master {#master}

      1. In your web browser address bar, enter the Master server address: `http://192.168.1.252`.
      1. In the main menu, go to the virtual IP address settings: `Interfaces` → `Virtual IPs` → `Status`.
      1. On the **Addresses** tab, view the **Status** column to make sure the server got the `Master` role.

          {% include [carp-restart-notice](../_tutorials_includes/opnsense-failover-cluster/carp-restart-notice.md) %}

      1. Navigate to the **pfSync nodes** tab to make sure there are two hosts in the list.

    - Backup {#backup}

      1. In your web browser address bar, enter the Backup server address: `http://192.168.1.253`.
      1. In the main menu, go to the virtual IP address settings: `Interfaces` → `Virtual IPs` → `Status`.
      1. On the **Addresses** tab, view the **Status** column to make sure the server got the `Backup` role.

          {% include [carp-restart-notice](../_tutorials_includes/opnsense-failover-cluster/carp-restart-notice.md) %}

      1. Navigate to the **pfSync nodes** tab to make sure there are two hosts in the list.

    {% endlist %}

This concludes the bulk of the high availability cluster configuration procedures.

Further configuration may involve creating firewall rules. However, for the purposes of this guide, it is enough to have a basic set of rules plus automatically generated NAT rules that will allow your clients to access the internet, i.e., allow traffic to flow through the firewall between the LAN and WAN interfaces.


## Install a hypervisor and create a virtual machine {#setup-esxi}

### Install a hypervisor {#install-esxi}

1. [Connect](../../baremetal/operations/servers/server-kvm.md) to the `vmware-esxi` server's KVM console.

    {% include [kvm-console-actions-notice](../_tutorials_includes/opnsense-failover-cluster/kvm-console-actions-notice.md) %}

1. In the KVM console window, select **Media** → **Virtual Media Wizard...** in the top menu or click the CD icon. In the window that opens:

      1. In the **CD/DVD Media1** section, click **Browse** and select the VMware ESXi image you saved earlier in the `user-iso` directory.
      1. Click **Connect CD/DVD**.
      1. Check the **Status** section for the **Virtual CD 1** device to make sure the **Connected To** field now gives the path to the image you selected, and click **Close**.
1. To boot the server up from the selected image, click **Reboot to cdrom** in the top-right corner of the KVM console.
1. Wait for the server to boot up and for the ESXi installer's interactive shell to initialize, start the installation process, and accept the terms and conditions of the license agreement (EULA).
1. Select the server disk to install the hypervisor on and the preferred keyboard layout.
1. Set the `root` user password for access to the hypervisor settings.
1. To start the ESXi installation, confirm your agreement to modify the partition table.
1. Wait for the installation to complete and press **Enter** to restart your server.
1. In the KVM console window, select **Media** → **Virtual Media Wizard...** in the top menu or click the CD icon. In the window that opens:

      1. Under **CD/DVD Media1**, click **Disconnect**. Check the **Status** section for the **Virtual CD 1** device to make sure the **Connected To** field value has changed to `Not connected`.
      1. Click **Close**.
1. Wait for the hypervisor to start and configure the network settings as follows:

    1. To go to settings, press **F2** and enter the `root` user password you set during the installation.

        If no password was set during the installation, by default you log in to the `root` user account without any password.
    1. In the main settings menu, select `Configure Management Network`.
    1. In the menu that opens, select `IPv4 Configuration`.
    1. Use the **space** key to select `Set static IPv4 address and network configuration` and specify the following:

        * **IPv4 Address**: Any free IP address that is part of the `opnsense-private-subnet-m4` private subnet and is not in the range of addresses available for clients through the OPNsense DHCP server, e.g., `192.168.1.50`.
        * **Subnet Mask**: [Subnet mask](https://en.wikipedia.org/wiki/Subnet), `255.255.255.0`.
        * **Default Gateway**: CARP virtual IP address you created earlier in the OPNsense cluster, `192.168.1.254`.
    1. Press **Enter** to save the changes.
    1. Press **Esc** to exit the settings menu and apply your changes.
    1. In the window that opens, confirm that you want to apply the updated settings and restart the network interface.

### Create a VM {#create-vm}

To create and configure VMs, you need an installation server (_jump server_) with a graphical user interface and access to the private subnet with a hypervisor connected. 

To make the configuration process easier for you, in this guide, the role of this installation server will be played by a `jump-server` server leased earlier and booted into recovery and diagnostics mode from the [Rescue CD](../../baremetal/operations/servers/rescue-boot.md).

{% include [kvm-console-actions-notice](../_tutorials_includes/opnsense-failover-cluster/kvm-console-actions-notice.md) %}

1. [Start](../../baremetal/operations/servers/rescue-boot.md#boot-up) `jump-server` from the Rescue CD by selecting the default boot option, `Boot SystemRescue using default options`, from the SystemRescue main menu.
1. To start the SystemRescue GUI, run the `startx` command in the SystemRescue OS terminal.
1. In the bottom-right corner, click the **Firefox** icon to open the web browser.
1. Download to the server an ISO image of the OS you want installed on your VM.

    {% note info %}

    For the purposes of this guide, the VM will be running [Linux Ubuntu 24.04](https://releases.ubuntu.com/24.04/) without a GUI (`Server install image`).

    {% endnote %}

1. In the address bar, enter the hypervisor address, e.g., `https://192.168.1.50/`.
1. On the authentication page, enter `root` for username and use the password you set when installing ESXi.
1. Download the image of the OS you want installed on your VM to the hypervisor file storage:

    1. In the left-hand main menu, select **Storage**.
    1. In the window that opens, select `datastore1`.
    1. In the menu at the top, click **Datastore browser** and do the following in the window that opens:

        1. Click **Create directory** and create one named `ISO`.
        1. Select the new `ISO` directory and click **Upload**.
        1. In the window that opens, select the ISO image you downloaded earlier.

            By default, downloaded files are saved to `/Home/Downloads/`.
        1. Wait for the image to download and click **Close** in the bottom-right corner of the window.
1. Create a virtual machine:

    1. In the left-hand main menu, select **Virtual Machines** and click **Create / Register VM**.
    1. In the **Select creation type** window, select `Create a new virtual machine` and click **Next**.
    1. Do the following in the **Select a name and guest OS** window:

        1. In the **Name** field, enter a name for the new VM, e.g., `opnsense-tester-vm`.
        1. In the **Guest OS family** field, select `Linux`.
        1. In the **Guest OS version** field, select `Ubuntu Linux (64-bit)`.
        1. Click **Next**.
    1. In the **Select storage** window, select `datastore1` and click **Next**.
    1. In the **Customize setting** window, do the following on the **Virtual Hardware** tab:

        1. In the **CPU** field, select the number of vCPUs you want to allocate to your VM, e.g., `4`.
        1. In the **Memory** field, select the amount of RAM you want to allocate to your VM, e.g., `8 GB`.
        1. In the **Hard disk 1** field, select the hard disk volume you want to allocate to your VM, e.g., `50 GB`.
        1. In the **CD/DVD Drive 1** field, select `Datastore ISO file`. In the window that opens, select the image you downloaded earlier.
        1. Leave other parameters as they are and click **Next**.
    1. In the **Ready to complete** window, check the parameters of the new VM and click **Finish** to create it.
    1. In the left-hand main menu, select **Virtual Machines**. Select the `opnsense-tester-vm` VM.
    1. In the window that opens, click ![TriangleRightFill](../../_assets/console-icons/triangle-right-fill.svg) **Power on** or the ![TriangleRightFill](../../_assets/console-icons/triangle-right-fill.svg) icon in the VM preview window.
    1. Click the VM preview window and expand it to full screen.
    1. Follow through the OS installation procedure after selecting the preferred language, keyboard layout, installation type, etc. You can leave all settings at their defaults: this will be enough to test the proposed solution within the scope of this guide.

        On the network settings screen, make sure that the VM was assigned a private IP address on the `opnsense-private-subnet-m4` subnet from the range specified in the OPNsense DHCP server settings.
        
        On the **Profile configuration** screen, set the name and password of the user who will have access to the VM.
    1. Once the installation is complete, click **Reboot Now**.

## Test the solution {#test-solution}

The solution will be tested using a VM created earlier on a server running VMware ESXi.

The successful test criteria are as follows:
* The VM gets an IP address in the local network from the DHCP server created in the OPNsense cluster.
* The VM is able to access the internet through the OPNsense firewall.

### Check whether the client got an IP address from the DHCP server {#check-dhcp-lease}

1. [Connect](../../baremetal/operations/servers/server-kvm.md) to the `opnsense-master` server's KVM console.
1. Authenticate to the OPNsense server as the `root` user with the password you set when installing the server.
1. Type in `8` (`Shell` option) and press **Enter** to open the OS terminal.
1. Run this command:

    ```bash
    tcpdump -i <interface_ID> -pvn port 67 and port 68
    ```

    Where `<interface_ID>` is the ID of the server network interface connected to the `opnsense-private-subnet-m4` private subnet, e.g., `igb0`.

    With the `tcpdump` command, you can listen to the network interface to visualize how the DHCP protocol works.

    Result:

    ```text
    10:45:50.180979 IP (tos 0x0, ttl 64, id 0, offset 0, flags [none], proto UDP (17), length 328)
        0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from 00:0c:29:7a:bf:5c, length 300, xid 0x6094a655, Flags [none]
        Client-Ethernet-Address 00:0c:29:7a:bf:5c
        Vendor-rfc1048 Extensions
            Magic Cookie 0x63825363
            DHCP-Message (53), length 1: Discover
            MSZ (57), length 2: 576
            Parameter-Request (55), length 7:
            Subnet-Mask (1), Default-Gateway (3), Domain-Name-Server (6), Hostname (12)
            Domain-Name (15), BR (28), NTP (42)
            Hostname (12), length 8: "alp-vm-1"
            Vendor-Class (60), length 12: "udhcp 1.37.0"
            Client-ID (61), length 7: ether 00:0c:29:7a:bf:5c
    10:45:51.229540 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none], proto UDP (17), length 328)
        192.168.1.252.67 > 192.168.1.153.68: BOOTP/DHCP, Reply, length 300, xid 0x6094a655, Flags [none]
        Your-IP 192.168.1.153
        Client-Ethernet-Address 00:0c:29:7a:bf:5c
        Vendor-rfc1048 Extensions
            Magic Cookie 0x63825363
            DHCP-Message (53), length 1: Offer
            Server-ID (54), length 4: 192.168.1.252
            Lease-Time (51), length 4: 600
            Subnet-Mask (1), length 4: 255.255.255.0
            Default-Gateway (3), length 4: 192.168.1.254
            Domain-Name-Server (6), length 4: 77.88.8.8
            Domain-Name (15), length 11: "localdomain"
    10:45:51.280876 IP (tos 0x0, ttl 64, id 0, offset 0, flags [none], proto UDP (17), length 330)
        0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from 00:0c:29:7a:bf:5c, length 302, xid 0x6094a655, secs 1, Flags [none]
        Client-Ethernet-Address 00:0c:29:7a:bf:5c
        Vendor-rfc1048 Extensions
            Magic Cookie 0x63825363
            DHCP-Message (53), length 1: Request
            Requested-IP (50), length 4: 192.168.1.153
            Server-ID (54), length 4: 192.168.1.252
            MSZ (57), length 2: 576
            Parameter-Request (55), length 7:
            Subnet-Mask (1), Default-Gateway (3), Domain-Name-Server (6), Hostname (12)
            Domain-Name (15), BR (28), NTP (42)
            Hostname (12), length 8: "alp-vm-1"
            Vendor-Class (60), length 12: "udhcp 1.37.0"
            Client-ID (61), length 7: ether 00:0c:29:7a:bf:5c
    10:45:51.281467 IP (tos 0x10, ttl 128, id 0, offset 0, flags [none], proto UDP (17), length 328)
        192.168.1.252.67 > 192.168.1.153.68: BOOTP/DHCP, Reply, length 300, xid 0x6094a655, secs 1, Flags [none]
        Your-IP 192.168.1.153
        Client-Ethernet-Address 00:0c:29:7a:bf:5c
        Vendor-rfc1048 Extensions
            Magic Cookie 0x63825363
            DHCP-Message (53), length 1: ACK
            Server-ID (54), length 4: 192.168.1.252
            Lease-Time (51), length 4: 600
            Subnet-Mask (1), length 4: 255.255.255.0
            Default-Gateway (3), length 4: 192.168.1.254
            Domain-Name-Server (6), length 4: 77.88.8.8
            Domain-Name (15), length 11: "localdomain"
    ```

    **Analyzing the result:**

    The result comprises these two main steps:

    {% list tabs %}

    - Client's requests for an IP address

      ```text
      0.0.0.0.68 > 255.255.255.255.67:     BOOTP/DHCP, Request
      DHCP-Message (53), length 1:         Discover
      Client-ID (61), length 7:            00:0c:29:7a:bf:5c
      ```

    - DHCP server's offer of an IP address

      ```text
      192.168.1.252.67 > 192.168.1.153.68:   BOOTP/DHCP, Reply
      Client-Ethernet-Address:               00:0c:29:7a:bf:5c
      DHCP-Message (53), length 1:           Offer
      Server-ID (54), length 4:              192.168.1.252
      Your-IP:                               192.168.1.153
      Subnet-Mask (1), length 4:             255.255.255.0
      Default-Gateway (3), length 4:         192.168.1.254
      Domain-Name-Server (6), length 4:      77.88.8.8
      ```

    {% endlist %}

### Check that your VM has internet access {#check-internet}

1. [Start](../../baremetal/operations/servers/rescue-boot.md#boot-up) `jump-server` from the Rescue CD by selecting the default boot option, `Boot SystemRescue using default options`, from the SystemRescue main menu.
1. Start the SystemRescue GUI by running the `startx` command.
1. In the bottom-right corner of the GUI screen, click the **Firefox** icon to open the web browser.
1. In the address bar, enter the hypervisor address, e.g., `https://192.168.1.50/`.
1. On the authentication page, enter `root` for username and use the password you set when installing ESXi.
1. In the left-hand main menu, select **Virtual Machines**. Select the `opnsense-tester-vm` VM.
1. In the window that opens, click ![TriangleRightFill](../../_assets/console-icons/triangle-right-fill.svg) in the VM preview box and expand it to full screen. Do the following in the VM terminal window:

    1. To authenticate, enter the username and password you set when creating the VM.
    1. Make sure the VM has an IP address assigned:

        ```bash
        ip a
        ```

        Result:

        ```text
        1: 1o: «LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
            link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
            inet 127.0.0.1/8 scope host lo
                valid_lft forever preferred_lft forever
            inet6 ::1/128 scope host noprefixroute
                valid_lft forever preferred_lft forever
        2: ens160: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fa_codel state UP group default glen 1000
            link/ether 00:0c:29:86:04:10 brd ffiff:ff:ff:ff:ff
            altname enp3s0
            inet 192.168.1.153/24 metric 100 brd 192.168.1.255 scope global dynamic ens160
                valid_lft 459sec preferred_lft 459sec
            inet6 fe80::20c:29ff:fe86:d410/64 scope link
                valid_lft forever preferred_lft forever
        ```

        The `ens160` network interface got from the DHCP server the IP address `192.168.1.153`.
    1. Install the `net-tools` and `traceroute` packages:

        ```bash
        sudo apt install net-tools traceroute
        ```
    1. Check the routing table:

        ```bash
        netstat -rn
        ```

        Result:

        ```text
        Kernel IP routing table
        Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
        0.0.0.0         192.168.1.254   0.0.0.0         UG        0 0          0 ens160
        77.88.8.8       192.168.1.254   255.255.255.255 UGH       0 0          0 ens160
        192.168.1.0     0.0.0.0         255.255.255.0   U         0 0          0 ens160
        192.168.1.254   0.0.0.0         255.255.255.255 UH        0 0          0 ens160
        ```
    1. Ping any external address, e.g., `1.1.1.1`:

        ```bash
        ping -c 3 1.1.1.1
        ```

        Result:

        ```text
        PING 1.1.1.1 (1.1.1.1): 56 data bytes
        64 bytes from 1.1.1.1: seq=0 ttl=55 time=2.252 ms
        64 bytes from 1.1.1.1: seq=1 ttl=55 time=2.354 ms
        64 bytes from 1.1.1.1: seq=2 ttl=55 time=2.363 ms

        --- 1.1.1.1 ping statistics ---
        3 packets transmitted, 3 packets received, 0% packet loss
        round-trip min/avg/max = 2.252/2.323/2.363 ms
        ```
    1. Check the route through to any external address, e.g., `1.1.1.1`:

        ```bash
        traceroute -n 1.1.1.1
        ```

        Result:

        ```bash
        traceroute to 1.1.1.1 (1.1.1.1), 30 hops max, 60 byte packets
         1  192.168.1.253  0.223 ms  0.176 ms  0.147 ms
         2  94.126.204.142  2.914 ms  3.193 ms  *
         3  *  *  *
         4  *  *  *
         5  *  *  *
         6  *  *  *
         7  *  *  *
         8  195.208.209.7  2.697 ms  *  *
         9  *  62.115.139.123  12.950 ms  *
        10  *  *  *
        11  *  *  *
        12  *  *  *
        13  *  *  *
        14  1.1.1.1  1.725 ms  *  *
        ```

The test results show that your VM has access to the internet.

## How to delete the resources you created {#clear-out}

1. [Delete](../../storage/operations/objects/delete.md) the objects you created in the bucket, then [delete](../../storage/operations/buckets/delete.md) the bucket itself.
1. You cannot delete {{ baremetal-name }} servers. Instead, [cancel](../../baremetal/operations/servers/server-lease-cancel.md) the renewal of their lease.