# Configuring {{ interconnect-name }} access to cloud networks behind NGFWs

In this tutorial, we will create a secure high-availability {{ yandex-cloud }} network infrastructure using a next-generation firewall (NGFW) to segment it into security zones. Each network segment will contain single-purpose resources isolated from others. For example, we will place public-facing services, e.g., frontend applications, in the [DMZ](https://en.wikipedia.org/wiki/DMZ_(computing)) segment and backend applications in the `Application` segment. Each segment will have its own cloud folder and a dedicated {{ vpc-short-name }} [cloud network](../../vpc/concepts/network#network). To connect these segments, we will use Next-Generation Firewall VMs deployed in two [availability zones](../../overview/concepts/geo-scope.md) to ensure fault tolerance.

In {{ yandex-cloud }} tutorials, you can find the following NGFW-based implementations of a fault-tolerant network infrastructure:

* [UserGate](../../tutorials/routing/high-accessible-dmz-usergate)
* [Check Point](../../tutorials/routing/high-accessible-dmz)

To establish IP network connectivity between your on-premise resources and {{ yandex-cloud }} resources, you can use [{{ interconnect-full-name }}](../../interconnect/concepts/).

In this tutorial, you will set up [routing](../../vpc/concepts/routing) for your cloud network and configure a {{ interconnect-name }} [private connection](../../interconnect/concepts/priv-con) to enable network connectivity between your on-premise infrastructure and the segments hosted behind the NGFW.

You can see this solution in the diagram below.


| Name                            | Description                                                                                                                                   |
|-------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| FW-A                                | Primary NGFW in zone A                                                                                                                     |
| FW-B                                | Standby NGFW in zone B                                                                                                                    |
| {{ vpc-short-name }} `interconnect` | {{ vpc-short-name }} connecting your on-premise infrastructure over {{ interconnect-name }}                                  |
| {{ vpc-short-name }} `dmz`          | {{ vpc-short-name }} hosting frontend internet-facing applications                                                             |
| {{ vpc-short-name }} `app`          | {{ vpc-short-name }} hosting backend applications                                                                                      |
| `A.A.A.0/24`                        | `interconnect` {{ vpc-short-name }} subnet hosting `FW-A`                                                                 |
| `B.B.B.0/24`                        | `interconnect` {{ vpc-short-name }} subnet hosting `FW-B`                                                                 |
| `C.C.0.0/16`                        | Aggregated prefix of the `dmz` {{ vpc-short-name }} subnets you want to access from your on-premise infrastructure |
| `D.D.0.0/16`                        | Aggregated prefix of the `app` {{ vpc-short-name }} subnets you want to access from your on-premise infrastructure |


## Traffic routing from your on-premise infrastructure to the `dmz` and `app` {{ vpc-short-name }}-hosted resources {#routing-description}

If the [prerequisites](#necessary-conditions) are met and your cloud route tables and {{ interconnect-name }} are configured according to steps below:
* Your on-premise infrastructure traffic will arrive at the primary NGFW that will route it to the relevant {{ vpc-short-name }}: `dmz` or `app`.
* If the primary NGFW fails, the [`route-switcher` module](https://github.com/yandex-cloud-examples/yc-route-switcher) will redirect the traffic arriving at the primary zone to the standby NGFW in the different availability zone.
* If the availability zone with the primary NGFW fails, the [`route-switcher`](https://github.com/yandex-cloud-examples/yc-route-switcher) module will redirect traffic to the standby NGFW that will further route it to the relevant {{ vpc-short-name }}: `dmz` or `app`.

## Prerequisites {#necessary-conditions}

1. Use [`route-switcher`](https://github.com/yandex-cloud-examples/yc-route-switcher) to switch `interconnect`, `dmz`, and `app` {{ vpc-short-name }}-directed traffic from the primary to the standby NGFW if the first one fails. You can read about `route-switcher` in the [UserGate NGFW](../../tutorials/routing/high-accessible-dmz-usergate) and [Check Point NGFW](../../tutorials/routing/high-accessible-dmz) tutorials.
1. Network prefixes in the route tables must not overlap your on-premises network prefixes.
1. Routes announced from the on-premise infrastructure through {{ interconnect-name }} must not overlap with the address spaces of the `interconnect`, `dmz`, or `app` {{ vpc-short-name }} subnets.
1. Prefixes in the {{ interconnect-name }} private connection announcements, i.e., `A.A.A.0/24`, `B.B.B.0/24`, `C.C.0.0/16`, and `D.D.0.0/16` in our example, must not overlap.
1. The NGFW must have security policies allowing access from the `interconnect` {{ vpc-short-name }} to the `dmz` and `app` {{ vpc-short-name }}, based on your organization’s security requirements.
1. Route tables for the `dmz` and `app` {{ vpc-short-name }} subnets must include routes to your on-premise infrastructure networks. A common practice is to use the default route, `0.0.0.0/0`. These routes must use the primary NGFW for `Next hop`.
1. The NGFW must have static routes to your on-premise infrastructure networks. For `Next hop`, these routes must use the gateway address, which is the first address in the `interconnect` {{ vpc-short-name }} NGFW-hosting subnet, e.g., `x.x.x.1` for the `x.x.x.x.0/24` subnet.
1. We recommend you to plan your `dmz` and `app` {{ vpc-short-name }} network address space the way you can use aggregated prefixes. In our example, it is `C.C.0.0/16` and `D.D.0.0/16`. With aggregated prefixes, you will only need to configure `interconnect` {{ vpc-short-name }} route tables and prefix announcements in private {{ interconnect-name }} connections once. You will not have to change them when adding new subnets to the `dmz` and `app` {{ vpc-short-name }}.

## Configuring `interconnect` {{ vpc-short-name }} route tables {#configure-route-tables}

Configure [route tables](../../vpc/concepts/routing#rt-vpc) in the `interconnect` {{ vpc-short-name }} according to the tables below and apply them to the primary and standby NGFW-hosting subnets.

Create a route table containing more specific routes (with a network prefix `/17`) to the `dmz` and `app` {{ vpc-short-name }} subnets and apply it to the primary NGFW-hosting subnet, i.e., `A.A.A.0/24` in zone A. Remember to add prefixes from that table to the [announcement settings](#create-private-connections-cic) for private connections of the primary NGFW availability zone.

| Destination prefix | Next hop                                            |
|--------------------|-----------------------------------------------------|
| `C.C.0.0/17`       | `FW-A` IP address in the `interconnect` {{ vpc-short-name }} |
| `C.C.128.0/17`     | `FW-A` IP address in the `interconnect` {{ vpc-short-name }} |
| `D.D.0.0/17`       | `FW-A` IP address in the `interconnect` {{ vpc-short-name }} |
| `D.D.128.0/17`     | `FW-A` IP address in the `interconnect` {{ vpc-short-name }} |


Create a route table containing less specific routes (with a network prefix `/16`) to the `dmz` and `app` {{ vpc-short-name }} subnets and apply it to the standby NGFW-hosting subnet, i.e., `B.B.B.0/24` in zone B. Remember to add prefixes from that table to the [announcement settings](#create-private-connections-cic) for private connections of the standby NGFW availability zone.

| Destination prefix | Next hop                                            |
|--------------------|-----------------------------------------------------|
| `C.C.0.0/16`       | `FW-A` IP address in the `interconnect` {{ vpc-short-name }} |
| `D.D.0.0/16`       | `FW-A` IP address in the `interconnect` {{ vpc-short-name }} |

These settings ensure that traffic to the `dmz` and `app` {{ vpc-short-name }} subnets is routed to the primary NGFW. If the primary NGFW fails, the [`route-switcher`](https://github.com/yandex-cloud-examples/yc-route-switcher) will redirect traffic to the standby NGFW.

By using more specific or less specific route table prefixes, you can configure the {{ interconnect-name }} private connection announcements so that your on-premise infrastructure traffic bound for the `dmz` and `app` {{ vpc-short-name }} subnets goes to the primary NGFW availability zone and, if that one fails, it is redirected to the standby NGFW availability zone.

## Creating private {{ interconnect-name }} connections {#create-private-connections-cic}

You can find the {{ interconnect-name }} deployment options in the [documentation](../../interconnect/concepts/). For a fault-tolerant connection to the service, we recommend setting up multiple trunks, one per [point of presence](../../interconnect/concepts/pops).

Follow [this guide](../../interconnect/operations/) to set up a private connection depending on how you connect to {{ interconnect-name }}.

When submitting a ticket to {{ yandex-cloud }} support, specify the following for each private connection in your subnet announcements for availability zones:

   1. For the primary NGFW availability zone:
      * Prefixes from the route table applied to the `interconnect` {{ vpc-short-name }} primary NGFW-hosting subnet. In our example, these are more specific `/17` prefixes for the `ru-central1-a` zone. These announcements will ensure that your on-premise traffic bound for the `dmz` and `app` {{ vpc-short-name }} subnets will go to the primary NGFW availability zone.
      * Prefix of the `interconnect` {{ vpc-short-name }} primary NGFW-hosting subnet, along with other `interconnect` {{ vpc-short-name }} subnet prefixes in the same zone that you need to announce into your on-premise infrastructure.
   1. For the standby NGFW availability zone:
      * Prefixes from the route table applied to the `interconnect` {{ vpc-short-name }} standby NGFW-hosting subnet. In our example, these are less specific `/16` prefixes for the `ru-central1-b` zone. These announcements will ensure that your on-premise traffic bound for the `dmz` and `app` {{ vpc-short-name }} subnets will go to the standby NGFW availability zone if the primary zone fails.
      * Prefix of the `interconnect` {{ vpc-short-name }} standby NGFW-hosting subnet, along with other `interconnect` {{ vpc-short-name }} subnet prefixes in the same zone that you need to announce into your on-premise infrastructure.

For our tutorial example, specify the following details under `vpc`:

```yaml
vpc: 
  vpc_net_id: <{{ vpc-short-name }}_interconnect_ID> 
    vpc_subnets:
      ru-central1-a: [A.A.A.0/24, C.C.0.0/17, C.C.128.0/17, D.D.0.0/17, D.D.128.0/17]
      ru-central1-b: [B.B.B.0/24, C.C.0.0/16, D.D.0.0/16]
```