# Transceivers

To connect your or telecom provider's equipment to the {{ yandex-cloud }} equipment, one uses optical modules known as transceivers. To set up a connection, select a **transceiver type** from the table below.

When one orders {{ interconnect-name }}, a port with the transceiver type selected by the client is reserved on the {{ yandex-cloud }} equipment.

Your or telecom provider's equipment must have a transceiver installed that is compatible with the transceiver type on the {{ yandex-cloud }} equipment. It is you or your telecom provider that has to purchase this transceiver on their own.

You can find the transceivers the {{ yandex-cloud }} equipment supports below:

{% include [transceivers](../../_includes/interconnect/transceivers.md) %}

All transceivers have Duplex LC connectors with a UPC polish.

For each optical cross-connect, you can only use single-mode (SM) optical fibers.

{% note alert %}

* The types of transceivers that are not listed in the above table are **not supported**.
* There is **no support** for optical single-fiber transceivers.
* Copper transceivers operating over twisted pair, such as UTP5 and UTP6, are **not supported**.
* Multi-mode (MM) optical fibers **are not allowed**.

{% endnote %}
