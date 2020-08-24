# Creating an IPSec VPN tunnel

This scenario describes how to configure an IPSec instance to route traffic from Yandex.Cloud VMs to an IPSec VPN tunnel using the [strongSwan](https://www.strongswan.org/) daemon.

In the example, we set up a tunnel between two VPN gateways. To test the tunnel, you need to configure gateways on both sides of it. You can do this using a different network in Yandex.Cloud or your local network.

To set up a VPN tunnel:

1. [Before you start](#before-you-begin).
1. [Create and configure an IPSec instance](#create-ipsec-instance).
1. [Configure IPsec](#create-ipsec-instance).
1. [Set up static routing in the cloud network](#configure-static-route).
1. [Configure IPSec on the second gateway](#configure-another-gateway).
1. [Test the VPN tunnel](#test-vpn).

If you no longer need the IPSec instance, [delete it](#clear-out).

## Before you start {#before-you-begin}

Before deploying the server, you need to sign up for Yandex.Cloud and create a billing account:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The cost of IPSec VPN infrastructure support includes:

* A fee for continuously running VMs (see [pricing{{ compute-full-name }}](../../compute/pricing.md)).
* A fee for using a dynamic external IP address (see [pricing {{ vpc-full-name }}](../../vpc/pricing.md)).

## Create networks and subnets {#before-you-begin}

To connect cloud resources to the internet, make sure you have [networks](../../vpc/operations/network-create.md) and [subnets](../../vpc/operations/subnet-create.md).

## Create an IPSec instance {#create-ipsec-instance}

Create a VM in Yandex.Cloud to serve as a gateway for an IPSec tunnel.

1. Open your folder and click **Create resource**. Select **Virtual machine**.

1. Enter a name for the VM, for example, `ipsec-instance`.

1. Select the subnet availability zone to connect the IPSec instance to and where the test VM is already located.

1. In the **Images from {{ marketplace-name }}** section, click **Select** and choose the **IPSec instance** image.

1. In the **Network settings** section, choose the required network and subnet and assign a public IP to the VM either by selecting it from the list or automatically.

   Only use static public IP addresses [from the list](https://cloud.yandex.com/docs/vpc/operations/get-static-ip) or [make](https://cloud.yandex.com/docs/vpc/operations/set-static-ip) the IP address static. Dynamic IP addresses may change after the VM reboots and the tunnel will no longer work.

1. In the **Access** field, enter the login and SSH key to access the VM.

1. Click **Create VM**.

## Configure IPSec {#configure-ipsec}

Configure a gateway with a public IP address and subnet that will establish an IPSec connection with the remote gateway.

In the example below, the public IP address of the gateway is `130.193.32.25`. Beyond the gateway is subnet `10.128.0.0/24`. This gateway establishes an IPSec connection with a remote gateway with the IP address `1.1.1.1`, which leads to subnet `192.168.0.0/24`.

1. Connect to the virtual machine over SSH:

   ```
   $ ssh 130.193.32.25
   ```

1. Open the IPSec configuration:

   ```
   $ sudo nano /etc/ipsec.conf
   ```

1. Edit `config setup` to look like the following:

   ```
   config setup
           charondebug="all"
           uniqueids=yes
           strictcrlpolicy=no
   ```

1. Enter the following parameters for the test connection:
   * `leftid` — The public IP address of the IPSec instance.
   * `leftsubnet` — The CIDR of the subnet that the IPSec instance is connected to.
   * `right`  — Enter the public IP address of the gateway at the other end of the VPN tunnel.
   * `rightsubnet`  — Enter the CIDR of the subnet that the VPN gateway is connected to at the other end of the tunnel.
   * In the `ike` and `esp` parameters, enter the encryption algorithms that are supported on the remote gateway. For a list of supported encryption algorithms, see [IKEv1](https://wiki.strongswan.org/projects/strongswan/wiki/IKEv1CipherSuites) and [IKEv2](https://wiki.strongswan.org/projects/strongswan/wiki/IKEv2CipherSuites) on the strongSwan website.
   * For the rest of the settings, refer to the [strongSwan documentation](https://wiki.strongswan.org/projects/strongswan/wiki), being sure to take the remote gateway settings into account.

   Save your changes and close the file.

   The configuration should look like this:

   ```
   conn cloud-to-hq
         authby=secret
         left=%defaultroute
         leftid=130.193.32.25
         leftsubnet=10.128.0.0/24
         right=1.1.1.1
         rightsubnet=192.168.0.0/24
         ike=aes256-sha2_256-modp1024!
         esp=aes256-sha2_256!
         keyingtries=0
         ikelifetime=1h
         lifetime=8h
         dpddelay=30
         dpdtimeout=120
         dpdaction=restart
         auto=start
   ```

1. Open the file `/etc/ipsec.secrets` and enter your password:

   ```
   130.193.32.25 1.1.1.1 : PSK "<password>"
   ```

1. Restart strongSwan:

   ```
   $ systemctl restart strongswan
   ```

## 3. Set up static routing {#configure-static-route}

Set up routing between the IPSec instance and previously created VM with no public IP address:

Create a route table and add [static routes](../../vpc/concepts/static-routes.md):

1. Open the **Virtual Private Cloud** section in the folder where you want to create a static route.

1. Select the network to create the route table in.

1. Click ![image](../../_assets/plus.svg)**Create route table**.

1. Enter a name for the route table.

   {% include [name-format](../../_includes/name-format.md) %}

1. Click **Add route**.

1. In the window that opens, enter the prefix of the remote side destination subnet. In the example, this is `192.168.0.0/24`.

1. In the **Next hop** field, enter the internal IP address of the IPSec gateway. Click **Add**.

1. Click **Create route table**.

To use static routes, link the route table to a subnet. To do this:

1. In the line with the desired subnet, click ![image](../../_assets/options.svg).
1. In the menu that opens, select **Link route table**.
1. In the window that opens, select the created table from the list.
1. Click **Link**.

You can also use the created route for other subnets in the same network.

## 4. Configure IPSec on a different gateway {#configure-another-gateway}

For the VPN tunnel to work, you need to set up another IPSec gateway. You can create another cloud network with a subnet in your folder and create an IPSec instance from an image, or use a machine in your local network as a gateway.

1. Configure strongSwan the same as the first IPSec gateway, but swap IP addresses and subnets in the `/etc/ipsec.conf` file:

   ```
   conn hq-to-cloud
         authby=secret
         left=%defaultroute
         leftid=1.1.1.1
         leftsubnet=192.168.0.0/24
         right=130.193.32.25
         rightsubnet=10.128.0.0/24
         ike=aes256-sha2_256-modp1024!
         esp=aes256-sha2_256!
         keyingtries=0
         ikelifetime=1h
         lifetime=8h
         dpddelay=30
         dpdtimeout=120
         dpdaction=restart
         auto=start
   ```

1. In `/etc/ipsec.secrets`, enter the swapped gateway IP addresses followed by your password :

   ```
   1.1.1.1 130.193.32.25 : PSK "<password>"
   ```

1. Restart strongSwan:

   ```
   $ systemctl restart strongswan
   ```

## 5. Test the IPSec tunnel {#test-vpn}

To make sure the tunnel between gateways is established, run the following command on either gateway:

```
$ sudo ipsec status
Security Associations (1 up, 0 connecting):
 hq-to-cloud[3]: ESTABLISHED 29 minutes ago, 10.128.0.26[130.193.33.12]...192.168.0.23[1.1.1.1]
 hq-to-cloud{3}:  INSTALLED, TUNNEL, reqid 3, ESP in UDP SPIs: c7fa371d_i ce8b91ad_o
 hq-to-cloud{3}:   10.128.0.0/24 === 192.168.0.0/24
```

The `ESTABLISHED` status means that a tunnel between gateways was created.

To check the status of the strongSwan daemon, use the command `systemctl status strongswan`:

```
$ systemctl status strongswan
● strongswan.service - strongSwan IPsec IKEv1/IKEv2 daemon using ipsec.conf
   Loaded: loaded (/lib/systemd/system/strongswan.service; enabled; vendor preset: enabled)
   Active: active (running) since Thu 2019-06-20 14:54:07 UTC; 3 days ago
 Main PID: 481 (starter)
    Tasks: 18 (limit: 1117)
   CGroup: /system.slice/strongswan.service
           ├─481 /usr/lib/ipsec/starter --daemon charon --nofork
           └─527 /usr/lib/ipsec/charon
```

To view strongSwan logs, use the command `journalctl -u strongswan`. The logs contain information about connections.

## Delete the created resources {#clear-out}

If you no longer need the IPSec instance, [delete](../../compute/operations/vm-control/vm-delete.md) the `ipsec-instance` VM.

