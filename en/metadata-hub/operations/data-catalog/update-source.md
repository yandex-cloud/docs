---
title: Updating a metadata source
description: Follow this guide to update a metadata source in {{ data-catalog-full-name }}.
---

# Editing a source


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
    1. [Navigate]({{ link-console-main }}/link/metadata-hub) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. Under **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}**, select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. In the list that opens, select the metadata catalog containing the [source](../../concepts/data-catalog-sources.md) you want to update.
    1. Navigate to the **{{ ui-key.yacloud.data-catalog.layout.label.sources-new-layout_N6vT1 }}** tab.
    1. In the list of sources, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the source and select **{{ ui-key.yacloud.common.edit }}**.
    1. Update the parameters as needed:

        * Source description.

        {% include [source-parameters](../../../_includes/metadata-hub/data-catalog-source-parameters.md) %}

    1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
