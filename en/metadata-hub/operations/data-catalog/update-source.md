---
title: Updating a metadata source
description: Follow this guide to update a metadata source in {{ data-catalog-full-name }}.
---

# Edit origin


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. In the list that opens, select the metadata catalog containing the source you want to update.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.data-catalog.label_sources }}**.
    1. In the list of sources, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the source and select **{{ ui-key.yacloud.common.edit }}**.
    1. Update the parameters as needed:

        * Source description.

        {% include [source-parameters](../../../_includes/metadata-hub/data-catalog-source-parameters.md) %}

    1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
