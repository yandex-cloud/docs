---
title: Chart links in dashboards and reports
description: In this article, you will learn about chart links in dashboards and reports.
---

# Chart links in dashboards and reports

Currently, charts and selectors built using Editor get all their parameters from dashboards. This may cause a chart to refresh even if it does not actually use a particular parameter. For such cases, links will indicate the `Not defined` status. To reduce load on your sources, assign the `Not linked` link type to all selectors and charts you do not want to trigger refreshes.

Also, to use parameter values obtained externally (e.g., from a dashboard selector) in a chart, you must first specify the default parameter values in the dashboard or report widgets.

Unlike dataset-based wizard charts and selectors which are linked automatically, Editor charts and selectors are only linked automatically when the chart’s parameter name matches the dataset field ID in a different chart or selector; otherwise, linking them requires an [alias](../../dashboard/link.md#alias).