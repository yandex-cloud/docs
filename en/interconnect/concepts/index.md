# {{ interconnect-full-name }}

{{ interconnect-full-name }} lets you establish a private dedicated connection between your local network infrastructure and {{ yandex-cloud }}. Dedicated connections are more reliable, more secure, and faster than internet connections.

## Trunk link {#trunk-link}

A trunk link with a bandwidth of between 100 Mbps and 100 Gbps is at the core of the {{ interconnect-name }} solution. To set up a trunk link, your equipment is connected to that of {{ yandex-cloud }} with optical transceivers using the following standards:

| Standard | Bandwidth<br/> | Maximum<br/>distance |
| ----- | ----- | ----- |
| SFP-1GBASE-LX | 1 Gbps | 10 km |
| SFP+-10GBASE-LR | 10 Gbps | 10 km |
| SFP+-10GBASE-ER | 10 Gbps | 40 km |
| QSFP28-100GBASE-LR | 100 Gbps | 10 km |
| QSFP28-100GBASE-ER | 100 Gbps | 40 km |

All the transceivers have Duplex LC connectors with a UPC polish.

The transceiver types listed have been tested for compatibility with {{ yandex-cloud }} equipment, which enables us to provide a service at the target quality level. If you are using a different transceiver standard, contact one of the partner operators listed on the [{{ interconnect-name }} page](https://cloud.yandex.com/services/interconnect) to connect to {{ yandex-cloud }} through this partner's client port.

Other channel features:

* Autonegotiation is not supported. The port transmission rate of the client hardware must be set manually based on the transceiver type.
* The ports work as trunk ports.
* All frames must have tags according to the IEEE 802.1Q standard with a VLAN identifier (VID) ranging from 1 to 4060. Native VLAN is not supported.
* EtherType: `0x8100`.

For a single point of presence, you may use:

* Link aggregation methods (LACP) in active mode.
* Switch stacking on the user side, provided that the switches are combined in a single logical unit.

For each trunk channel, there is a transmission rate limit in bits per second and in packets per second both for cloud downlink and for upload. This means that if the bit or the packet rate exceeds the maximum value, packets can be discarded. As a result, uniform traffic may be transmitted at a higher speed than traffic transmitted in sudden bursts.

{{ yandex-cloud }} points of presence:

* MMTS-9, ul. Butlerova 7, Moscow, Russia
* StoreData, ul. Nizhegorodskaya, 32, str. A, Moscow, Russia
* Dataline NORD, Korovinskoe shosse, 41, Moscow, Russia
* Dataline OST, ul. Borovaya, 7, str. 10, Moscow, Russia

## Private connection {#private-connection}

A private connection is set up on top of the trunk link to provide connectivity between your local network infrastructure and the {{ yandex-cloud }} virtual network. You can connect multiple dedicated connections to one virtual network for backup purposes.

To isolate two dedicated connections inside a trunk link, traffic is tagged by a VLAN.

To exchange routing information and forward traffic, you need to configure [BGP](https://en.wikipedia.org/wiki/Border_Gateway_Protocol):

* The number of prefixes that can be accepted is limited: you can announce a maximum of 500 routes. If the threshold is exceeded, a BGP session is reset and reinitialized.
* The Hold Timer value is 90 seconds.

The BFD (Bidirectional Forwarding Detection) protocol with an interval of 300 ms for incoming and outgoing packets and a multiplier of 3 is used in {{ yandex-cloud }} to ensure fast BGP convergence and traffic switching between private connections.

When setting up a private connection, we recommend ensuring trunk link redundancy through several points of presence. There's no redundancy support for {{ vpc-short-name }} access through a single site nor support for router failover protocols (such as CARP, HSRP, or VRRP), since these methods don't increase reliability compared to a single private channel.

You can create [two](../concepts/limits#yandex-cloud-interconnect) private connections over a single trunk link.

### Setting up a private connection {#set-up-private-connection}

To use a private connection, [submit a request](https://cloud.yandex.com/services/interconnect#interconnect-form). The request must indicate the point of presence where the connection is set up and the connection bandwidth. If you set up a connection via a partner, enter the name of the partner company.

As soon as your request is processed, our experts contact you to discuss the details. The service is provided when technically possible.

For the connection to run, set up a connection between your local network infrastructure and a {{ yandex-cloud }} virtual network:

1. [Create](../../vpc/quickstart.md) virtual networks and subnets in the cloud that the local network infrastructure will connect to.
1. Arrange the following parameters with {{ yandex-cloud }}:
   * On your side:
     * Cloud ID.
     * Virtual network ID.
     * CIDR of a peer-to-peer subnet from the [RFC1918](https://tools.ietf.org/html/rfc1918) range of private addresses.
     * IP addresses of the BGP peers on the user and {{ yandex-cloud }} side.
     * BGP ASN.
   * On the {{ yandex-cloud }} side:
     * VLAN ID.

