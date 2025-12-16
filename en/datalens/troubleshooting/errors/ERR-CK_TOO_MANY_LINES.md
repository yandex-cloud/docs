---
title: '{{ datalens-full-name }} error ERR.CK.TOO_MANY_LINES'
description: This page describes the Too many series on the chart {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Too many series on the chart

`ERR.CK.TOO_MANY_LINES`

Allowed number of rows exceeded.

{{ datalens-short-name }} restricts the amount of data displayed in the chart. Each visualization type has its own [limit](../../concepts/limits.md#datalens-chart-data-limits) on the number of rows.

To fix the error, reduce the amount of data to display, e.g., by doing the following:

* Add [filters](../../dataset/settings.md#default-filters).
* Use [aggregate functions](../../../datalens/function-ref/aggregation-functions.md).
* Enable [pagination](../../concepts/chart/settings.md#common-settings), if supported by the visualization you selected.