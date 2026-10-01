---
title: Creating a cloud in another region
description: Follow this guide to create a new cloud in another region using a controlled organization.
---

# Create a cloud in another region

To create clouds in another [region](../../../overview/concepts/region.md), [create](../../../organization/operations/add-region.md) a controlled organization.

Your cloud in another region will be owned by this controlled organization. The controlled organization does not show in the list of your account's organizations, so you cannot switch over to it. However, its clouds can be seen in the general list of clouds; use them the same way as the main organization's clouds.

Once you have created a controlled organization, follow these steps:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [management console]({{ link-console-main }}).

  1. In the upper left corner next to the **{{ ui-key.yacloud.cloud-tree-list.value_search-placeholder }}** field, click ![plus](../../../_assets/console-icons/plus.svg). In the window that opens:
  
  1. Select a region that is different from the region of the main organization.

  1. Go to the console of this region.

  1. In the upper left corner next to the **{{ ui-key.yacloud.cloud-tree-list.value_search-placeholder }}** field, click ![plus](../../../_assets/console-icons/plus.svg). In the window that opens:

     1. Enter a name for the cloud. The naming requirements are as follows:

          {% include [name-format.md](../../../_includes/name-format.md) %}

     1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}