# Supported optical transceiver types

To connect to {{ yandex-cloud }} equipment, optical modules, known as transceivers, are required. When a {{ interconnect-name }} service on {{ yandex-cloud }} equipment is ordered, the client is reserved a port with the chosen transceiver type. At the other end of the connection, the client or operator's equipment must have a transceiver installed that is compatible with the {{ yandex-cloud }} transceiver.

Transceivers that {{ yandex-cloud }} equipment supports is listed in the table below. Other transceiver types are not supported.

{% include [transceivers](../../_includes/interconnect/transceivers.md) %}

All the transceivers have Duplex LC connectors with a UPC polish.

For each optical cross-connect, only single-mode (SM) optical fibers can be used. Multi-mode (MM) optical fibers aren't allowed.

The following transceiver types aren't supported:

* Optical single-fiber transceivers.
* Copper transceivers operating over twisted pair (such as UTP5 and UTP6).
