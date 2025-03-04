# Creating a tunnel between two subnets using OpenVPN Access Server

When you use the computing resources of a public cloud, you often need a secure connection between two networks, e.g., your office network and a {{ yandex-cloud }} test farm. The best way to handle this is using a VPN, which allows you to:

* Connect networks residing in different locations.
* Provide contractors with an access to an in-house network.
* Set up an encrypted connection over Wi-Fi.

This tutorial describes how to create a VPN tunnel using the OpenVPN technology.

[OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) is built on and compatible with the OpenVPN [open-source version](https://github.com/OpenVPN). It provides clients for Windows, Mac, Android, and iOS. You can also use its web UI to manage connections.

In this example, we will create a tunnel connecting two subnets into a single network. The tunnel will be established between two VPN gateways: OpenVPN Access Server and a VM instance with the OpenVPN client. To test the VPN tunnel, you will need to configure both gateways. In our example, one subnet is hosted in {{ yandex-cloud }}, while the other may reside both in {{ yandex-cloud }} and in an external network.

To create a tunnel between two subnets:

1. [Get your cloud ready](#before-you-begin).
1. [Create a network and subnets](#create-environment).
1. [Create the VMs you want to connect](#create-target-vm).
1. [Create a gateway VM](#create-vm-gateway).
1. [Set up a VPN server](#create-vpn-server).
1. [Configure network traffic permissions](#network-settings).
1. [Get the administrator password](#get-admin-password).
1. [Create an OpenVPN remote user account](#configure-openvpn).
1. [Configure the OpenVPN gateway on the second subnet](#configure-second-end-of-the-tunnel).
1. [Test the VPN tunnel](#test-vpn-tunnel).

If you no longer need your VPN server, [delete the created VMs](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of the OpenVPN infrastructure support includes:

* Fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for a dynamic or static public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for the OpenVPN Access Server license (when using more than two connections).

## Create a network and subnets {#create-environment}

To connect cloud resources to the internet, make sure you have a [network](../../vpc/concepts/network.md) and [subnets](../../vpc/concepts/network.md#subnet).

### Create a network {#create-network}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cloud network.
  1. In the list of services, select **{{ vpc-name }}**.
  1. Click **Create network**.
  1. Specify the network name, e.g., `ovpn-network`.
  1. Disable the **Create subnets** option.
  1. Click **Create network**.

{% endlist %}

### Create subnets {#create-subnets}

{% list tabs group=instructions %}

- Management console {#console}

  1. Select the `ovpn-network` network.
  1. Click **Add subnet**.
  1. Specify the subnet name, e.g., `ovpn-left`.
  1. Select an [availability zone](../../overview/concepts/geo-scope.md) from the drop-down list.
  1. Enter the subnet CIDR: `10.128.0.0/24`.
  1. Click **Create subnet**.
  1. Repeat steps 2 to 6 to create the second subnet. Name it `ovpn-right` and specify its CIDR: `10.253.11.0/24`.

{% endlist %}

### Create the VMs you want to connect {#create-target-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}** in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, select an image for the VM.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) for the `ovpn-left` subnet.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network named `ovpn-network` and the `ovpn-left`subnet.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
      * Expand the **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** section:

          * In the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`.
          * In the input field that appears, specify `10.128.0.4`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify a username: `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `ao-openvpn-test`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. Repeat steps 1 to 7 to create the second VM. Specify its name: `vm-ovpn-host`, internal IPv4 address: `10.253.11.110`, and subnet: `ovpn-right`.

{% endlist %}

## Create a gateway VM {#create-vm-gateway}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}** in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, select an image for the VM.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) for the `ovpn-right` subnet.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network named `ovpn-network` and the `ovpn-right` subnet.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` or `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`.

          Either use static public IP addresses [from the list](../../vpc/operations/get-static-ip) or [convert](../../vpc/operations/set-static-ip) your VM IP address to static. If your VM has a dynamic IP address, it can change when you reboot your VM; as a result, your VM connections will no longer work.

      * Expand the **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** section. In the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`.
      * In the input field that appears, specify `10.253.11.19`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify a username: `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vm-ovpn-gw`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

## Set up a VPN server {#create-vpn-server}

Create a VM to run the VPN server:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, specify `OpenVPN Access Server` in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field and select the [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) where the `ovpn-left` subnet resides.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify the boot [disk](../../compute/concepts/disk.md) size: `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network named `ovpn-network` and the `ovpn-left` subnet.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` or `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`.

          Either use static public IP addresses [from the list](../../vpc/operations/get-static-ip.md) or [convert](../../vpc/operations/set-static-ip.md) your VM IP address to static. If your VM has a dynamic IP address, it can change when you reboot your VM; as a result, your VM connections will no longer work.

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select a [security group](../../vpc/concepts/security-groups.md). If you leave this field empty, the system will assign the [default security group](../../vpc/concepts/security-groups.md#default-security-group) to the network.
      * Expand the **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** section. In the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`.
      * In the input field that appears, specify `10.128.0.3`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify a username: `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vpn-server`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. This will open a window with the licensing model: BYOL (Bring Your Own License).
  1. Click **Create**.

{% endlist %}

## Configure network traffic rules {#network-settings}

{% include [openvpn-network-settings](../_tutorials_includes/openvpn-network-settings.md) %}

## Get the administrator password {#get-admin-password}

{% include [openvpn-get-admin-password](../_tutorials_includes/openvpn-get-admin-password.md) %}

## Create an OpenVPN remote user account {#configure-openvpn}

OpenVPN Access Server provides two web interfaces:

1. Client Web UI at `https://<VM_public_IP_address>:943/`. This UI allows regular users to download client applications and configuration profiles.
1. Admin Web UI at `https://<VM_public_IP_address>:943/admin/`. This UI allows the administrator to configure the server.

{% note info %}

By default, the server has a self-signed certificate. If you need to replace this certificate, follow the steps [here](https://openvpn.net/vpn-server-resources/installing-a-valid-ssl-web-certificate-in-access-server/).

{% endnote %}

Once you set up a {{ yandex-cloud }} VM running OpenVPN Access Server, you will have the following IP addresses and accounts (the addresses below are provided for information purposes; your actual IPs may be different):

1. `vpn-server` gateway internal IP: `10.128.0.3`
1. `vpn-server` VM public IP: `<VM_public_IP_address>`
1. Admin Web UI: `https://<VM_public_IP_address>:943/admin`
1. Admin UI account: `openvpn/<admin_password>`
1. Client Web UI: `https://<VM_public_IP_address>:943`

Create an OpenVPN account the second subnet gateway will use to connect to the OpenVPN server. Log in to the admin web UI:

1. In your browser, open `https://<VM_public_IP_address>:943/admin`.
1. Enter the `openvpn` username and password (see how to get the administrator password [here](#get-admin-password)).
1. Click **Agree**. This will open the OpenVPN Admin Web UI home page.
1. Expand the **User management** tab and select **User permissions**.
1. In the user list, specify the user name in the **New Username** field, e.g., `as-gw-user`.
1. Click the pencil icon in the **More Settings** column and specify the user password in the **Local Password** field.
1. In the **Access Control** field, select **User Routing** and specify the OpenVPN Access Server subnet, e.g., `10.128.0.0/24`.
1. In the **VPN Gateway** field, select **Yes** and specify the subnet that will connect to the OpenVPN server, e.g., `10.253.11.0/24`.
1. Click **Save settings**.
1. Click **Update running server**.
1. Log in to the client web UI under the `as-gw-user` account you created. Save the connection profile in a file named `as-gw-user.conf` and move this file to the OpenVPN gateway VM on the second subnet.

## Configure the OpenVPN gateway on the second subnet {#configure-second-end-of-the-tunnel}

Run the following commands in the `vm-ovpn-gw` console:

```bash
sudo apt update
sudo apt install openvpn
cp as-gw-user.conf /etc/openvpn/client/
echo -e "as-gw-user\n<password>" > /etc/openvpn/client/param.txt
```

A `param.txt` file will appear in the `/etc/openvpn/client/` folder. This is where you should copy the `as-gw-user.conf` connection profile you created in the previous step:

```bash
ls -lh /etc/openvpn/client/
```

Result:

```
total 16K
-rw-rw-r-- 1 root root 9.7K Nov 10 14:37 as-gw-user.conf
-rw-r--r-- 1 root root 24 Nov 10 14:31 param.txt
```

In the `/etc/openvpn/as-gw-user.conf` connection profile, specify `param.txt` in the `auth-user-pass` line:

```
dev tun
dev-type tun
remote-version-min 1.2
reneg-seq 604800
auth-user-pass param.txt
verb 3
push-peer-info
```

Run the following commands:

```bash
sudo systemctl enable openvpn-client@as-gw-user
sudo systemctl start openvpn-client@as-gw-user
sudo systemctl status openvpn-client@as-gw-user
```

The result should look like this:

```
● openvpn-client@as-gw-user.service - OpenVPN tunnel for as/gw/user
    Loaded: loaded (/lib/systemd/system/openvpn-client@.service; enabled; vendor preset:
enabled)
    Active: active (running) since Fri 2022-11-11 20:12:49 UTC; 1h 6min ago
        Docs: man:openvpn(8)
            https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
            https://community.openvpn.net/openvpn/wiki/HOWTO
    Main PID: 2626 (openvpn)
    Status: "Initialization Sequence Completed"
        Tasks: 1 (limit: 2237)
    Memory: 2.0M
        CPU: 157ms
    CGroup: /system.slice/system-openvpn\x2dclient.slice/openvpn-client@as-gw-user.service
            └─2626 /usr/sbin/openvpn --suppress-timestamps --nobind --config as-gw-user.conf
```

To enable packet transfers from other hosts, run these commands:

```bash
vm-ovpn-gw:~$ sudo bash -c "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
vm-ovpn-gw:~$ sudo sysctl -p
```

On the `vpn-server` gateway VM, check whether there is a route to `10.253.11.0/24`:
    
```bash
vpn-server:~$ sudo ip route
```

Result:
    
```
default via 10.128.0.1 dev eth0 proto dhcp src 10.128.0.3 metric 100
10.128.0.0/24 dev eth0 proto kernel scope link src 10.128.0.3
10.128.0.1 dev eth0 proto dhcp scope link src 10.128.0.3 metric 100
10.253.11.0/24 dev as0t2 proto static
172.27.224.0/22 dev as0t0 proto kernel scope link src 172.27.224.1
172.27.228.0/22 dev as0t1 proto kernel scope link src 172.27.228.1
172.27.232.0/22 dev as0t2 proto kernel scope link src 172.27.232.1
172.27.236.0/22 dev as0t3 proto kernel scope link src 172.27.236.1
```

On the `vm-ovpn-gw` VM, check the route to `10.128.0.0/24`:

```bash
sudo ip route
```

Result:

```
default via 10.253.11.1 dev ens18 proto dhcp src 10.253.11.19 metric 100
10.128.0.0/24 via 172.27.232.1 dev tun0 metric 101
10.253.11.0/24 dev ens18 proto kernel scope link src 10.253.11.19 metric 100
10.253.11.1 dev ens18 proto dhcp scope link src 10.253.11.19 metric 100
172.27.224.0/20 via 172.27.232.1 dev tun0 metric 101
172.27.232.0/22 dev tun0 proto kernel scope link src 172.27.232.5
178.154.226.72 via 10.253.11.1 dev ens18
```

## Test the VPN tunnel {#test-vpn-tunnel}

To test the tunnel, you will need two test VMs you created in the previous steps. These VMs must reside in both subnets and be different from the tunnel gateways.

To exchange data, both VMs must have static routes to each other’s subnets: `ao-openvpn-test` to `10.253.11.0/24`, and `vm-ovpn-host` to `10.128.0.0/24`.

On the `vm-ovpn-host` VM, run the following command:

```bash
sudo ip route add 10.128.0.0./24 via 10.253.11.19
```

Adding a static route on the test VM in {{ yandex-cloud }} will not work. In {{ yandex-cloud }}, you should specify VM static routes [differently](../../vpc/concepts/routing.md).

In {{ yandex-cloud }}, the `ao-openvpn-as` OpenVPN server VM and `ao-openvpn-test` VM reside in the same `default` subnet. In the settings of this subnet, add a static route with the following parameters:
    
```
Name: office-net
Prefix: 10.253.11.0/24
Next hop: 10.128.0.3
```

To apply this static route to the `ao-openvpn-test` VM, shut it down and start it again.

Use the `ping` command on the `vm-ovpn-host` VM to test the VPN connection to the second test VM:
    
```bash
ping 10.128.0.4
```

Result:
    
```
PING 10.128.0.4 (10.128.0.4) 56(84) bytes of data.
64 bytes from 10.128.0.4: icmp_seq=1 ttl=61 time=7.45 ms
64 bytes from 10.128.0.4: icmp_seq=2 ttl=61 time=5.61 ms
64 bytes from 10.128.0.4: icmp_seq=3 ttl=61 time=5.65 ms
^C
--- 10.128.0.4 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 5.613/6.235/7.446/0.855 ms
```

Do the same to test the VPN connection on the `ao-openvpn-test` VM:

```bash
ping 10.253.11.110
```

Result:
    
```
PING 10.253.11.110 (10.253.11.110) 56(84) bytes of data.
64 bytes from 10.253.11.110: icmp_seq=1 ttl=61 time=6.23 ms
64 bytes from 10.253.11.110: icmp_seq=2 ttl=61 time=5.90 ms
64 bytes from 10.253.11.110: icmp_seq=3 ttl=61 time=6.09 ms
64 bytes from 10.253.11.110: icmp_seq=4 ttl=61 time=5.69 ms
^C
--- 10.253.11.110 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 5.688/5.976/6.229/0.203 ms
```

## How to delete the resources you created {#clear-out}

To free up resources, [delete](../../compute/operations/vm-control/vm-delete.md) the `vpn-server` VM and the test VM.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).

#### See also {#see-also}

* [OpenVPN Project Wiki](https://community.openvpn.net/openvpn/wiki)
* [{#T}](../../certificate-manager/operations/managed/cert-get-content.md)
* [Connecting to Access Server](https://openvpn.net/vpn-server-resources/connecting-to-access-server-with-linux/#openvpn-open-source-openvpn-cli-program)
