# Configuring {{ interconnect-name }} access to cloud networks behind NGFWs

In {{ yandex-cloud }}, you can deploy a secure high-availability network infrastructure based on the Next-Generation Firewall (NGFW) technology, i.e. segmented into security zones. Each network segment (hereinafter, simply _segment_) contains single-purpose resources, isolated from other resources. For example, the [DMZ](https://en.wikipedia.org/wiki/DMZ_(computing)) segment is where public-facing services (such as frontend apps) reside, whereas the application segment hosts backend apps. Each segment in a cloud has its own folder and a dedicated {{ vpc-short-name }} [cloud network](../../vpc/concepts/network#network). Segments connect to each other via Next-Generation Firewall VM instances deployed in two [availability zones](../../overview/concepts/geo-scope.md) to ensure fault tolerance.

{{ yandex-cloud }} tutorials discuss the following NGFW-based fault-tolerant network infrastructure implementation scenarios:

* [UserGate](../../tutorials/routing/high-accessible-dmz-usergate)
* [Check Point](../../tutorials/routing/high-accessible-dmz)

To set up IP network connectivity between resources in the customer's on-premise infrastructure and cloud resources in {{ yandex-cloud }}, use [{{ interconnect-full-name }}](../../interconnect/concepts/).

This document covers the cloud network [routing](../../vpc/concepts/routing) settings and {{ interconnect-name }} [private connection](../../interconnect/concepts/priv-con) settings to enable network connectivity between the customer's infrastructure and segments behind the NGFW.

| Name                            | Description                                                                                                                                   |
|-------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| FW-A                                | Primary NGFW in zone A                                                                                                                     |
| FW-B                                | Standby NGFW in zone B                                                                                                                    |
| {{ vpc-short-name }} `interconnect` | {{ vpc-short-name }} for connection to the customer's on-premise infrastructure over {{ interconnect-name }}                                  |
| {{ vpc-short-name }} `dmz`          | {{ vpc-short-name }} to host frontend applications available from the internet                                                             |
| {{ vpc-short-name }} `app`          | {{ vpc-short-name }} to host backend applications                                                                                      |
| `A.A.A.0/24`                        | Subnet for the FW-A network interface in the `interconnect` {{ vpc-short-name }}                                                                 |
| `B.B.B.0/24`                        | Subnet for the FW-B network interface in the `interconnect` {{ vpc-short-name }}                                                                 |
| `C.C.0.0/16`                        | Aggregated prefix of the `dmz` {{ vpc-short-name }} subnets you need to make available from the customer's on-premise infrastructure |
| `D.D.0.0/16`                        | Aggregated prefix of the `app` {{ vpc-short-name }} subnets you need to make available from the customer's on-premise infrastructure |


## Description of traffic routing from the customer's infrastructure to resources in the `dmz` and `app` {{ vpc-short-name }} {#routing-description}

If the [prerequisites](#necessary-conditions) are met and your cloud route tables and {{ interconnect-name }} are set up as shown below:
* Traffic from the customer's infrastructure will be routed to the primary NGFW zone, and from there to the relevant {{ vpc-short-name }}: `dmz` or `app`.
* If the primary NGFW fails, traffic will still be routed to the primary NGFW zone, and from there to the standby NGFW in the neighboring zone (provided that the [`route-switcher` module](https://github.com/yandex-cloud-examples/yc-route-switcher) is on).
* If the primary NGFW zone fails, traffic will be routed to the standby NGFW zone (provided the [`route-switcher` module](https://github.com/yandex-cloud-examples/yc-route-switcher) is on), and from there to the relevant {{ vpc-short-name }}: `dmz` or `app`.

## Prerequisites {#necessary-conditions}

1. Employ the [`route-switcher` module](https://github.com/yandex-cloud-examples/yc-route-switcher) to switch traffic in the `interconnect`, `dmz`, and `app` {{ vpc-short-name }} to the standby NGFW if the primary one fails. `route-switcher` is featured in [UserGate NGFW](../../tutorials/routing/high-accessible-dmz-usergate) or [Check Point NGFW](../../tutorials/routing/high-accessible-dmz)-based tutorials.
1. The configured route tables must not have any overlapping prefixes with networks used in the customer's on-premise infrastructure.
1. Routes announced from the customer's on-premise infrastructure through {{ interconnect-name }} must not overlap with the address spaces of the `interconnect`, `dmz`, and `app` {{ vpc-short-name }} subnets.
1. Prefixes in the {{ interconnect-name }} private connection announcements (in the example, they are `A.A.A.0/24`, `B.B.B.0/24`, `C.C.0.0/16`, and `D.D.0.0/16`) must not overlap.
1. NGFW must have security policies in place to allow access from the `interconnect` {{ vpc-short-name }} to the `dmz` and `app` {{ vpc-short-name }}, subject to the customer's information security service requirements.
1. Route tables for subnets in the `dmz` and `app` {{ vpc-short-name }} must contain routes to the networks used in the customer's on-premise infrastructure. The default route, `0.0.0.0/0`, is normally used. For `Next hop`, these routes must use the IP address of the primary NGFW in the corresponding {{ vpc-short-name }}: `dmz` or `app`.
1. The NGFW must have static routes configured to networks used in the customer's on-premise infrastructure. For `Next hop`, thee routes must use the gateway address (the first address in the subnet range, e.g., `x.x.x.1` for the `x.x.x.x.0/24` subnet) from the cloud subnet of the NGFW interface in the `interconnect` {{ vpc-short-name }}.
1. We recommended that you plan your address plans in the `dmz` and `app` {{ vpc-short-name }} so that aggregated prefixes (aggregates) can be used. Aggregates (in the example, these are `С.С.0.0/16` and `D.D.0.0/16`) allow you to configure route tables in the `interconnect` {{ vpc-short-name }} and prefix announcements in private {{ interconnect-name }} connections once and for all. You will no longer have to edit route tables in the `interconnect` {{ vpc-short-name }} when adding new subnets to the `dmz` and `app`{{ vpc-short-name }}, nor open support tickets to have announcements added to {{ interconnect-name }}.

## Configure route tables in the interconnect {{ vpc-short-name }} {#configure-route-tables}

Configure [route tables](../../vpc/concepts/routing#rt-vpc) in the `interconnect` {{ vpc-short-name }} and apply them to the subnets hosting the network interfaces of the primary and standby NGFWs, according to the tables below.

To the subnet in the primary NGFW zone (`A.A.A.0/24` in zone A), apply a route table containing more specific routes (those with the `/17` prefixes in the example) to the subnets in the `dmz` and `app` {{ vpc-short-name }}. Remember to add prefixes from that table to the [announcement settings](#create-private-connections-cic) for private connections of the primary NGFW availability zone.

| Destination prefix | Next hop                                            |
|--------------------|-----------------------------------------------------|
| `С.С.0.0/17`       | FW-A IP address in the `interconnect` {{ vpc-short-name }} |
| `С.С.128.0/17`     | FW-A IP address in the `interconnect` {{ vpc-short-name }} |
| `D.D.0.0/17`       | FW-A IP address in the `interconnect` {{ vpc-short-name }} |
| `D.D.128.0/17`     | FW-A IP address in the `interconnect` {{ vpc-short-name }} |


To the subnet in the standby NGFW zone (`B.B.B.0/24` in zone B), apply a route table containing less specific routes (those with the `/16` prefixes in the example) to the subnets in the `dmz` and `app` {{ vpc-short-name }}. Remember to add prefixes from that table to the [announcement settings](#create-private-connections-cic) for private connections of the standby NGFW availability zone.

| Destination prefix | Next hop                                            |
|--------------------|-----------------------------------------------------|
| `С.С.0.0/16`       | FW-A IP address in the `interconnect` {{ vpc-short-name }} |
| `D.D.0.0/16`       | FW-A IP address in the `interconnect` {{ vpc-short-name }} |

The above settings ensure that traffic to subnets in the `dmz` and `app` {{ vpc-short-name }} is routed to the primary NGFW. Provided that the [`route-switcher`](https://github.com/yandex-cloud-examples/yc-route-switcher) module is on, traffic will be routed to the standby NGFW should the primary one fail.

By using more specific or less specific route tables prefixes, you can configure the {{ interconnect-name }} private connection announcements so that the customer's infrastructure traffic bound for the `dmz` and `app` {{ vpc-short-name }} subnets first goes to the zone with the primary NGFW and, if that one fails, is redirected to the zone with the standby NGFW.

## Create private {{ interconnect-name }} connections {#create-private-connections-cic}

Read about {{ interconnect-name }} deployment options in the [documentation](../../interconnect/concepts/). For a fault tolerant connection to the service, several trunks are recommended – one per [point of presence](../../interconnect/concepts/pops).

Follow [this guide](../../interconnect/operations/) to set up a private connection based on how you connect to {{ interconnect-name }}.

When filing a ticket to {{ yandex-cloud }} support, specify the following for each private connection in your subnet announcements for availability zones:

   1. For the availability zone hosting the primary NGFW:
      * Prefixes from the route table applied to the primary NGFW subnet in the `interconnect` {{ vpc-short-name }}. In the example for the `ru-central1-a` zone, these are the more specific prefixes, i.e., `/17`. Thanks to these announcements, the customer's infrastructure traffic bound for the `dmz` and `app` {{ vpc-short-name }} subnets will be routed to the zone with the primary NGFW.
      * Subnet prefix for the primary NGFW network interface in the `interconnect` {{ vpc-short-name }} and other subnet prefixes from the `interconnect` {{ vpc-short-name }} in this zone that you need to announce into the customer's on-premise infrastructure.
   1. For the availability zone hosting the standby NGFW:
      * Prefixes from the route table applied to the standby NGFW subnet in the `interconnect` {{ vpc-short-name }}. In the example for the `ru-central1-b` zone, these are the less specific prefixes, i.e., `/16`. Thanks to these announcements, if the zone with the primary NGFW fails, the customer's infrastructure traffic bound for the `dmz` and `app` {{ vpc-short-name }} subnets will be routed to the zone with the standby NGFW.
      * Subnet prefix for the standby NGFW network interface in the `interconnect` {{ vpc-short-name }} and other subnet prefixes from the `interconnect` {{ vpc-short-name }} in this zone that you need to announce into the customer's on-premise infrastructure.

For the example outlined in this document, specify the following details under `vpc`:

```yaml
vpc: 
  vpc_net_id: <`interconnect` {{ vpc-short-name }} ID> 
    vpc_subnets:
      ru-central1-a: [A.A.A.0/24, C.C.0.0/17, C.C.128.0/17, D.D.0.0/17, D.D.128.0/17]
      ru-central1-b: [B.B.B.0/24, C.C.0.0/16, D.D.0.0/16]
```