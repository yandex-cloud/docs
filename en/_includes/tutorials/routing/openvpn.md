---
title: OpenVPN. Creating a VPN connection
keywords:
  - openvpn
  - open vpn
  - vpn connection
---

# Creating a VPN connection using OpenVPN

This scenario describes how to configure an OpenVPN instance to access Yandex.Cloud VMs over an encrypted connection. It considers the option to configure an OpenVPN gateway with username and password-based access.

To set up a VPN tunnel:

1. [Before you start](#before-you-begin).
1. [Create subnets and a test VM](#create-environment).
1. [Create an OpenVPN instance](#create-openvpn-instance).
1. [Set the administrator password](#set-up-admin).
1. [Create an OpenVPN user](#configure-openvpn).
1. [Connect to the VPN](#test-vpn).

If you no longer need the OpenVPN instance, [delete it](#clear-out).

## Before you start {#before-you-begin}

Before deploying the server, you need to sign up for Yandex.Cloud and create a billing account:

{% include [prepare-register-billing](../_common/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The cost of infrastructure support for OpenVPN includes:

* A fee for continuously running VMs (see [pricing{{ compute-full-name }}](../../../compute/pricing.md)).
* A fee for using a dynamic external IP address (see [pricing {{ vpc-full-name }}](../../../vpc/pricing.md)).

## Create subnets and a test VM {#create-environment}

To connect cloud resources to the internet, make sure you have [networks](../../../vpc/operations/network-create.md) and [subnets](../../../vpc/operations/subnet-create.md).

Create a test [VM](../../../compute/operations/vm-create/create-linux-vm.md) without a public IP and connect it to the subnet.

## Create an OpenVPN instance {#create-openvpn-instance}

Create a VM in Yandex.Cloud to serve as a gateway for a VPN tunnel.

1. Open your folder and click **Create resource**. Select **Virtual machine**.

1. Enter a name for the VM, for example, `openvpn-instance`.

1. Select the subnet availability zone to connect the OpenVPN instance to and where the test VM is already located.

1. Under **Images from {{ marketplace-name }}**, click **Select** and choose the [OpenVPN](https://cloud.yandex.com/en-ru/marketplace/products/f2e1aee242rtv6lsrfea) image.

1. In the **Network settings** section, choose the required network and subnet and assign a public IP to the VM either by selecting it from the list or automatically.

   Only use static public IP addresses [from the list](https://cloud.yandex.com/docs/vpc/operations/get-static-ip) or [make](https://cloud.yandex.com/docs/vpc/operations/set-static-ip) the IP address static. Dynamic IP addresses may change after the VM reboots and the connections will no longer work.

1. In the **Access** field, enter the login and SSH key to access the VM.

1. Click **Create VM**.

## Set the administrator password {#set-up-admin}

The `openvpn` user with administrator privileges was created on the OpenVPN server in advance. To access the admin panel, set a password for this user.

1. Connect to the virtual machine over SSH:

   ```
   $ ssh <VM public IP>
   ```

1. Run the command:

   ```
   $ sudo passwd openvpn
   Enter new UNIX password:
   ```

   Enter a new password.

   You can then log in to the OpenVPN admin panel.

## Create an OpenVPN user {#configure-openvpn}

To establish an OpenVPN connection, enter the username and password of the user on the client machine. Create a new user:

1. In the browser, open a URL like `https://<VM public IP address>:943/admin/`.
1. Specify the `openvpn` username and the password created in the previous step.
1. Click **Agree**. This opens the main screen of the OpenVPN admin panel.
1. Go to the **User management** tab and select **User permissions**.
1. In the list of users, enter the name of the new user in the **New Username** field, like `test-user`.
1. Click the pencil icon in the **More Settings** column and set the new user's password in the **Password** field.
1. Click **Save settings**.
1. Click **Update running server**.

You can then connect to the VPN using [OpenVPN Connect](https://openvpn.net/client-connect-vpn-for-windows/).

## Connect to the VPN {#test-vpn}

To check that a connection is established and working properly, connect to the VPN and run the `ping` command for the test VM internal address:

1. Start the OpenVPN Connect Client.
1. Create a new connection. Type the VM IP address, enter `test-user` as the user, and enter the user's password.
1. Enable the created connection.
1. Open the terminal and run the command `ping <internal IP address of the test VM>`. If the command is executed, the VM can be accessed via OpenVPN.

## Delete the created resources {#clear-out}

If you no longer need the OpenVPN instance, [delete](../../../compute/operations/vm-control/vm-delete.md) the `openvpn-instance` VM and the test VM.

If you reserved a public static IP address, [delete it](../../../vpc/operations/address-delete.md).

