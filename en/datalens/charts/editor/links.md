---
title: Chart links in dashboards and reports
description: In this article, you will learn about chart links in dashboards and reports.
---

# Chart links in dashboards and reports

{% include [business-note](../../../_includes/datalens/datalens-functionality-available-business-note.md) %}

Charts and selectors built in Editor currently receive all parameters from the dashboard, which can cause a chart to update even if it does not use a parameter with a certain name. For this reason, in such cases, links will indicate the `Not defined` value. To prevent excess load on your sources, add the `Not linked` link type with all selectors and charts you do not want to cause updates.

In this case, to use parameter values obtained externally (e.g., from a dashboard selector) in a chart, you must first specify the default parameter values in your dashboard/report widgets.

Unlike wizard charts and selectors built on datasets, which are linked automatically, charts and selectors built in Editor are linked automatically only when a parameter name in a chart matches a dataset field ID in another chart/selector; otherwise, linking them requires an [alias](../../dashboard/link.md#alias).