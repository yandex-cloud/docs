# DHCP in a {{ baremetal-full-name }} network

In public and private subnets, you can use [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol) to automatically configure IP addressing parameters on server interfaces. If the server OS is installed from {{ marketplace-short-name }} images, getting IP addresses via DHCP is enabled by default on all physical interfaces of the server.

{% note warning %}

DHCP can only be used to assign an IP address directly to the physical interface of a network card by fixing the MAC address, so we do not recommend changing the MAC addresses of server network cards. 

{% endnote %}

To assign multiple IP addresses to a single physical interface, e.g., in case of virtualization, you will need to use your own DHCP server. Changing the DHCP service settings on a subnet can globally affect network connectivity on the private network for servers that use DHCP.

## DHCP options {#dhcp-options}

The following DHCP options are transmitted on public and private networks:

* `1`: Subnet Mask. Subnet mask.
* `3`: Router. Default gateway. Subnet gateway for public subnets.
* `6`: Domain Server. DNS server addresses. `77.88.8.8`, `77.88.8.1` for public subnets.
* `51`: Lease Time. The time the address is issued for is 12 hours.
* `54`: DHCP Server Id: Subnet gateway.
* `58`: Renewal Time. The time after which the client will start re-requesting the address is 5 minutes.
* `59`: Rebinding Time. The time after which the server will send a broadcast request to update the address is 7 minutes.
* `121`: Classless Static Route: Static routes in the network. For private subnets, these are `10.0.0.0/8`, `192.168.0.0/16`, and `172.16.0.0/12` through the subnet gateway. Used to access other subnets within VRF.

## DHCP in public network {#dhcp-public}

If the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field in the server network settings is set to `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}`, its network interface connected to a public network will get an IPv4 address from the public range of internet networks. In this case, DHCP assigns IP addresses to servers on a public subnet with the `/31` prefix. You cannot disable DHCP.

If DHCP is disabled on a server, consider the following when configuring the network interface of a public network:

* The subnet which the server's public IP address belongs to has a CIDR with a `/31` prefix and consists of two addresses: the gateway IP address and the host IP address.
* The host IP address is specified in the **Public IPv4 address** field on the page with server information.
* The gateway IP address is less than the host IP address by one.

Here is an example:

* Server public IPv4 address: `198.51.100.111`.
* Subnet CIDR: `198.51.100.110/31`.
* Gateway IP address: `198.51.100.110`.

### DHCP in a public subnet {#dhcp-public-subnet}

[Public subnets](./network.md#public-subnet) do not have a DHCP server. If the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field in the server network settings is set to `{{ ui-key.yacloud.baremetal.label_public-ip-from-dedicated-subnet }}`, on the network interface of a server connected to a public subnet, you need to manually set up a static IP address from the subnet’s range of public IP addresses and set the default gateway address. 

{% include [public-subnet-address-info](../../_includes/baremetal/public-subnet-address-info.md) %}

You cannot enable DHCP in a public subnet.

## DHCP in a private network {#dhcp-private}

The server network interface connected to a private network gets an IP address from the CIDR specified in the routing settings of the private subnet the server is connected to.

Within a private network, you can manage the DHCP service parameters:

* By default, the DHCP service is disabled in the subnet settings. In this case, IP addresses for servers in a private subnet are assigned statically. When the DHCP service is enabled for a subnet, IP addresses can be assigned for servers automatically. 
* When configuring the DHCP service for a subnet, you can specify additional parameters.

The DHCP service can be used in a subnet for only one CIDR, from which an address will be assigned only for the server’s physical interface. If you need to configure DHCP to assign addresses for VMs, you need to configure it on your own, for example, using your own DHCP server.

DHCP in a private network assigns addresses for 12 hours. The server extends the address lease every 5 minutes for another 12 hours. If you need to update the address faster, you should do it manually on the server:

1. Find out the interface name and current address:

    ```
    ip -4 address
    ...
    2: etx1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
        altname eno1
        altname enp2s0f0
        inet 10.0.0.2/28 metric 100 brd 10.0.0.15 scope global dynamic etx1
        valid_lft 43037sec preferred_lft 43037sec
    ...
    ```

1. Reset the address lease:

    ```
    dhclient -r etx1
    ```

1. Renew your lease:

    ```
    dhclient etx1
    ```

## Known issues {#known-issues}

If you have Ubuntu 18 installed on your server, DHCP may add an address from the new subnet to the server without deleting the old one after reconfiguring your network settings, for example, when changing subnets. The old address will be deleted automatically when the lease expires. You can also use the `ip -4 addr del 10.0.0.2/10 dev etx1` command to delete the address or reboot the server after changing the configuration. 
