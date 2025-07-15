---
title: Updating a glossary
description: Follow this guide to update a glossary in a metadata catalog.
---

# Updating a glossary

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog containing the glossary you want to update.
  1. Go to the ![image](../../../_assets/console-icons/book.svg) **Terms and glossaries** tab.
  1. In the glossary list, click ![image](../../../_assets/console-icons/ellipsis.svg) in the line with the glossary and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the glossary parameters:

      * In the **{{ ui-key.yacloud.common.name }}** field, specify a new unique name for the glossary.
      * Optionally, update the glossary description.

  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
