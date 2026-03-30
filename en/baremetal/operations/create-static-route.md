---
title: How to create a static route in a {{ baremetal-full-name }} VRF
description: Follow this guide to set up a static route in a {{ baremetal-full-name }} VRF.
---

# Creating a static route

In a {{ baremetal-full-name }} private network, you can create [static routes](../concepts/private-network.md#static-routes) for network traffic.

{% include [static-routes-to-vpc-ri-notice2](../../_includes/baremetal/static-routes-to-vpc-ri-notice2.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your [virtual network segment (VRF)](../concepts/private-network.md#vrf-segment).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![vector-square](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** and in the list that opens, select the VRF you want to create a static route in. In the window that opens:

      1. In the top-right corner, click ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
      1. Under **{{ ui-key.yacloud.baremetal.vrfs.VrfForm.title_section-vrf-static-routes_4KS9m }}**, click **{{ ui-key.yacloud.baremetal.vrfs.AddStaticRoute.label_add-static-route_wY5KQ }}**.
      1. In the **{{ ui-key.yacloud.baremetal.vrfs.VrfStaticRoutesField.column_destination_t24Ah }}** field, specify the destination subnet [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).

          The destination prefix may be `0.0.0.0/0` or must be a valid range of private IPv4 addresses which belong to one of these ranges: `10.0.0.0/8`, `172.16.0.0/12`, or `192.168.0.0/16`.

          Note that the destination prefix cannot match or overlap with the IP address range of a private subnet or another static route inside this VRF.
      1. In the **{{ ui-key.yacloud.baremetal.vrfs.VrfStaticRoutesField.column_next-hop_gM3vY }}** field, specify the the next hop address for traffic bound to addresses within the destination prefix.

          This must be an IPv4 address belonging to a private subnet range within this VRF.
      1. Optionally, enable **{{ ui-key.yacloud.baremetal.vrfs.VrfStaticRoutesField.column_is-console-enabled_hiCs9 }}** to announce the static route to the {{ vpc-full-name }} [subnet](../../vpc/concepts/network.md#subnet).

          {% include [static-routes-to-vpc-ri-notice](../../_includes/baremetal/static-routes-to-vpc-ri-notice.md) %}

  1. If required, click **{{ ui-key.yacloud.baremetal.vrfs.AddStaticRoute.label_add-static-route_wY5KQ }}** to add more static routes to the VRF.

      The number of static routes in a cloud is limited by [quotas](../concepts/limits.md#baremetal-quotas).
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}

#### See also {#see-also}

* [{#T}](../concepts/private-network.md#static-routes)