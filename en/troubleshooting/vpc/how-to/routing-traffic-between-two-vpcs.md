# How to route traffic between two cloud networks



## Case description {#case-description}

You need to connect two cloud networks.

## Solution {#case-resolution}

There are multiple options available:

1. **Internet routing**: In each subnet, create a VM with an external IP address and associate route tables referencing these external addresses with the subnets.
1. **Creating a VPN tunnel from one network to another**: In one of the subnets, create a VM with an external IP address and set up a VPN server on it. In the other subnet, configure a connection to this server on a web-enabled VM, and then attach routing tables to these subnets via a VPN tunnel. On our marketplace, we have ready-made solutions for [OpenVPN](../../../vpc/tutorials/openvpn.md) and [IPSec](../../../vpc/tutorials/ipsec/ipsec-vpn.md).
1. **Using specific VM routers**: Certain images allow creating VMs with multiple interfaces that can be linked with different cloud networks. The easiest solution is to use a NAT instance from the marketplace. We have a [tutorial that describes using such an image](../../../vpc/tutorials/nat-instance/index.md) to enable online access. You may use it as a base. Please note that you will need to add a second interface with an address in the subnet you need to the VM, as well as add specific routes to the routing tables instead of the default route.
1. If you are familiar with **[CISCO](../../../vpc/tutorials/cisco.md) or [Mikrotik](../../../vpc/tutorials/mikrotik.md)** solutions, you can use their virtual routers. Their images can also be downloaded from the marketplace; however, they require licenses for full-scale operation. You can also create multiple network interfaces on such VMs; however, you will have to configure them on your own.
