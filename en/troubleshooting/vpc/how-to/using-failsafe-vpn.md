# How to use a fault-tolerant VPN or NGFW


## Case description {#case-description}

You need to use VRRP, floating IP address, fault-tolerant VPN gateway, or NGFW.

## Solution {#case-resolution}

Due to the specific technical implementation of the virtual network, {{ yandex-cloud }} does not support VRRP or other L2 protocols. For more information on how the {{ yandex-cloud }} network architecture works, watch [this video](https://www.youtube.com/watch?v=g3cZ0o50qH0).

You might find the following tutorials on implementing fault-tolerant systems useful:

* [Implementing fault-tolerant scenarios for network VMs](../../../tutorials/routing/route-switcher.md)
* [Implementing a secure high-availability network infrastructure with a dedicated DMZ using a next-generation firewall](../../../tutorials/routing/high-accessible-dmz.md)