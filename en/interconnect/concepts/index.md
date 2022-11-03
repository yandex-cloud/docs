# {{ interconnect-full-name }}

{{ interconnect-full-name }} lets you establish a private dedicated connection between your local network infrastructure and {{ yandex-cloud }}. Dedicated connections are more reliable, more secure, and faster than internet connections.

CIC is made up of a number of interactions between elements at different layers of the OSI model:

* [L1 connectivity](l1-physical.md): Layer with equipment, physical connection channels (cross connections), and optical transceivers.
* [L2 connectivity](l2-trunk.md): Ethernet-based layer – 802.1q and 802.1ad (QinQ).
* [L3 connectivity](l3-ip-bgp.md): Layer of IP, BFD, and BGP protocols. This layer enables the exchange of routing data between interaction participants.

## Trunk connection {#trunk-link}

A trunk link with a bandwidth of between 100 Mbps and 10 Gbps is at the core of the {{ interconnect-name }} solution. To set up a trunk link, your equipment is connected to {{ yandex-cloud }} equipment with optical transceivers. For more information about arranging a trunk connection, see [{#T}](../manual.md).

## Private connection {#private-connection}

A private connection is set up on top of the trunk link to provide connectivity between your local network infrastructure and the {{ yandex-cloud }} virtual network. You can connect multiple dedicated connections to one virtual network for backup purposes.

## Public connection {#public-connection}

A public connection is a stream of data sent over a trunk connection and tagged with a specific VLAN-ID value. Public connections are normally used to organize direct connectivity with Object Storage in {{ yandex-cloud }}.

## What's next {#whats-next}

* Prepare the infrastructure and [connect {{ interconnect-name }}](../manual.md).
* Learn the principles of [traffic routing](routing.md) when using {{ interconnect-name }}.
* Learn about the main [service metrics](user-metrics.md).