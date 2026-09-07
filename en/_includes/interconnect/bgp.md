## BGP connectivity {#bgp-peering}

BGP connectivity is required to exchange routing information, e.g., subnet prefixes, and is configured within each private or public connection between the customer’s and {{ yandex-cloud }} [point of presence](../../interconnect/concepts/pops.md) equipment. Once the sides exchange information about their subnets, they can route IPv4 traffic between them.

{% note warning %}

{{ yandex-cloud }} equipment has a [limit](../../interconnect/concepts/limits.md#interconnect-limits) on the number of prefixes it can receive from the customer edge router over BGP.
Once this limit has been exceeded, the BGP session will be terminated and restarted in 30 minutes.

For uninterrupted BGP connectivity, we recommend configuring your router to aggregate routing information, which will allow you to minimize the number of prefixes announced over BGP to the {{ yandex-cloud }} equipment.

{% endnote %}

### BGP ASN {#bgp-asn}

To set up BGP connectivity, each side must specify the BGP autonomous system number (ASN) in ASPlain format. The {{ yandex-cloud }} BGP ASN is **{{ cic-bgp-asn }}**.

You are **allowed** to use a public BGP ASN (if you have one) on the customer edge equipment. You are **allowed** to use any value from the following ([RFC 6996](https://datatracker.ietf.org/doc/rfc6996)) private BGP ASN ranges on the customer edge equipment:
* `64512 - 65534`: For 2-byte BGP ASNs.
* `4200000000 - 4294967294`: For 4-byte BGP ASNs.

You are **not allowed** to use the following ([RFC 5398](https://datatracker.ietf.org/doc/rfc5398)) BGP ASN ranges on the customer edge equipment:
* `64496 – 64511`: For 2-byte BGP ASNs.
* `65536 – 65551`: For 4-byte BGP ASNs.

You are **not allowed** to include any BGP ASN from the above ranges in the BGP `AS_Path` attribute on the customer edge equipment.

{% note warning %}

{{ yandex-cloud }} has a 4-byte BGP ASN of **{{ cic-bgp-asn }}**. Many network equipment vendors prefer more common 2-byte ASN format. 

When configuring BGP on your customer edge router, make sure to explicitly allow it to use 4-byte ASNs.

When configuring BGP on your customer edge router, make sure to specify your public BGP ASN for public connections using your public IPv4 addresses.

{% endnote %}

### BGP authentication (optional) {#bgp-auth}

For better BGP connection security, you can use BGP authentication based on `BGP MD5 password`. We recommend using passwords at least 20 characters long, including letters, numbers, and special characters.

### BFD protocol {#bfd}

If you cannot connect your router to the {{ yandex-cloud }} equipment directly, you can use intermediate network devices, e.g., switches. The [BFD protocol](https://en.wikipedia.org/wiki/Bidirectional_Forwarding_Detection) is used to quickly detect faults on the intermediate network devices.

The BFD protocol is always enabled on the {{ yandex-cloud }} equipment with the following settings:
* `timer`: 300ms
* `multiplier`: 3

These values are fixed and cannot be changed manually.

You can configure the `timer` setting on your equipment as needed. When establishing a BFD session, these parameters will be aligned between the customer’s and {{ yandex-cloud }} equipment.

We do not recommend setting `multiplier` to anything other than 3, as this may cause BFD performance issues.

### BGP timers {#timers}

Below you can see the {{ yandex-cloud }} default timer values in seconds:

* `minimum-hold-time` = `90`

Using values less than the specified ones on the customer edge equipment will cause issues with establishing a BGP adjacency.
