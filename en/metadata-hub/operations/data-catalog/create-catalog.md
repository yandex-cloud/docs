---
title: Creating a metadata catalog
description: Follow this guide to create a metadata catalog in {{ data-catalog-full-name }}.
---

# Creating a metadata catalog

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a metadata catalog.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Click **{{ ui-key.yacloud.data-catalog.label_create-catalog }}**.
    1. Specify the catalog parameters:

       * In the **{{ ui-key.yacloud.common.name }}** field, enter a unique name for the catalog.
       * Optionally, describe the catalog.

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
