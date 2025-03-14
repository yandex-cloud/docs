---
title: Traffic routing between cloud resources and customer on-premise infrastructure resources
description: In this article, you will learn about the routing concept and best practices, load balancing, direction-based traffic prioritization, VPN gateway traffic failover, static route priority, default route (`0.0.0.0/0`) load balancing and prioritization, and working with security groups.
---

# Routing

Connecting a customer infrastructure via {{ interconnect-full-name }} usually requires setting up traffic routing between cloud-based and on-premise resources.

By **routing**, we mean tools to manage traffic in {{ yandex-cloud }}.

## Best practices for routing in {{ interconnect-name }} {#cic-routing}

* Prior to deploying cloud resources, make sure you have a well-planned IP addressing scheme. Subnet IP address ranges in {{ yandex-cloud }} must not overlap with those in the on-premise infrastructure.
* Always set up two communication circuits through two [points of presence](pops.md).

* To simplify the setup of fault-tolerant BGP routing, we recommend using the same [BGP ASN](priv-con.md#bgp-asn) for multiple customer edge routers connecting to {{ interconnect-name }}. You can use different **BGP ASNs**, e.g., when setting up connections via telecom providers. Keep in mind that {{ yandex-cloud }} is not responsible for configuring the customer and telecom provider network hardware.

* Each customer edge router that establishes [eBGP peering](priv-con.md#bgp-peering) with {{ yandex-cloud }} equipment should also establish **iBGP** peering with other customer edge routers.
* Use prefixes of different lengths for BGP announcements on customer edge routers to distribute outgoing traffic from cloud subnets across communication circuits: 
    * Short prefixes, such as `/8`, have the lowest route priority.
    * Long prefixes, such as `/32`, have the highest route priority.

* When selecting a communication circuit for outgoing traffic from the customer infrastructure to cloud networks, consider using the `Local Preference` BGP attribute on the customer edge router.

* You can use {{ interconnect-name }} along with a [NAT gateway](../../vpc/operations/create-nat-gateway.md) if customer edge routers do not announce the `0.0.0.0/0` default route over BGP to {{ yandex-cloud }}. If customer edge routers do announce the `0.0.0.0/0` default route over BGP to {{ yandex-cloud }}, you cannot use a [NAT gateway](../../vpc/operations/create-nat-gateway.md).

* Currently, {{ yandex-cloud }} does not support routing of outgoing traffic from cloud subnets to the customer infrastructure using [BGP community](https://linkmeup.gitbook.io/sdsm/8.1.-ibgp/3.-atributy-bgp/4.-community/0.-teoriya) attributes.

{% note alert %}

You cannot use matching prefixes in {{ vpc-short-name }} route tables and customer edge router announcements at the same time.

{% endnote %}

## Load balancing (Active-Active) {#cic-routing-aa}

The example below shows load balancing using two private connections set up through two points of presence.

Customer edge routers announce the `10.0.0.0/8` prefix from the customer infrastructure over BGP through two points of presence towards {{ yandex-cloud }}. {{ yandex-cloud }} will then use ECMP load balancing to distribute traffic between those points of presence.

![cic-routing-1](../../_assets/interconnect/cic-routing-1.svg)

Note that this balancing mode can create traffic asymmetry. For example, a request originating from the customer infrastructure to cloud resources could arrive through the `M9` point of presence, while the response will be sent through `NORD`.

While {{ yandex-cloud }} equipment allows and correctly handles traffic asymmetry, specific types of equipment within the customer infrastructure, such as firewalls, may experience issues with asymmetric traffic patterns.

To allow asymmetric traffic from {{ yandex-cloud }}, disable [RPF](https://en.wikipedia.org/wiki/Reverse-path_forwarding) on the network elements handling traffic in the on-premise infrastructure. This will enable you to use all active {{ interconnect-name }} links with a redundant connectivity through two or more points of presence.


## Direction-based traffic prioritization (Active-Standby) {#cic-routing-as}

To prioritize traffic by direction in {{ interconnect-name }}, you can use the following methods:

* [Longest Prefix Match (LPM)](#lpm1)
* [BGP AS-Path Prepend](#prepend1)

The longest prefix match method has a higher priority than BGP AS path prepending when it comes to the algorithm for selecting the best route on routers. We recommend that you only choose one of the suggested methods rather than use both at the same time.

### Longest prefix match (LPM) {#lpm1}

Below, you can see an example of prioritizing traffic through two private connections set up via two points of presence using the longest prefix match method.

The customer edge router (R2) uses the `NORD` PoP to announce the short prefix from the customer infrastructure, `10.0.0.0/8`, over BGP towards {{ yandex-cloud }}.

Another customer edge router (R1) uses the `M9` PoP to announce two long (more specific) prefixes from the customer infrastructure, `10.0.0.0/9` and `10.128.0.0/9`, over BGP towards {{ yandex-cloud }}.

![cic-routing-2](../../_assets/interconnect/cic-routing-2.svg)

{{ yandex-cloud }} will treat announcements via `M9` as more specific ones, i.e., of higher priority.

This way, all traffic from the `172.16.1.0/24`, `172.16.2.0/24`, and `172.16.3.0/24` cloud subnets to the customer infrastructure will be routed through the private connection to `M9`. If this connection fails, the traffic will automatically failover to the private connection to `NORD`.


### BGP AS path prepend {#prepend1}

Below, you can see an example of prioritizing traffic through two private connections set up via two points of presence with the BGP AS path prepend method.

You can learn more about **BGP AS path prepending** [here](https://datatracker.ietf.org/doc/html/rfc4271#section-5.1.2).

The customer edge router (R1) uses the `M9` PoP to announce the `10.0.0.0/8` prefix from the customer infrastructure over BGP towards {{ yandex-cloud }}. The `AS_PATH` attribute will default to `65001`, while the AS path length (amount of autonomous system number values) will be 1.

Another customer edge router (R2) announces the same prefix (`10.0.0.0/8`) from the customer infrastructure over BGP via the `NORD` PoP towards {{ yandex-cloud }}.

Before announcing the prefix, the BGP routing policy on the R2 router adds the customer's autonomous system number (BGP ASN) to the `AS_PATH` attribute value so that it will be equal to `65001 65001` and the AS path length will be 2. This makes the prefix with such AS path length less preferable for external BGP routers.

![cic-routing-7](../../_assets/interconnect/cic-routing-7.svg)

This way, for the `10.0.0.0/8` traffic, {{ yandex-cloud }} will select the best route via the `M9` PoP, while the route via the `NORD` PoP will act as a failover due to its longer AS path.

All traffic from the `172.16.1.0/24`, `172.16.2.0/24` and `172.16.3.0/24` cloud subnets to the customer infrastructure will be routed through the private connection to `M9`. If this connection fails, the traffic will automatically failover to the private connection to `NORD`.

## VPN gateway traffic failover {#cic-routing-vpn}

You can use a VPN gateway to make your {{ interconnect-name }} connection failsafe. For example, this might be an option when you cannot set up two physical circuits via two points of presence to ensure a fault-tolerant connection of your on-premise infrastructure to {{ yandex-cloud }}.

![cic-routing-3](../../_assets/interconnect/cic-routing-3.svg)

The customer edge router (R1) uses the `M9` PoP to announce two long prefixes from the customer infrastructure, `10.0.0.0/9` and `10.128.0.0/9`, over BGP towards {{ yandex-cloud }}.

Setting up a backup connection from {{ yandex-cloud }} to the customer infrastructure involves deploying an IPSEC VPN gateway in the `{{ region-id }}-b` availability zone and configuring static routing within the VPC.

Cloud resource subnets in all three availability zones share a single route table with the `10.0.0.0/8 via 172.16.2.10` static route (prefix). Since this `/8` route (prefix) is shorter than the `/9` prefixes announced over BGP, it will have a lower priority while the {{ interconnect-name }} connection is running.

If the {{ interconnect-name }} connection fails, the longer `/9` prefixes will be removed from the cloud network and the entire traffic towards the customer infrastructure will be automatically routed via the shorter `/8` prefix using a static route to the VPN gateway.


## Static route priority {#cic-routing-static}

The following flowchart shows how to set up traffic routing from a cloud network for a specific prefix via a VPN gateway, while sending all other traffic over a {{ interconnect-name }} connection:

![cic-routing-4](../../_assets/interconnect/cic-routing-4.svg)

The customer edge router uses the `M9` PoP to announce the short prefix from the customer infrastructure, `10.0.0.0/8`, over BGP towards {{ yandex-cloud }}.

The cloud network's static route table is used to set up traffic routing for the long prefix from the customer infrastructure, `10.10.10.0/24`, through a VPN gateway with the `172.16.2.10` IP address, which is deployed in the `{{ region-id }}-b` availability zone.

This way, all traffic from the cloud network to the `10.0.0.0/8` customer infrastructure will be transmitted via the {{ interconnect-name }} connection, while the traffic heading to the `10.10.10.0/24` subnet will run through the VPN gateway.


## `0.0.0.0/0` route load balancing {#cic-routing-default-aa}

In some cases, connecting cloud resources to the internet via the customer infrastructure may require setting up the `0.0.0.0/0` route announcement over BGP towards {{ yandex-cloud }}.

![cic-routing-5](../../_assets/interconnect/cic-routing-5.svg)

The flowchart above shows how the traffic from cloud subnets connected to {{ interconnect-name }} is unconditionally routed to customer edge routers via both points of presence.

[Security groups](../../vpc/concepts/security-groups.md) cannot be assigned to resources outside {{ yandex-cloud }}; therefore, the correct way to filter traffic is to use IPv4 prefixes rather than links to other security groups.
In this case, the customer can configure traffic filtering rules on customer edge routers before sending it to the internet through their own NAT gateway without using the {{ yandex-cloud }} infrastructure.

## Direction-based traffic prioritization for `0.0.0.0/0` {#cic-routing-default-as}

To prioritize traffic by direction in {{ interconnect-name }}, you can use the following methods:

* [Longest Prefix Match (LPM)](#lpm1)
* [BGP AS path prepend](#prepend1) (available as of 03/07/2023)

The longest prefix match method has a higher priority than BGP AS path prepending when it comes to the algorithm for selecting the best route on routers. We recommend that you only choose one of the suggested methods rather than use both at the same time.

### Longest prefix match (LPM) {#lpm2}

Below, you can see an example of prioritizing traffic through two private connections set up via two points of presence.

The customer edge router (R2) uses the `NORD` PoP to announce the default route from the customer infrastructure, `0.0.0.0/0`, over BGP towards {{ yandex-cloud }}.

Another customer edge router (R1) uses the `M9` PoP to announce two long (more specific) prefixes from the customer infrastructure, `0.0.0.0/1` and `128.0.0.0/1`, over BGP towards {{ yandex-cloud }}.

![cic-routing-6](../../_assets/interconnect/cic-routing-6.svg)

{{ yandex-cloud }} will treat announcements via `M9` as more specific ones, i.e., of higher priority.

This way, all traffic from the cloud subnets will be routed through the private connection to `M9`. If this connection fails, the traffic will automatically failover to the private connection to `NORD`.


### BGP AS path prepend {#prepend2}

Below, you can see an example of prioritizing traffic through two private connections set up via two points of presence with the BGP AS path prepend method.

You can learn more about BGP AS path prepending [here](https://datatracker.ietf.org/doc/html/rfc4271#section-5.1.2).

The customer edge router (R1) uses the `M9` PoP to announce the default route from the customer infrastructure, `0.0.0.0/0`, over BGP towards {{ yandex-cloud }}. The `AS_PATH` attribute will default to `65001`, while the AS path length (amount of autonomous system number values) will be 1.

Another customer edge router (R2) announces the same prefix (`0.0.0.0/0`) from the customer infrastructure over BGP through the `NORD` PoP towards {{ yandex-cloud }}.

Before announcing the prefix, the BGP routing policy on the R2 router adds the customer's autonomous system number (BGP ASN) to the `AS_PATH` attribute value so that it will be equal to `65001 65001` and the AS path length will be 2. This makes the prefix with such AS path length less preferable for external BGP routers.

![cic-routing-7](../../_assets/interconnect/cic-routing-8.svg)

This way, for the `0.0.0.0/0` traffic, {{ yandex-cloud }} will select the best route via the `M9` PoP, while the route via the `NORD` PoP will act as a failover due to its longer AS path.

All traffic from the cloud subnets to the customer infrastructure will be routed through the private connection to `M9`. If this connection fails, the traffic will automatically failover to the private connection to `NORD`.

## Working with security groups {#cic-sg}

[Security groups](../../vpc/concepts/security-groups.md) are used to protect {{ yandex-cloud }} resources and cannot be used for filtering traffic outside {{ yandex-cloud }}.

Security group rules should be set up for the prefixes customer edge routers announce to {{ yandex-cloud }}. For example, to allow access from the customer infrastructure to a web application (port 443) deployed in {{ yandex-cloud }}, set up a security group as follows:
```json
ingress {
      protocol       = "TCP"
      port           = 443
      description    = "Allow ingress traffic from Interconnect to Web server"
      v4_cidr_blocks = ["172.16.1.5/32"]
    }
egress {
      protocol       = "ANY"
      description    = "We allow any egress traffic"
      v4_cidr_blocks = ["10.0.0.0/8"]
    }
```

The `Egress` security group rule allows any cloud resources to access customer infrastructure resources on any port without any restriction.

If required, you can use more granular rules to only allow access to specific IP addresses or subnets and ports:

```json
ingress {
      protocol       = "TCP"
      port           = 443
      description    = "Allow ingress traffic from Interconnect to Web server"
      v4_cidr_blocks = ["172.16.1.5/32"]
    }
egress {
      protocol       = "TCP"
      port           = 3389
      description    = "Allow RDP traffic to server behind Interconnect"
      v4_cidr_blocks = ["10.10.10.10/32"]
    }
```


## Use cases {#examples}

* [{#T}](../tutorials/cic-with-ngfw.md)