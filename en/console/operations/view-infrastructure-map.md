---
title: Infrastructure map analysis in the {{ yandex-cloud }} management console
description: Follow this guide to analyze the relationships between resources as well as between networks and subnets within the resource folder using the infrastructure map in the {{ yandex-cloud }} management console.
---

# Infrastructure map analysis

You can open your [infrastructure map](../concepts/infrastructure-map.md) in your folder and check the relationships between {{ yandex-cloud }} [resources](../concepts/infrastructure-map.md#resources), [networks](*network), and [subnets](*subnet).

## Opening the infrastructure map {#open}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to view the infrastructure map in.
  1. In the left-hand panel, select ![molecule](../../_assets/console-icons/molecule.svg) **{{ ui-key.yacloud.dashboard.label_infrastructure-map_1jB82 }}**.

  You can also open the infrastructure map from the page of any [resource](../concepts/infrastructure-map.md#resources) displayed on the map. To do this, on the resource information page, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) at the top of the screen and select ![molecule](../../_assets/console-icons/molecule.svg) **View on infrastructure map**.

{% endlist %}

## Highlighting and filtering resources on the map {#highlight}

You can view the relationships of specific resources by visually highlighting them or applying filters. To highlight resources on the map, click them or select them in the **{{ ui-key.yacloud.dashboard.InfrastructureMapPage.NodeSelect.label_search-by-name-or-id_9Hd59 }}** field on the **{{ ui-key.yacloud.dashboard.label_infrastructure-map_1jB82 }}** page. As a result, the map will only show the relationships between the highlighted resources.

To filter resources on the map:

{% list tabs group=instructions %}

- Management console {#console}

  On the **{{ ui-key.yacloud.dashboard.label_infrastructure-map_1jB82 }}** page:
  
  * To filter the displayed resources by a specific network or subnet, select the relevant networks or subnets in the **{{ ui-key.yacloud.dashboard.InfrastructureMapPage.networks_d8mWN }}** or **{{ ui-key.yacloud.dashboard.InfrastructureMapPage.subnetworks_mBZgS }}** field.
  
      As a result, the map will only show the selected networks and subnets and resources that use them.
  * To filter the displayed resources by the resource type:
  
      1. Click ![square-plus](../../_assets/console-icons/square-plus.svg) and select the resource types for filtering in the list that opens.
      1. In the fields that appear with the selected types, choose the specific resources you want to filter by.
   
      As a result, the map will only show the selected resources along with the networks and subnets they use.

{% endlist %}

In the filter, you can select multiple different networks, subnets, and other [available resources](../concepts/infrastructure-map.md#resources) at once. In this case, the selected filter parameters are applied with `OR` logic.

## Opening a resource page {#resource-page}

The map allows you to navigate directly to the page of the resource you need. Proceed as follows:

{% list tabs group=instructions %}

- Management console {#console}

   1. On the **{{ ui-key.yacloud.vpc.title_network-map-page }}** page, hover over the resource.
   1. In the pop-up window, click the name of the selected resource. The information page for the selected resource will open in a new browser tab.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../concepts/infrastructure-map.md)

[*network]: A cloud network is similar to a traditional LAN in a data center. Cloud networks are created in folders and used for transmitting information between cloud resources and connecting resources to the internet. For more information, see [{#T}](../../vpc/concepts/network.md#network).

[*subnet]: A subnet is a range of IP addresses in a cloud network. Addresses from this range can be assigned to cloud resources, such as VMs and database clusters. For more information, see [{#T}](../../vpc/concepts/network.md#subnet).
