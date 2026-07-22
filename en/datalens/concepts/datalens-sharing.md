---
title: Sharing an object within an organization in {{ datalens-full-name }}
description: In this article, you will learn how to share an object with users within your organization in {{ datalens-full-name }}.
---

# Sharing an object within an organization

You can share a dashboard, connection, dataset, chart, or report with users within your organization.

The way you share an object depends on whether it is [located](./publishing-and-embedding.md#object-location) in a [workbook](../workbooks-collections/index.md#enable-workbooks) or a folder:

{% list tabs %}

- In a workbook

  {% include [datalens-share-wb](../../_includes/datalens/operations/datalens-share-wb.md) %}

- In a folder

  {% list tabs %}

  - Sharing a dashboard {#dashboard}

    {% include [datalens-link-dashboard](../../_includes/datalens/operations/datalens-link-dashboard.md) %}

  - Sharing another object {#chart}

    {% include [datalens-link-chart](../../_includes/datalens/operations/datalens-link-chart.md) %}

  {% endlist %}

{% endlist %}

{% note info %}

The generated link provides access to the objects only to authenticated users with appropriate permissions.

{% endnote %}
