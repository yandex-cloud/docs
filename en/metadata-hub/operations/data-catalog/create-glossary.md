---
title: Creating a glossary
description: Follow this guide to create a glossary in a metadata catalog.
---

# Creating a glossary

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog you want to create a glossary in.
  1. Navigate to the ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}** tab.
  1. Click **{{ ui-key.yacloud.data-catalog.label_create-glossary-action }}**.
  1. Specify the glossary parameters:

      * In the **{{ ui-key.yacloud.common.name }}** field, enter a unique name for the glossary.
      * Optionally, describe the glossary.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
