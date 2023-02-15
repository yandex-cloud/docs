## BGP connectivity {#bgp-peering}

BGP connectivity is configured within each private or public connection between the client equipment and {{ yandex-cloud }} equipment at the [point of presence](../../interconnect/concepts/pops.md) for exchanging subnet (prefix) data. After exchanging this routing data, the sides can distribute IPv4 traffic across the subnets they communicated to each other.

{% note warning %}

On the {{ yandex-cloud }} equipment side, there is a [limit](../../interconnect/concepts/limits.md#interconnect-limits) on the number of prefixes received from the client router over BGP.
If this limit is exceeded, a BGP session is terminated for 30 minutes.

To maintain continuous BGP connectivity, we recommend setting up policies for routing information aggregation on the client router to minimize the number of prefixes announced over BGP towards the {{ yandex-cloud }} equipment to ensure the reasonable and required sizes.

{% endnote %}

### BGP ASN {#bgp-asn}

To set up BGP connectivity, each side must specify the BGP autonomous system number (ASN). The BGP ASN for {{ yandex-cloud }} is fixed at **200350**.
On the client side, you can set up a public BGP ASN (if any) or use any number from private BGP ASNs in the range between `64512` and `65534`.

{% note warning %}

On the {{ yandex-cloud }} side, a `4-byte` BGP ASN value is used: **200350**. When using network equipment from different vendors, using 2-byte BGP ASN values as the most common ones will be prioritized.

When setting up BGP connectivity on the client router side, explicitly allow using `4-byte` BGP ASN values in its configuration.

{% endnote %}

### BGP authentication (optional) {#bgp-auth}
To increase the security level of a BGP connection, you can use BGP authentication based on the `BGP MD5 password` mechanism. If the feature is enabled, use a string of more than 20 characters as a password, which may include alphanumeric and special characters.

### BFD protocol {#bfd}

If a client cannot connect their router directly to the {{ yandex-cloud }} equipment, they can use intermediate network devices (switches). For fast fault detection on the intermediate network devices, use the [BFD protocol](https://en.wikipedia.org/wiki/Bidirectional_Forwarding_Detection).

The BFD protocol is always enabled on the {{ yandex-cloud }} equipment side and has the following parameter values:
* `timer`: 300ms
* `multiplier`: 3

Technical support can change the `timer` parameter value (by only increasing it) upon request. Changes to the `multiplier` parameter value are not allowed.

