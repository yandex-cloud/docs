# Physical interface with {{ yandex-cloud }} (L1)

## {{ yandex-cloud }} direct physical interface {#direct-link}

![direct-link](../../_assets/cloud-interconnect/interconnect-phy-1.svg)

A direct physical interface is a communication channel between client equipment and {{ yandex-cloud }} equipment at a point of presence, including physical ports and optical transceivers on the client equipment and the {{ yandex-cloud }} equipment. The direct interface is at Layer 1 of the OSI model.

The client equipment is located at the point of presence and connected to the {{ yandex-cloud }} equipment directly through a cross-connect in the point of presence. An optical cross-connect connects to the optical transceivers from the client equipment and the {{ yandex-cloud }} equipment. For physical connections, only duplex (dual-fiber) optical transceivers, where the transmitting side (TX) is connected to the receiving side (RX) with optical fiber, are used. A pair of these optical fibers makes up an optical cross-connect.

{% note warning "Important" %}

Single-fiber transceivers aren't used for physical connections.

{% endnote %}

## Interface via a telecom operator {#operator-link}

![direct-link](../../_assets/cloud-interconnect/interconnect-phy-2.svg)

The client doesn't have their own equipment at the point of presence. To connect to {{ yandex-cloud }}, the client uses a telecom operator that has equipment at the appropriate point of presence. An optical cross-connect connects to the optical transceivers from the telecom operator's equipment and the {{ yandex-cloud }} equipment.

The telecom operator connects the client's equipment in a data center to the telecom operator's equipment at the point of presence using their communication channels after the client approves the connection scheme.