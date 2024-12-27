---
title: Creating a cloud in another region
description: Follow this guide to create a new cloud in another region using a controlled organization.
---

# Create a cloud in another region

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

To create clouds in another [region](../../../overview/concepts/region.md), [connect](../../../organization/operations/add-region.md) a controlled organization. After that, follow these steps:

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [management console]({{ link-console-main }}).

  1. In the upper left corner next to the **{{ ui-key.yacloud.cloud-tree-list.value_search-placeholder }}** field, click ![plus](../../../_assets/console-icons/plus.svg). In the window that opens.
  
  1. Select a region that is different from the region of the main organization.

  1. Go to the console of this region.

  1. In the upper left corner next to the **{{ ui-key.yacloud.cloud-tree-list.value_search-placeholder }}** field, click ![plus](../../../_assets/console-icons/plus.svg). In the window that opens:

     1. Enter a name for the cloud. The naming requirements are as follows:

          {% include [name-format.md](../../../_includes/name-format.md) %}

     1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}