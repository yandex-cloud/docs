# Transceivers

Optical modules, or transceivers, are used to connect your equipment or telecom provider equipment to {{ yandex-cloud }} equipment. To set up a connection, you need to select a **transceiver type** from the table below.

When you order {{ interconnect-name }}, {{ yandex-cloud }} reserves a port with the transceiver type you selected on the {{ yandex-cloud }} equipment.

Your equipment or telecom provider equipment must have a transceiver compatible with that on the {{ yandex-cloud }} equipment. It is you or your telecom provider that has to purchase this transceiver on their own. 

See the table below for a list of optical transceivers that work with {{ yandex-cloud }} equipment.

{% include [transceivers](../../_includes/interconnect/transceivers.md) %}

All transceivers have Duplex LC connectors with UPC polish. 

For each optical cross-connect, you can only use single-mode (SM) optical fibers.

{% note alert %}

* Other types of transceivers that are not listed in the above table are **not supported**. 
* There is **no support** for optical single-fiber transceivers.
* Copper transceivers using twisted pair, such as UTP5 and UTP6, are **not supported**.
* Multi-mode (MM) optical fibers **are not allowed**.

{% endnote %}
