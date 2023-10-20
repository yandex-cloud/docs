# Studying a cloud network map

You can open your folder's [cloud network map](../concepts/network.md#map) and study the relationships between {{ yandex-cloud }} resources and their networks and subnets.

## Opening a cloud network map {#open}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder with the network you want to explore.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, click **More**, then click **{{ ui-key.yacloud.vpc.title_network-map-page }}**.

{% endlist %}

## Highlighting and filtering resources on the map {#highlight}

You can view the relationships of specific resources by visually highlighting them or applying filters. To highlight resources on the map, click them or use the **Search by name or ID** list on the **{{ ui-key.yacloud.vpc.title_network-map-page }}** page. The map will only show the relationships between the highlighted resources and their subnets.

To filter resources on the map:

{% list tabs %}

- Management console

   On the **{{ ui-key.yacloud.vpc.title_network-map-page }}** page, under **Filter**, select a resource category in the first filter list and a resource in the second.

   The map will only show the selected resources and their networks and subnets.

{% endlist %}

## Opening a resource page {#resource-page}

The map allows you to navigate directly to the page of the resource of interest. To do this:

{% list tabs %}

- Management console

   1. On the **{{ ui-key.yacloud.vpc.title_network-map-page }}** page, hover over a resource.
   1. In the pop-up window, click the resource name.

{% endlist %}
