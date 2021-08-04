---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# {{ interconnect-full-name }}

{{ interconnect-full-name }} lets you establish a private dedicated connection between your local network infrastructure and {{ yandex-cloud }}. Dedicated connections are more reliable, more secure, and faster than internet connections.

## Trunk link {#trunk-link}

The core {{ interconnect-name }} solution is a trunk link with bandwidth from 100 Mbps to 10 Gbps or more. Trunk links are provided using a 10GE LR-LC optical joint with {{ yandex-cloud }} equipment. Dedicated connections are created on top of trunk links.

{{ yandex-cloud }} points of presence:

* MMTS-9, ul. Butlerova 7, Moscow, Russia
* StoreData, ul. Nizhegorodskaya, 32, str. A, Moscow, Russia
* Dataline NORD, Korovinskoe shosse, 41, Moscow, Russia
* Dataline OST, ul. Borovaya, 7, str. 10, Moscow, Russia

## Private connection {#private-connection}

A private connection is set up on top of the trunk link to provide connectivity between your local network infrastructure and the {{ yandex-cloud }} virtual network. You can connect multiple dedicated connections to one virtual network for backup purposes.

To isolate two dedicated connections inside a trunk link, traffic is tagged by a VLAN.

To exchange routing information and start passing traffic, you need to configure [BGP](https://en.wikipedia.org/wiki/Border_Gateway_Protocol). The number of prefixes that can be accepted is limited: you can announce a maximum of 500 routes. If the threshold is exceeded, a BGP session is reset and reinitialized.

When setting up a private connection, we recommend ensuring trunk link redundancy through several points of presence. There's no redundancy support for VPC access through a single site nor support for router failover protocols (such as CARP, HSRP, or VRRP), since these methods don't increase reliability compared to a single private channel.

Within a single site, you can use:

* Link aggregation methods (LACP), including in active/passive mode.
* Switch stacking on the user side, provided that the switches are combined in a single logical unit.

You can create [two](limits.md) private connections on top of a single trunk link.

### Setting up a private connection {#set-up-private-connection}

To use a private connection, [submit a request](https://cloud.yandex.com/services/interconnect#interconnect-form). The request must indicate the point of presence where the connection is set up and the connection bandwidth. If you set up a connection via a partner, enter the name of the partner company.

As soon as your request is processed, our experts contact you to discuss the details. The service is provided when technically possible.

For the connection to run, set up a connection between your local network infrastructure and a {{ yandex-cloud }} virtual network:

1. In the cloud, [create](../../vpc/quickstart.md) a virtual network and subnets to connect the local network infrastructure to.
1. Arrange the following parameters with {{ yandex-cloud }}:
   * On your side:
     * Cloud ID.
     * Virtual network ID.
     * CIDR of a peer-to-peer subnet from the [RFC1918](https://tools.ietf.org/html/rfc1918) range of private addresses.
     * IP addresses of the BGP peers on the user and {{ yandex-cloud }} side.
     * BGP ASN.
   * On the {{ yandex-cloud }} side:
     * VLAN ID.

