# Network security

This section provides customers with recommendations on security settings in [Yandex Virtual Private Cloud](../../../vpc/index.yaml).


## Creating a protected segmented environment{#protect}

To control network access to your resources, use one of the following:

- [Security groups](../../../vpc/concepts/security-groups.md).

  With built-in security groups, you can manage VM access to resources and security groups in Yandex.Cloud or resources on the internet. A security group is a set of rules for incoming and outgoing traffic that can be assigned to a VM's network interface. Security groups work like a stateful firewall: they monitor the status of sessions and, if a rule allows creating a session, they automatically allow response traffic. For instructions on how to set up security groups, see [{#T}](../../../vpc/operations/security-group-create.md). You can specify a security group in the VM settings.

  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Setting up security groups (dev/stage/prod) using Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation)

- A separate VM as a firewall based on an NGFW image from [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace?categories=network).

  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Installing an NGFW on a Yandex.Cloud VM: Check Point](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM)

- The Router-on-a-Stick method based on [Cloud Interconnect](../../../interconnect/index.yaml): you can connect your own firewall to the Yandex.Cloud infrastructure via a dedicated channel and route traffic to cloud networks through this firewall.

To deliver traffic to an application within the cloud infrastructure, use a network load balancer, such as [Yandex Application Load Balancer](../../../application-load-balancer/index.yaml), which only passes traffic to the specified ports. We recommend that you use the network load balancer together with security groups to limit the list of IP addresses that have access to the application.

To isolate applications from each other, put resources in different security groups, and, if strict isolation is required, in different VPCs. Traffic inside a VPC is allowed by default and is not allowed between VPCs (only via VMs with two network interfaces in different networks, VPN, or Cloud Interconnect).

## DDoS protection

When assigning public IP addresses to your cloud resources, enable the built-in [DDoS protection](../../../vpc/ddos-protection/index.md) at L4. If you need DDoS protection at L7, contact your manager.

## Setting up remote access and communication channels

To enable administrators to establish remote connections to your cloud resources, use one of the following:

- A site-to-site VPN between a remote site (such as your office) and a cloud. As a remote access gateway, use a VM featuring a site-to-site VPN based on an image from [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace?categories=network).

  Setup options:
  - [Creating an IPsec VPN tunnel using the strongSwan](../../../solutions/routing/ipsec-vpn.md) daemon
  - ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Creating a site-to-site VPN connection to Yandex.Cloud using Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/vpn)

- A client VPN between remote devices and Yandex.Cloud. As a remote access gateway, use a VM featuring a client VPN based on an image from [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace?categories=network). See the instructions in [{#T}](../../../solutions/routing/openvpn.md).

- A dedicated private connection between a remote site and Yandex.Cloud using [Cloud Interconnect](../../../interconnect/index.yaml).


To access the infrastructure using control protocols (for example, SSH or RDP), create a bastion VM. You can do this using a free [Teleport](https://goteleport.com/) solution. Access to the bastion VM or VPN gateway from the internet must be restricted.

For better control of administrative actions, we recommend that you use PAM (Privileged Access Management) solutions that support administrator session logging (for example, Teleport). For SSH and VPN access, we recommend that you avoid using passwords and use public keys, X.509 certificates, and SSH certificates instead. When setting up SSH for your virtual machines, we recommend that you use the SSH certificates (for the SSH host as well).

To access web services deployed in the cloud, use TLS version 1.2 or higher.

## Outbound internet access

Possible options for setting up outbound internet access:

- [Public IP address](../../../vpc/concepts/address.md#public-addresses). Assigned to a VM according to the one-to-one NAT rule.
- [Egress NAT](../../../vpc/operations/enable-nat.md). Enables internet access for a subnet through a shared pool of Yandex.Cloud public IP addresses. We don't recommend that you use Egress NAT for critical interactions, since the NAT gateway's IP address might be used by multiple clients at the same time. This feature must be taken into account when modeling threats for your infrastructure.
- [NAT instance](../../../solutions/routing/nat-instance.md). The NAT function is performed by a separate VM. You can create this VM using an image from [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace/products/f2etqeet87jshce7o7j8).

Comparison of internet access methods:

| Public IP address | Egress NAT | NAT instance |
| ----- | ----- | ----- |
| **Advantages:**</br>- No setup required</br>- A dedicated IP address for each VM | **Advantages:**</br>- No setup required<br/>- Only works for outgoing connections | **Advantages:**</br>- Traffic filtering on a NAT instance<br/>- Using your own firewall<br/>- Effective use of IP addresses |
| **Disadvantages:**</br>- It might be unsafe to expose a VM directly to the internet<br/>- The cost of reserving each IP address | **Disadvantages:**</br>- A shared pool of IP addresses</br>- The feature is at the [Preview](../../../overview/concepts/launch-stages.md) stage, therefore it's not recommended for production environments | **Disadvantages:**</br>- Setup required<br/>- The cost of using a VM (vCPU, RAM, and disk space) |

Regardless of which option you select for setting up outgoing internet access, be sure to limit traffic using one of the mechanisms described above in [{#T}](#protect). To build a secure system, use [static IP addresses](../../../vpc/concepts/address.md), since they can be added to the list of exceptions of the receiving party's firewall.

## DNS security

To increase fault tolerance, some traffic can be routed to third-party recursive resolvers. To avoid this, contact [support](../../../support/overview.md).

