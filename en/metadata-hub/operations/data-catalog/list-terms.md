---
title: Getting a list of terms in {{ data-catalog-full-name }}
description: Follow this guide to get a list of glossary terms in {{ data-catalog-name }}.
---

# Getting a list of terms


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. [Navigate]({{ link-console-main }}/link/metadata-hub) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Under **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}**, select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog the terms were created in.
  1. Navigate to the **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}** tab and select the glossary the terms were created in.

{% endlist %}

## Setting up a list of terms {#setting-list-terms}

{% include [list-search](../../../_includes/metadata-hub/search-sort-list-terms.md) %}

{% include [list-display](../../../_includes/metadata-hub/display-columns.md) %}
