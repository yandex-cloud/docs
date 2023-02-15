# Transceivers

To connect your or telecom provider's equipment to the {{ yandex-cloud }} equipment, optical modules, known as transceivers, are used. To set up a connection, select a **transceiver type** from the table below.

When the {{ interconnect-name }} service on the {{ yandex-cloud }} equipment is ordered, a port with the transceiver type selected by the client is reserved.

Your or telecom provider's equipment must have a transceiver installed that is compatible with the transceiver type on the {{ yandex-cloud }} equipment. The client or telecom provider must purchase this transceiver themselves.

Transceivers the {{ yandex-cloud }} equipment supports is listed in the table below.

{% include [transceivers](../../_includes/interconnect/transceivers.md) %}

All transceivers have Duplex LC connectors with a UPC polish.

For each optical cross-connect, only single-mode (SM) optical fibers can be used.

{% note alert %}

* Other types of transceivers that are not listed in the table above are **not supported**.
* There is **no support** for optical single-fiber transceivers.
* Copper transceivers operating over twisted pair, such as UTP5 and UTP6, are **not supported**.
* Multi-mode (MM) optical fibers **are not allowed**.

{% endnote %}
