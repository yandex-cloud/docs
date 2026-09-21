# Configuring {{ interconnect-name }} access to cloud networks behind NGFWs

In this tutorial, we will create a secure high-availability {{ yandex-cloud }} network infrastructure using a next-generation firewall (NGFW) to segment it into security zones. Each network segment will contain single-purpose resources isolated from others. For example, we will place public-facing services, e.g., frontend applications, in the [DMZ](https://en.wikipedia.org/wiki/DMZ_(computing)) segment and backend applications in the `Application` segment. Each segment will have its own cloud folder and a dedicated {{ vpc-short-name }} [cloud network](../../vpc/concepts/network.md#network). To connect these segments, we will use Next-Generation Firewall VMs deployed in two [availability zones](../../overview/concepts/geo-scope.md) to ensure fault tolerance.

In {{ yandex-cloud }} tutorials, you can find the following NGFW-based implementations of a fault-tolerant network infrastructure:

* [UserGate](../../tutorials/routing/high-accessible-dmz-usergate.md)
* [Check Point](../../tutorials/routing/high-accessible-dmz.md)

To establish IP network connectivity between resources in your infrastructure and cloud resources in {{ yandex-cloud }}, you can use [{{ interconnect-full-name }}](../../interconnect/concepts/index.md).

In this tutorial, you will set up [routing](../../vpc/concepts/routing.md) for your cloud network and configure a {{ interconnect-name }} [private connection](../../interconnect/concepts/priv-con.md) to enable network connectivity between your on-premise infrastructure and segments hosted behind the NGFW.

You can see the solution architecture in the diagram below.


| Name                            | Description                                                                                                                                   |
|-------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| FW-A                                | Primary NGFW in zone A                                                                                                                     |
| FW-B                                | Standby NGFW in zone B                                                                                                                    |
| {{ vpc-short-name }} `interconnect` | {{ vpc-short-name }} to connect your infrastructure using {{ interconnect-name }}                                  |
| {{ vpc-short-name }} `dmz`          | {{ vpc-short-name }} hosting frontend internet-facing applications                                                             |
| {{ vpc-short-name }} `app`          | {{ vpc-short-name }} hosting backend applications                                                                                      |
| `A.A.A.0/24`                        | `interconnect` {{ vpc-short-name }} subnet hosting `FW-A`                                                                 |
| `B.B.B.0/24`                        | `interconnect` {{ vpc-short-name }} subnet hosting `FW-B`                                                                 |
| `C.C.0.0/16`                        | Aggregated prefix of the `dmz` {{ vpc-short-name }} subnets you want to access from your on-premise infrastructure |
| `D.D.0.0/16`                        | Aggregated prefix of the `app` {{ vpc-short-name }} subnets you want to access from your on-premise infrastructure |


## Traffic routing from your on-premise infrastructure to the {{ vpc-short-name }}-hosted `dmz` and `app` resources {#routing-description}

If the [prerequisites](#necessary-conditions) are met and your cloud route tables and {{ interconnect-name }} are configured according to steps below:

* Your on-premise infrastructure traffic will arrive at the primary NGFW that will route it to the relevant {{ vpc-short-name }}: `dmz` or `app`.
* If the primary NGFW fails, the [`route-switcher` module](https://github.com/yandex-cloud-examples/yc-route-switcher) will redirect the traffic arriving at the primary zone to the standby NGFW in the different availability zone.
* If the availability zone with the primary NGFW fails, the [`route-switcher` module](https://github.com/yandex-cloud-examples/yc-route-switcher) will redirect traffic to a standby NGFW that will further route it to the relevant {{ vpc-short-name }}: `dmz` or `app`.

## Prerequisites {#necessary-conditions}

1. Use [`route-switcher`](https://github.com/yandex-cloud-examples/yc-route-switcher) to switch `interconnect`, `dmz`, and `app` {{ vpc-short-name }}-directed traffic from the primary to the standby NGFW if the first one fails. You can read about `route-switcher` in the [UserGate NGFW](../../tutorials/routing/high-accessible-dmz-usergate) and [Check Point NGFW](../../tutorials/routing/high-accessible-dmz.md) tutorials.
1. Network prefixes in the route tables must not overlap with your on-premises network prefixes.
1. Routes announced from your on-premise infrastructure through {{ interconnect-name }} must not overlap with the address spaces of the `interconnect`, `dmz`, or `app` {{ vpc-short-name }} subnets.
1. IP prefixes added to the virtual router, i.e., `A.A.A.0/24`, `B.B.B.0/24`, `C.C.0.0/16`, and `D.D.0.0/16` in our example, must not overlap.
1. Configure security policies on the NGFW to allow access from {{ vpc-short-name }} `interconnect` to {{ vpc-short-name }} `dmz` and `app` as per your organization's security requirements.
1. Add routes to the networks used in your on-premises infrastructure to the routing tables for the `dmz` and `app` {{ vpc-short-name }} subnets. A common practice is to use the default route, `0.0.0.0/0`. For these routes, specify the IP address of the primary NGFW in the appropriate {{ vpc-short-name }} `dmz` or `app` as `Next hop`.
1. Configure static routes on the NGFW to the networks used in your infrastructure. For these routes, specify the gateway address (the first address in the subnet range, e.g., `x.x.x.1` for the x.x.x.0/24 subnet) from the cloud subnet of the NGFW interface in {{ vpc-short-name }} `interconnect` as `Next hop`.
1. We recommend you to plan your `dmz` and `app` {{ vpc-short-name }} network address space the way you can use aggregated prefixes. In our example, it is `C.C.0.0/16` and `D.D.0.0/16`. With aggregated prefixes, you will only need to configure {{ vpc-short-name }} `interconnect` route tables and prefix announcements in the virtual router once. When adding new subnets to {{ vpc-short-name }} `dmz` and `app`, you will not need to change these settings.

## Configuring `interconnect` {{ vpc-short-name }} route tables {#configure-route-tables}

Configure [route tables](../../vpc/concepts/routing.md#rt-vpc) in the `interconnect` {{ vpc-short-name }} according to the tables below and apply them to the primary and standby NGFW-hosting subnets.

Create a route table containing more specific routes (with a network prefix `/17`) to the `dmz` and `app` {{ vpc-short-name }} subnets and apply it to the primary NGFW-hosting subnet, i.e., `A.A.A.0/24` in zone A. Remember to add prefixes from that table to the [announcement settings](#create-private-connections-cic) of the virtual router for the primary NGFW's availability zone.

| Destination prefix | Next hop                                            |
|--------------------|-----------------------------------------------------|
| `C.C.0.0/17`       | `FW-A` IP address in the `interconnect` {{ vpc-short-name }} |
| `C.C.128.0/17`     | `FW-A` IP address in the `interconnect` {{ vpc-short-name }} |
| `D.D.0.0/17`       | `FW-A` IP address in the `interconnect` {{ vpc-short-name }} |
| `D.D.128.0/17`     | `FW-A` IP address in the `interconnect` {{ vpc-short-name }} |


Create a route table containing less specific routes (with a network prefix `/16`) to the `dmz` and `app` {{ vpc-short-name }} subnets and apply it to the standby NGFW-hosting subnet, i.e., `B.B.B.0/24` in zone B. Remember to add prefixes from that table to the [announcement settings](#create-private-connections-cic) of the virtual router for the standby NGFW's availability zone.

| Destination prefix | Next hop                                            |
|--------------------|-----------------------------------------------------|
| `C.C.0.0/16`       | `FW-B` IP address in {{ vpc-short-name }} `interconnect` |
| `D.D.0.0/16`       | `FW-B` IP address in {{ vpc-short-name }} `interconnect` |

These settings ensure that traffic to the `dmz` and `app` {{ vpc-short-name }} subnets is routed to the primary NGFW. If the primary NGFW fails, the [`route-switcher`](https://github.com/yandex-cloud-examples/yc-route-switcher) will redirect traffic to the standby NGFW.

By using more or less specific route table prefixes, you can configure the virtual router announcements so that your on-premise infrastructure traffic bound for the {{ vpc-short-name }} `dmz` and `app` subnets goes to the primary NGFW's availability zone and, if that one fails, is redirected to the standby NGFW's availability zone.

## Configure {{ interconnect-name }} and a virtual router {#create-private-connections-cic}

You can find the {{ interconnect-name }} deployment options in the [documentation](../../interconnect/concepts/index.md). For a fault-tolerant connection to the service, we recommend creating multiple trunks, one per [point of presence](../../interconnect/concepts/pops.md).

1. [Create trunks](../../interconnect/operations/trunk-create.md) and organize their physical connection. If trunks have already been created, use the existing ones.
1. In each trunk, [create a private connection](../../interconnect/operations/priv-con-create.md).
1. [Create a virtual router](../../cloud-router/operations/ri-create.md) or select an existing one.
1. [Add private connections](../../cloud-router/operations/ri-priv-con-add.md) to your virtual router.
1. [Add](../../cloud-router/operations/ri-prefixes-upsert.md#add-network) an `interconnect` network to your virtual router and specify the following IP prefixes:

   Availability zone | IP prefixes
   --- | ---
   `{{ region-id }}-a` | `A.A.A.0/24`, `C.C.0.0/17`, `C.C.128.0/17`, `D.D.0.0/17`, `D.D.128.0/17`
   `{{ region-id }}-b` | `B.B.B.0/24`, `C.C.0.0/16`, `D.D.0.0/16`

`/17` prefixes route traffic to the zone with the primary NGFW. If this zone becomes unavailable, more specific prefixes stop being announced and traffic is routed through `/16` prefixes to the zone with the standby NGFW.

Check the status of BGP sessions for private connections through [monitoring](../../interconnect/concepts/monitoring.md#private-mon).

If you are creating new subnets on an already announced aggregate prefix, you do not need to change the virtual router settings. To announce a prefix outside of the configured aggregate, [update the IP prefixes](../../cloud-router/operations/ri-prefixes-upsert.md#update-prefixes) on your own.
