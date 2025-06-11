# Reserving an on-prem connection via a VPN gateway

You can use a VPN gateway to make your {{ interconnect-name }} connection failsafe. For example, this might be an option when you cannot set up two physical circuits via two points of presence to ensure a fault-tolerant connection of the customer infrastructure to {{ yandex-cloud }}.

![cic-routing-3](../../_assets/interconnect/cic-routing-3.svg)

The customer edge router (R1) uses the `M9` PoP to announce two long prefixes from the customer infrastructure, `10.0.0.0/9` and `10.128.0.0/9`, over BGP towards {{ yandex-cloud }}.

Setting up a backup connection from {{ yandex-cloud }} to the customer infrastructure involves deploying an IPsec VPN gateway in the `{{ region-id }}-b` availability zone and configuring static routing within the VPC.

Cloud resource subnets in all three availability zones share a single route table with the `10.0.0.0/8 via 172.16.2.10` static route (prefix). Since this `/8` route (prefix) is shorter than the `/9` prefixes announced over BGP, it will have a lower priority while the {{ interconnect-name }} connection is running.

If the {{ interconnect-name }} connection fails, the longer (`/9`) prefixes will be removed from the cloud network and the entire traffic towards the customer infrastructure will be automatically routed via the shorter (`/8`) prefix using a static route to the VPN gateway.

