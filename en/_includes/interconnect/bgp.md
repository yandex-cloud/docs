## BGP connectivity {#bgp-peering}

BGP connectivity is configured within each private or public connection between the client equipment and {{ yandex-cloud }} equipment at the [point of presence](../../interconnect/concepts/pops.md) for exchanging subnet (prefix) data. After exchanging this routing data, the sides can distribute IPv4 traffic across the subnets they communicated to each other.

{% note warning %}

On the {{ yandex-cloud }} equipment side, there is a [limit](../../interconnect/concepts/limits.md#interconnect-limits) on the number of prefixes received from the client router over BGP.
Once this limit is exceeded, the BGP session will be terminated for 30 minutes.

To maintain continuous BGP connectivity, we recommend setting up policies for routing information aggregation on the client router that will keep the number of prefixes announced over BGP towards the {{ yandex-cloud }} equipment at a reasonable and required level.

{% endnote %}

### BGP ASN {#bgp-asn}

To set up BGP connectivity, each side must specify the BGP autonomous system number (ASN) in ASPlain format. The BGP ASN value for {{ yandex-cloud }} is fixed at **{{ cic-bgp-asn }}**.

On client equipment, you are **allowed** to use the public BGP ASN (if available). On client equipment, you are **allowed** to use any value from the following [RFC 6996](https://datatracker.ietf.org/doc/rfc6996) ranges of private BGP ASNs:
* `64512 - 65534`: For two-byte BGP ASNs.
* `4200000000 - 4294967294`: For four-byte BGP ASNs.

On client equipment, you are **not allowed** to use the following [RFC 5398](https://datatracker.ietf.org/doc/rfc5398) ranges of BGP ASNs:
* `64496 – 64511`: For two-byte BGP ASNs.
* `65536 – 65551`: For four-byte BGP ASNs.

On client equipment, you are **not allowed** to include any BGP ASN from the above ranges in the BGP `AS_Path` attribute.

{% note warning %}

On the {{ yandex-cloud }} side, a 4-byte BGP ASN value, **{{ cic-bgp-asn }}**, is used. When using network equipment from different vendors, 2-byte BGP ASNs are often preferred as the most common option.

When setting up BGP connectivity on the client router side, make sure to explicitly allow 4-byte BGP ASNs in its configuration.

When setting up BGP interaction on the client router, for public connections on public IPv4 addresses owned by the client, make sure to specify the client's public BGP ASN.

{% endnote %}



### BGP authentication (optional) {#bgp-auth}

To increase security of a BGP connection, you can use BGP authentication based on `BGP MD5 password`. If you enable this feature, use a string of more than 20 characters as a password, which may include Latin letters, numbers, and special characters.

### BFD protocol {#bfd}

If a client cannot connect their router directly to the {{ yandex-cloud }} equipment, they can use intermediate network devices (switches). For fast fault detection on the intermediate network devices, use the [BFD protocol](https://en.wikipedia.org/wiki/Bidirectional_Forwarding_Detection).

The BFD protocol is always enabled on the {{ yandex-cloud }} equipment side and has the following parameter values:
* `timer`: 300ms
* `multiplier`: 3

These values are fixed and cannot be changed manually.

The client can configure the `timer` value on their equipment as needed. When establishing a BFD session, these parameters will be aligned over BFD between the client and {{ yandex-cloud }} equipment.

We do not recommend setting `multiplier` to anything other than 3, as this may cause BFD performance issues.
