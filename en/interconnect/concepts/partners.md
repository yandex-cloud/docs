# {{ interconnect-name }} partners



{{ interconnect-name }} partners are telecom providers that deliver enhanced options for connecting to {{ yandex-cloud }} equipment. They provide _partner trunks_, which are quicker and less costly for customers to set up than direct connections.

To set up a partner trunk, the customer will need to independently enter into a service agreement with the partner.

{{ yandex-cloud }} charges for customer's partner trunks according to the [pricing policy](../pricing.md).

The partner can provide the {{ yandex-cloud }} equipment connection service at one or more points of presence.

Upon the customer's request, the partner may provide the services to set up a direct trunk between the customer equipment and {{ yandex-cloud }} equipment.


To set up a partner trunk, use [this tutorial](../tutorials/partner-trunk-priv-add.md).


{% note warning %}

Not every service provider is a {{ interconnect-name }} partner.

{% endnote %}

## List of {{ interconnect-name }} partners {#list}

Partner | PoPs | Maximum capacity, Mbps | Notes
--- | --- | --- | ---
[RETN](https://retn.net/) | M9, OST | 10,000 | - |
[MASTERTEL](https://mastertel.ru/yacloud/) | M9, NORD | 1,000 | - |
[MSK-IX](https://www.msk-ix.ru/) | M9 | 1,000 | - |
[ER-Telecom](https://ertelecom.ru/) | M9, NORD | 1,000 | - |
[Beeline](https://beeline.ru) | M9 | 1,000 | - |
[Obit](https://www.obit.ru/company/channels/) | M9 | 1,000 | - |
[TNS Plus](https://tnsplus.kz/) | M9 | 1,000 | - |
[Selectel](https://selectel.ru) | M9 | 1,000 | - |
[Ul-com](https://ul-com.ru) | TEHNO | 10,000 | - |
[NEXTREMUM](https://nextremum.net/ru) | TEHNO | 10,000 | - |

Where:

* `Partner`: Name of the partner company and link to their website.
* `PoPs`: List of [points of presence](./pops.md) where the partner interfaces with {{ yandex-cloud }}. The partner can provide the connection service at one or more points of presence.
* `Maximum capacity`: Maximum [connection](../pricing.md) capacity in Mbps (`mbps`) the partner can provide to the customer when setting up a partner trunk. The maximum capacity in a partner trunk is also limited by the number of packets transmitted per unit of time. For a 1,000 Mbps connection, the default maximum number of packets cannot exceed 100,000 packets per second. For a 10,000 Mbps connection, the default maximum number of packets cannot exceed 1,000,000 packets per second. For information on utilization of such connections, contact support.

If a customer needs a trunk that exceeds the maximum capacity, they can request the partner to provide a [direct trunk](./trunk.md#sp-link) to the {{ yandex-cloud }} equipment through a separate cross-connect.

## How to become a {{ interconnect-name }} partner {#list}

If your company wants to become a {{ yandex-cloud }} partner to deliver {{ interconnect-name }} services, send your request to <cloud-noc@yandex.net>.

