# How to route traffic between two cloud networks



## Scenario description {#case-description}

You need to link two VPC networks.

## Solution {#case-resolution}

There are several solutions to this issue:

We can suggest several solutions:

1. **Internet routing**: Create, in each subnet, a VM with an external IP address and attach routing tables referencing these external addresses to the subnets.
2. **Creating a VPN tunnel from one network to another**: Create, in one of the subnets, a VM with an external IP address, and set up a VPN server on it. In the other subnet, configure a connection to this server on a web-enabled VM, then attach routing tables to these subnets via the VPN tunnel. On our marketplace, we have ready-made solutions for [OpenVPN](https://cloud.yandex.ru/docs/vpc/tutorials/openvpn) and [IPSec](https://cloud.yandex.ru/docs/vpc/tutorials/ipsec-vpn).
3. **Using special VM routers**: Certain images allow creating VMs with multiple interfaces that can be linked with different cloud networks. The easiest solution is to use a NAT instance from the marketplace. In the documentation, you can find a [scenario for using such an image](https://cloud.yandex.ru/docs/vpc/tutorials/nat-instance) to enable online access. You may use it as a blueprint. Please note that you will need to add a second interface with an address in the desired subnet to the VM and add specific routes to the routing tables instead of the default route.
4. If you are familiar with **[CISCO](https://cloud.yandex.ru/docs/vpc/tutorials/cisco) or [Mikrotik](https://cloud.yandex.ru/docs/vpc/tutorials/mikrotik) solutions**, you can use their virtual routers. Their images can also be downloaded from the marketplace; however, they require licenses for full-scale operation. You can also create multiple network interfaces on such VM instances, but you need to configure them yourself.
