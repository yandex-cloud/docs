
# Connecting to a cloud network using OpenVPN

With TCP or UDP port tunnels and asymmetric encryption, you can create virtual networks. For example, you can use VPN to do the following:

* Connect networks residing in different locations.
* Provide contractors with an access to an in-house network.
* Set up an encrypted connection over Wi-Fi.

[OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) is compatible with the OpenVPN [open-source version](https://github.com/OpenVPN) and built on it. It provides clients for Windows, Mac, Android, and iOS. You can also use its web UI to manage connections.

Learn how to configure auto-connection and a connection using a username and password below. To create a virtual network:

1. [Get your cloud ready](#before-you-begin).
1. [Create subnets and a test VM](#create-environment).
1. [Run a VPN server](#create-vpn-server).
1. [Configure network traffic permissions](#network-settings).
1. [Get the administrator password](#get-admin-password).
1. [Activate your license](#get-license).
1. [Create an OpenVPN user](#configure-openvpn).
1. [Connect to the VPN](#test-vpn).

If you no longer need the VPN server, [delete the VM](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of the OpenVPN infrastructure support includes:

* Fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for a dynamic or static public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for the OpenVPN Access Server license (when using more than two connections).

## Create subnets and a test VM {#create-environment}

To connect cloud resources to the internet, make sure you have [networks](../../vpc/operations/network-create.md) and [subnets](../../vpc/operations/subnet-create.md).

Create a test [VM](../../compute/operations/vm-create/create-linux-vm.md) without a public IP address and connect it to the subnet.

## Run a VPN server {#create-vpn-server}

Create a VM to run the VPN server:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard of the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, enter `OpenVPN Access Server` in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field and select a public [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**. Select the [availability zone](../../overview/concepts/geo-scope.md) where the test VM is already located.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify the boot [disk](../../compute/concepts/disk.md#disks_types) size: `20 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to connect your VM to. If the required [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) is not there, [create it](../../vpc/operations/subnet-create.md).
      * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

          Either use static public IP addresses [from the list](../../vpc/operations/get-static-ip) or [convert](../../vpc/operations/set-static-ip) your VM IP address to static. Dynamic IP addresses may change after the VM reboots and the connections will no longer work.

      * If a list of **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** is available, select a [security group](../../vpc/concepts/security-groups.md). If you leave this field empty, the system will assign the [default security group](../../vpc/concepts/security-groups.md#default-security-group) to the network.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username. Do not use `root` or other reserved usernames. To perform operations requiring superuser privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vpn-server`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. This will open a window with the licensing model: BYOL (Bring Your Own License). Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Configure network traffic permissions {#network-settings}

{% include [openvpn-network-settings](../_tutorials_includes/openvpn-network-settings.md) %}

## Get the administrator password {#get-admin-password}

{% include [openvpn-get-admin-password](../_tutorials_includes/openvpn-get-admin-password.md) %}

## Activate your license {#get-license}

{% include [openvpn-activate-license](../_tutorials_includes/openvpn-activate-license.md) %}

## Create an OpenVPN user {#configure-openvpn}

{% include [openvpn-create-user](../_tutorials_includes/openvpn-create-user.md) %}

## Connect to the VPN {#test-vpn}

In the user panel, you can download [OpenVPN Connect](https://openvpn.net/vpn-client/) for Windows, Linux, MacOS, Android, and iOS. You can also use [OpenSource clients](https://openvpn.net/source-code/) for connection.
 
To make sure the connection is established and working properly, connect to the VPN and run the `ping` command for the internal address of the test VM:

{% list tabs group=operating_system %}

- Linux {#linux}

   1. Install `openvpn` using the package manager:

      ```bash
      sudo apt update && sudo apt install openvpn
      ```

   1. Allow automatic connection for `test-user`:

      * Log in to the admin panel at `https://<VM_public_IP_address>/admin/`.
      * Open the **User management** → **User permissions** tab.
      * Enable the **Allow Auto-login** option in the user line.

   1. Configure routing:

      * Log in to the admin panel at `https://<VM_public_IP_address>/admin/`.
      * Open the **Configuration** → **VPN Settings** tab.
      * Under **Routing**, disable **Should client Internet traffic be routed through the VPN?**.

   1. Download a configuration profile:

      * In your browser, open the user panel at `https://<VM_public_IP_address>/`.
      * Sign in using the `test-user` username and password.
      * Under **Available Connection Profiles**, click **Yourself (autologin profile)** and download the `profile-1.ovpn` file.
      * You can also download a configuration file in the admin panel at `https://<<VM_public_IP_address>/admin/`.

   1. Upload the configuration file to a Linux machine:

      ```bash
      scp profile-1.ovpn user@<IP_address>:~
      ```

   1. Move the configuration file to the `/etc/openvpn` folder:

      ```bash
      sudo mv /home/user/profile-1.ovpn /etc/openvpn
      ```

   1. Change the file extension from `ovpn` to `conf`:

      ```bash
      sudo mv /etc/openvpn/profile-1.ovpn /etc/openvpn/profile-1.conf
      ```

   1. Close access to the file:
 
      ```bash
      sudo chown root:root /etc/openvpn/profile-1.conf
      sudo chmod 600 /etc/openvpn/profile-1.conf
      ```

   1. The VPN connection will turn on automatically after restarting. To establish the connection manually, run the command:

      ```bash
      sudo openvpn --config /etc/openvpn/profile-1.conf
      ```

      Result:
   
      ```text
      2022-04-05 15:35:49 DEPRECATED OPTION: --cipher set to 'AES-256-CBC' but missing in --data-ciphers (AES-256-GCM:AES-128-GCM). Future OpenVPN version will ignore --cipher for cipher negotiations. Add 'AES-256-CBC' to --data-ciphers or change --cipher 'AES-256-CBC' to --data-ciphers-fallback 'AES-256-CBC' to silence this warning.
      2022-04-05 15:35:49 OpenVPN 2.5.1 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on May 14 2021
      2022-04-05 15:35:49 library versions: OpenSSL 1.1.1k  25 Mar 2021, LZO 2.10
      2022-04-05 15:35:49 Outgoing Control Channel Encryption: Cipher 'AES-256-CTR' initialized with 256 bit key
      2022-04-05 15:35:49 Outgoing Control Channel Encryption: Using 256 bit message hash 'SHA256' for HMAC authentication
      2022-04-05 15:35:49 Incoming Control Channel Encryption: Cipher 'AES-256-CTR' initialized with 256 bit key
      2022-04-05 15:35:49 Incoming Control Channel Encryption: Using 256 bit message hash 'SHA256' for HMAC authentication
      2022-04-05 15:35:49 TCP/UDP: Preserving recently used remote address: [AF_INET]51.250.25.105:443
      2022-04-05 15:35:49 Socket Buffers: R=[131072->131072] S=[16384->16384]
      2022-04-05 15:35:49 Attempting to establish TCP connection with [AF_INET]51.250.25.105:443 [nonblock]
      ...
      ...
      2022-04-05 15:35:54 Initialization Sequence Completed
      ```

   1. Test the network using the `ping` command:

      ```bash
      sudo ping <test_VM_internal_IP_address>
      ```

      If the command is running, the VM can be accessed via VPN.

   1. To terminate a manually established connection, press **Ctrl** + **C**.

- Windows {#windows}

   1. Download the installation distribution:

      * In your browser, open the user panel at `https://<VM_public_IP_address>/`.
      * Sign in using the `test-user` username and password.
      * Download OpenVPN Connect version 2 or 3 by clicking the Windows icon.

   1. Install and run OpenVPN Connect.

   1. A VPN connection will turn on automatically if auto-login is enabled in the user profile.

   1. You can import a new configuration profile into the application by specifying `https://<VM_public_IP_address>/` or selecting a profile file.

   1. Open the terminal and run this command: `ping <internal_IP_address_of_test_VM>`. If the command is running, the VM can be accessed via VPN.

- macOS {#macos}

   1. Download the installation distribution:

      * In your browser, open the user panel at `https://<VM_public_IP_address>/`.
      * Sign in using the `test-user` username and password.
      * Download OpenVPN Connect version 2 or 3 by clicking the Apple icon.

   1. Install and run OpenVPN Connect.

   1. A VPN connection will turn on automatically if auto-login is enabled in the user profile.

   1. You can import a new configuration profile into the application by specifying `https://<<VM_public_IP_address>/` or selecting a profile file.

   1. Open the terminal and run this command: `ping <internal_IP_address_of_test_VM>`. If the command is running, the VM can be accessed via VPN.

{% endlist %}

## How to delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* [Delete](../../compute/operations/vm-control/vm-delete.md) the `vpn-server` and test VMs.
* If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).

#### See also {#see-also}

* [OpenVPN Project Wiki](https://community.openvpn.net/openvpn/wiki)
* [{#T}](../../certificate-manager/operations/managed/cert-get-content.md)
* [Connecting to Access Server](https://openvpn.net/vpn-server-resources/connecting-to-access-server-with-linux/#openvpn-open-source-openvpn-cli-program)


