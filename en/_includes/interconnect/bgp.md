## BGP connectivity {#bgp-peering}

BGP connectivity is configured within each private or public connection between the client equipment and {{ yandex-cloud }} equipment at the [point of presence](../../interconnect/concepts/pops.md) for exchanging subnet (prefix) data. After exchanging this routing data, the sides can distribute IPv4 traffic across the subnets they communicated to each other.

{% note warning %}

On the {{ yandex-cloud }} equipment side, there is a [limit](../../interconnect/concepts/limits.md#interconnect-limits) on the number of prefixes received from the client router over BGP.
If this limit is exceeded, a BGP session is terminated for 30 minutes.

To maintain continuous BGP connectivity, we recommend setting up policies for routing information aggregation on the client router to minimize the number of prefixes announced over BGP towards the {{ yandex-cloud }} equipment to ensure the reasonable and required sizes.

{% endnote %}

### BGP ASN {#bgp-asn}

To set up BGP connectivity, each side must specify the BGP autonomous system number (ASN). The BGP ASN value for {{ yandex-cloud }} is fixed at **{{ cic-bgp-asn }}**. On the client side, you can set up a public BGP ASN (if any) or use any number from private BGP ASNs in the range of `64512 — 65534`.

{% note warning %}

On the {{ yandex-cloud }} side, a 4-byte BGP ASN value, **{{ cic-bgp-asn }}**, is used. When using network equipment from different vendors, using 2-byte BGP ASN values as the most common ones will be prioritized.

When setting up BGP connectivity on the client router side, make sure to explicitly allow 4-byte BGP ASN values in its configuration.

When setting up BGP interaction on the client router, for public connections on public IPv4 addresses owned by the client, make sure to specify the client's public BGP ASN.

{% endnote %}

### BGP authentication (optional) {#bgp-auth}

To increase the security level of a BGP connection, you can use BGP authentication based on the `BGP MD5 password` mechanism. If the feature is enabled, use a string of more than 20 characters as a password, which may include Latin letters, numbers, and special characters.

### BFD protocol {#bfd}

If a client cannot connect their router directly to the {{ yandex-cloud }} equipment, they can use intermediate network devices (switches). For fast fault detection on the intermediate network devices, use the [BFD protocol](https://en.wikipedia.org/wiki/Bidirectional_Forwarding_Detection).

The BFD protocol is always enabled on the {{ yandex-cloud }} equipment side and has the following parameter values:
* `timer`: 300ms
* `multiplier`: 3

These parameter values are fixed and cannot be changed manually.

On their equipment, the client can configure an appropriate `timer` value when needed. When establishing a BFD session, these parameters will be negotiated over BFD between the client equipment and {{ yandex-cloud }} equipment.

We do not recommend setting a `multiplier` other than 3: this might result in suboptimal protocol performance.
