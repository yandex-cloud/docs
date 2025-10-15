---
title: Updating a metadata catalog
description: Follow this guide to update metadata catalog settings in {{ data-catalog-full-name }}.
---

# Updating a metadata catalog


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to update a metadata catalog.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Click ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) to the right of the catalog you want to update and select **{{ ui-key.yacloud.common.edit }}**.
    1. In the **{{ ui-key.yacloud.common.name }}** field, enter the new catalog name.
    1. Edit the catalog description.
    1. Add or delete [{{ yandex-cloud }} labels](../../../resource-manager/concepts/labels.md).
    1. Enable or disable the **Metadata AI markup**.
    
        With the AI markup on, the AI assistant suggests descriptions, [domains](../../concepts/data-catalog.md#domains-and-subdomains), [classifications and tags](../../concepts/data-catalog.md#classifications-and-tags), [glossaries and terms](../../concepts/data-catalog.md#glossaries-and-terms), and uses them to mark up your metadata. You can confirm, edit, or reject any suggestion your AI assistant makes by hovering over the **{{ ui-key.yacloud.data-catalog.label_ai-label }}** icon next to the suggestion and selecting the action.

    1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
