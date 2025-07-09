---
title: ERR.CHARTS.RUNTIME_TIMEOUT error
description: This page describes the ERR.CHARTS.RUNTIME_TIMEOUT error.
---

# Response processing timeout

`ERR.CHARTS.RUNTIME_TIMEOUT`

Response processing timeout has expired.

The error arises because {{ datalens-short-name }} doesn't have enough time to process and render the arriving data in the chart.

To fix the error, reduce the amount of data returned by your query: use filters, for example. Be aware of the [limits](../../concepts/limits.md) imposed on the number of rows in datasets.