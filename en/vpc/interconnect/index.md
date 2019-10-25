# Yandex Cloud Interconnect

{{ interconnect-full-name }} lets you establish a private dedicated connection between your local network infrastructure and Yandex.Cloud. Dedicated connections are more reliable, more secure, and faster than internet connections.

## Trunk link {#trunk-link}

The core {{ interconnect-name }} solution is a trunk link with bandwidth from 100 Mbps to 10 Gbps or more. Dedicated connections are created on top of trunk links.

## Private connection {#private-connection}

A private connection is set up on top of the trunk link to provide connectivity between your local network infrastructure and the Yandex.Cloud virtual network. You can connect multiple dedicated connections to one virtual network for backup purposes.

To isolate two dedicated connections inside a trunk link, traffic is tagged by a VLAN.

To exchange routing information and start passing traffic, you need to configure [BGP](https://en.wikipedia.org/wiki/Border_Gateway_Protocol).

### Setting up a private connection {#set-up-private-connection}

To use a private connection, you must submit a request. The request must indicate the point of presence where the connection is set up and the connection bandwidth. If you set up a connection via a partner, enter the name of the partner company.

As soon as your request is processed, our experts contact you to discuss the details. The service is provided when technically possible.

For the connection to run, set up a connection between your local network infrastructure and Yandex.Cloud virtual network:

1. [In the cloud, create](../quickstart.md) a virtual network and subnets to connect the local network infrastructure to.
1. Arrange the following parameters with Yandex.Cloud:
   * On your side:
     * Cloud ID.
     * Virtual network ID.
     * CIDR of the peering subnet from the link-local address range `169.254.x. x` with the prefix length of `/30` or `/31`.
     * IP addresses of the BGP peers on the user and Yandex.Cloud side.
     * BGP ASN.
   * On Yandex.Cloud side:
     * VLAN ID.

