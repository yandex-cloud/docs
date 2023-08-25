---
title: "OpenVPN. Creating a VPN connection"
keywords:
  - openvpn
  - openvpn setup
  - open vpn
  - vpn server setup
  - vpn connection
  - vpn connection
---

# Connecting to a cloud network using OpenVPN

With TCP or UDP port tunnels and asymmetric encryption, you can create virtual networks. VPN can be used, for example, to:

* Connect geographically remote networks.
* Connect freelancers to the office network.
* Set up an encrypted connection over an open Wi-Fi network.

[OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) is compatible with the [open-source version](https://github.com/OpenVPN) of OpenVPN and built on its basis. It provides clients for Windows, Mac, Android, and iOS and is used to manage connections using a web interface.

An example of auto-connect and login-and-password configurations is shown below. To create a virtual network:

1. [Prepare your cloud](#before-you-begin).
1. [Create subnets and a test VM](#create-environment).
1. [Start the VPN server](#create-vpn-server).
1. [Configure network traffic permissions](#network-settings).
1. [Get the administrator password](#get-admin-password).
1. [Activate license](#get-license).
1. [Create an OpenVPN user](#configure-openvpn).
1. [Connect to the VPN](#test-vpn).

If you no longer need the VPN server, [delete the VM](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of infrastructure support for OpenVPN includes:

* Fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or a static public IP (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for the OpenVPN Access Server license (when using more than two connections).


## Create subnets and a test VM {#create-environment}

To connect cloud resources to the internet, make sure you have [networks](../../vpc/operations/network-create.md) and [subnets](../../vpc/operations/subnet-create.md).

Create a [VM](../../compute/operations/vm-create/create-linux-vm.md) for the test without a public IP and connect it to a subnet.

## Start the VPN server {#create-vpn-server}

Create a VM to be the gateway for VPN connections:

1. On the folder page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** in the top-right corner.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. Enter `vpn-server` as your VM name and add a description.
1. Select the [availability zone](../../overview/concepts/geo-scope.md) where the test VM is already located.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select the [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) image.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, enter `10 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your disk size.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

     * Select the Intel Ice Lake [platform](../../compute/concepts/vm-platforms.md).
     * Specify the number of vCPUs and the amount of RAM:

       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

   * Select the required network and subnet and assign a public IP address to the VM either by selecting it from the list or automatically.

      Only use static public IP addresses [from the list](../../vpc/operations/get-static-ip) or [make](../../vpc/operations/set-static-ip) the IP address static. Dynamic IP addresses may change after the VM reboots and the connections will no longer work.

   * If a list of **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** is available, select a [security group](../../vpc/concepts/security-groups.md). If you leave this field empty, the [default security group](../../vpc/concepts/security-groups.md#default-security-group) will be assigned.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:

   * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the SSH username, for example, `yc-user`.
   * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.

     You will need to create a key pair for the SSH connection yourself, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
1. A window will open informing you of the pricing type: BYOL (Bring Your Own License). Click **{{ ui-key.yacloud.common.create }}**.

{% include [openvpn-network-settings](../_tutorials_includes/openvpn-network-settings.md) %}

{% include [openvpn-get-admin-password](../_tutorials_includes/openvpn-get-admin-password.md) %}

## Activate license {#get-license}

{% note info %}

If you have up to two VPN connections, use the product for free (no activation required).

{% endnote %}

To activate the license:

1. Create an account on [openvpn.net](https://myaccount.openvpn.com/signup).
1. Enter the confirmation code received by email.
1. In the **Where would you like to Go?** window, select the **"Remember my choice"** option and select the **Access serve** product.
1. In the **Tell us more** window, select the purpose: **Business use** or **Personal Use**.
1. On the **Subscriptions** tab, select the maximum number of connections in the **How many VPN connections do you need?** field. and click **Create**.
1. Your subscription will be displayed on the screen: **Subscription 1**.
1. To copy the activation key, click **Copy Key** under **Subscription Key**.

Wait until the VM status changes to `RUNNING` and enter the activation key in the admin panel at `https://<VM public IP address>/admin/`.

## Create an OpenVPN user {#configure-openvpn}

OpenVPN Access Server provides two web interfaces:

1. Client Web UI at `https://<VM_public_IP_address>/`. This interface is used by regular users to download client applications and configuration profiles.
1. Admin Web UI at `https://<VM_public_IP_address>/admin/`. This interface is used to configure the server.

{% note info %}

By default, the server has a self-signed certificate installed. If you need to replace this certificate, follow the steps described [here](https://openvpn.net/vpn-server-resources/installing-a-valid-ssl-web-certificate-in-access-server/).

{% endnote %}

To create a user, log in to the admin panel:

1. In the browser, open a URL, such as `https://<VM_public_IP_address>/admin/`.
1. Enter the `openvpn` username and password (to learn how to get the admin password, see [this section](#get-admin-password)).
1. Click **Agree**. This will open the home screen of the OpenVPN admin panel.
1. Go to the **User management** tab and select **User permissions**.
1. In the user list, enter the name of a new user in the **New Username** field, e.g., `test-user`.
1. Click the pencil icon in the **More Settings** column and set the new user's password in the **Password** field.
1. Click **Save settings**.
1. Click **Update running server**.

## Connect to the VPN {#test-vpn}

In the admin panel, you can download [OpenVPN Connect](https://openvpn.net/vpn-client/) for Windows, Linux, MacOS, Android, iOS. You can also use [OpenSource clients](https://openvpn.net/source-code/) for connection.

To check that a connection is established and working properly, connect to the VPN and run the `ping` command for the test VM internal address:

{% list tabs %}

- Linux

   1. Install the `openvpn` using package manager:

      ```
      sudo apt update && sudo apt install openvpn
      ```
   1. Allow auto-connect for the `test-user` user:

      * Log in to the admin panel at `https://<VM_public_IP_address>/admin/`.
      * Open the **User management** → **User permissions** tab.
      * Enable the **Allow Auto-login** option in the user line.

   1. Configure routing:

      * Log in to the admin panel at `https://<VM_public_IP_address>/admin/`.
      * Open the **Configuration** → **VPN Settings** tab.
      * Under **Routing**, disable the **Should client Internet traffic be routed through the VPN?** option.

   1. Download a configuration profile:

      * In the browser, open the user panel at `https://<VM_public_IP_address>/`.
      * Log in using the `test-user` username and password.
      * In the **Available Connection Profiles** section, click **Yourself (autologin profile)** and upload the `profile-1.ovpn` file.
      * You can also download a configuration file in the admin panel at `https://<<VM_public_IP_address>/admin/`.

   1. Upload the configuration file to a Linux machine:

      ```
      scp profile-1.ovpn user@<IP address>:~
      ```

   1. Move the configuration file to the `/etc/openvpn` folder:
      ```
      sudo mv /home/user/profile-1.ovpn /etc/openvpn
      ```

   1. Change the file extension from `ovpn` to `conf`:
      ```
      sudo mv /etc/openvpn/profile-1.ovpn /etc/openvpn/profile-1.conf
      ```

   1. Close access to the file:
      ```
      sudo chown root:root /etc/openvpn/profile-1.conf
      sudo chmod 600 /etc/openvpn/profile-1.conf
      ```

   1. The VPN connection will turn on automatically after restarting. To start the connection manually, run the command:
      ```
      sudo openvpn --config /etc/openvpn/profile-1.conf
      ```
      Result:
      ```
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

   1. Test the network using the command `ping`:
      ```
      sudo ping <internal_IP_address_of_the_test_VM>
      ```
      If the command is executed, the VM can be accessed via OpenVPN.

   1. To terminate a manually established connection, press **Ctrl** + **C**.

- Windows

   1. Download the installation distribution:

      * In the browser, open the user panel at `https://<VM_public_IP_address>/`.
      * Log in using the `test-user` username and password.
      * Download OpenVPN Connect version 2 or 3 by clicking the Windows icon.

   1. Install and run OpenVPN Connect.

   1. A VPN connection will turn on automatically if auto-login is enabled in the user profile.

   1. A new configuration profile can be imported into the application. To do this, specify `https://<VM_public_IP_address>/` or select a profile file.

   1. Open the terminal and run the `ping <internal_IP_address_of_the_test_VM>` command. If the command is executed, the VM can be accessed via OpenVPN.

- MacOS

   1. Download the installation distribution:

      * In the browser, open the user panel at `https://<VM_public_IP_address>/`.
      * Log in using the `test-user` username and password.
      * Download OpenVPN Connect version 2 or 3 by clicking the Apple icon.

   1. Install and run OpenVPN Connect.

   1. A VPN connection will turn on automatically if auto-login is enabled in the user profile.

   1. A new configuration profile can be imported into the application. To do this, specify `https://<VM_public_IP_address>/` or select a profile file.

   1. Open the terminal and run the `ping <internal_IP_address_of_the_test_VM>` command. If the command is executed, the VM can be accessed via OpenVPN.

{% endlist %}

## How to delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid being charged for them:

* [Delete](../../compute/operations/vm-control/vm-delete.md) the `vpn-server` VM and the test VM.
* If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).

#### See also {#see-also}

* [OpenVPN Project Wiki](https://community.openvpn.net/openvpn/wiki)
* [{#T}](../../certificate-manager/operations/managed/cert-get-content.md)
* [Connecting to Access Server](https://openvpn.net/vpn-server-resources/connecting-to-access-server-with-linux/#openvpn-open-source-openvpn-cli-program)


