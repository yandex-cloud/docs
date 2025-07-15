---
title: Creating a metadata source
description: Follow this guide to create a metadata source in {{ data-catalog-full-name }}.
---

# Creating a source

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. In the list that opens, select the metadata catalog you want to create a source in.
    1. Go to the ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Sources** tab.
    1. Click **Create data source**.
    1. Enter a unique name for the source. Once the source is created, you cannot rename it.
    1. Optionally, describe the source.
    1. Select the backend type to supply metadata from. Once the source is created, you cannot change the database type.

       Available backends: {{ PG }}, {{ MY }}, {{ MG }}, {{ CH }}, {{ OS }}, {{ GP }}, and {{ data-transfer-name }}.
       
    1. Specify the source parameters for the selected database type:

        {% include [source-parameters](../../../_includes/metadata-hub/data-catalog-source-parameters.md) %}

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
