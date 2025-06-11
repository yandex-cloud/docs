# Prioritizing traffic by direction for route 0.0.0.0/0

To prioritize traffic by direction in {{ interconnect-name }}, you can use the following methods:

* [Longest Prefix Match (LPM)](#lpm1)
* [BGP AS path prepend](#prepend1) (available as of 03/07/2023)

The longest prefix match method has a higher priority than BGP AS path prepending when it comes to the algorithm for selecting the best route on routers.{#lpm1} We recommend that you only choose one of the suggested methods rather than use both at the same time.

## Longest prefix match (LPM) {#lpm2}

Below, you can see an example of prioritizing traffic through two private connections set up via two points of presence.

The customer edge router (R2) uses the `NORD` PoP to announce the default route from the customer infrastructure, `0.0.0.0/0`, over BGP towards {{ yandex-cloud }}.

Another customer edge router (R1) uses the `M9` PoP to announce two long (more specific) prefixes from the customer infrastructure, `0.0.0.0/1` and `128.0.0.0/1`, over BGP towards {{ yandex-cloud }}.

![cic-routing-6](../../_assets/interconnect/cic-routing-6.svg)

{{ yandex-cloud }} will treat announcements via `M9` as more specific ones, i.e., of higher priority.

This way, all traffic from the cloud subnets will be routed through the private connection to `M9`. If this connection fails, the traffic will automatically failover to the private connection to `NORD`.


## BGP AS path prepend {#prepend2}

Below, you can see an example of prioritizing traffic through two private connections set up via two points of presence with the BGP AS path prepend method.

You can learn more about BGP AS path prepending [here](https://datatracker.ietf.org/doc/html/rfc4271#section-5.1.2).

The customer edge router (R1) uses the `M9` PoP to announce the default route from the customer infrastructure, `0.0.0.0/0`, over BGP towards {{ yandex-cloud }}. The BGP `AS_PATH` attribute will default to `65001`, and the AS path length (count of autonomous system number values) will be 1.

Another customer edge router (R2) announces the same prefix (`0.0.0.0/0`) from the customer infrastructure over BGP through the `NORD` PoP towards {{ yandex-cloud }}.

Before announcing the prefix, the BGP routing policy on the R2 router adds the customer's autonomous system number (BGP ASN) to the `AS_PATH` attribute value so that it will be equal to `65001 65001` and the AS path length will be 2. This makes the prefix with such AS path length less preferable for external BGP routers.

![cic-routing-7](../../_assets/interconnect/cic-routing-8.svg)

This way, for the `0.0.0.0/0` traffic, {{ yandex-cloud }} will select the best route via the `M9` PoP, while the route via the `NORD` PoP will act as a failover due to its longer AS path.

All traffic from the cloud subnets to the customer infrastructure will be routed through the private connection to `M9`. If this connection fails, the traffic will automatically failover to the private connection to `NORD`.

