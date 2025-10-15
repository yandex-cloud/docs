---
title: Creating a metadata catalog
description: Follow this guide to create a metadata catalog in {{ data-catalog-full-name }}.
---

# Creating a metadata catalog


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

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
       * Optionally, add [{{ yandex-cloud }} labels](../../../resource-manager/concepts/labels.md).

    1. Click **{{ ui-key.yacloud.common.create }}**.

    {% include [ai-on](../../../_includes/metadata-hub/data-catalog-ai-markup-on.md) %}

{% endlist %}
