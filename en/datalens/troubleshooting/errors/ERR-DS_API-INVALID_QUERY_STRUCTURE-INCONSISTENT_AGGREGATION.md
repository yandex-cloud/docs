---
title: '{{ datalens-full-name }} error ERR.DS_API.INVALID_QUERY_STRUCTURE.INCONSISTENT_AGGREGATION'
description: This page describes the Inconsistent aggregation status among SELECT items {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Inconsistent aggregation status among SELECT items

`ERR.DS_API.INVALID_QUERY_STRUCTURE.INCONSISTENT_AGGREGATION`

This error occurs when an expression combines data with different [levels of detail (LOD)](../../../datalens/function-ref/aggregation-functions.md#syntax-lod).

When computing an aggregate value, a large set of strings is converted into a single value. Special [aggregate functions](../../../datalens/function-ref/aggregation-functions.md) are used for this. The most common functions are `SUM`, `MIN`, `MAX`, `AVG`, and `COUNT`. The aggregate functions calculate and return one resulting value for all strings of the query. If data grouping is used, values are calculated and returned separately for each one of the groups the query result is broken down into.

In {{ datalens-short-name }}, you can use LOD expressions to create nested aggregations as well as aggregations over all data or groups that are different from the chart-level grouping. However, you cannot use data with different LODs in one expression.

To resolve the error, make sure all data in an expression has the same level of detail.
