---
title: "{{ datalens-full-name }} release notes for March 2024"
description: "Check out {{ datalens-full-name }} release notes for March 2024."
---

# {{ datalens-full-name }} release notes: March 2024


* [Updates](#top-news)
* [Fixes and improvements](#fixes)

## Updates {#top-news}

### Filtering charts by charts {#chart-filtration}

Added the option to [filter charts by charts](../dashboard/chart-chart-filtration.md). A chart with filtering configured can now be used as a selector for other charts.

You can enable filtering for a chart in the widget settings on the dashboard. To apply filtering, click an individual item in the filtering chart, e.g., a point on a graph, a column, or a pie chart segment. The linked charts will then be filtered by the selected dimensions.

### Connecting to Yandex Documents {#yadocs-connection}

Added a new connection type: [Yandex Documents](../operations/connection/create-yadocs.md).

### Uploading Excel files {#file-connection}

Added the option to upload `Excel` files for the [Files](../operations/connection/create-file.md) connection type.

### Configuring links on the dashboard {#dashboard-link-settings}

Updated the [link](../dashboard/link.md) management interface on the dashboard. To configure links, switch to the dashboard edit mode and click ![image](../../_assets/datalens/links.svg) to the right of the widget you need.

### Joining tables in a connection to Bitrix24 {#bitrix24-join}

In a connection to [Bitrix24](../operations/connection/create-bitrix24.md), you can now [join data](../concepts/data-join.md#ui-join) from multiple tables.

### New domain {#new-domain}

Starting March 27, {{ datalens-short-name }} is available at the new address, <{{ link-datalens-main }}>.

Users will not experience any change. Old addresses will redirect you automatically. However, you will have to log in once again. For more information, see the [blog](https://yandex.cloud/ru/blog/posts/2024/03/new-domain).


## Fixes and improvements {#fixes}


### Displaying the X axis in a combined chart {#combined-chart-format}

Fixed the mode of displaying the X axis in a [combined chart](../visualization-ref/combined-chart.md): the `Continuous` value is now set by default.
