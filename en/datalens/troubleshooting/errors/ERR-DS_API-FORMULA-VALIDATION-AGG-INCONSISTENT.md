---
title: ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT error
description: This page describes the ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT error.
---

# Inconsistent aggregation among operands

`ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT`

This occurs when a single function (or a single operator) uses an aggregated and an unaggregated expression as arguments (operands).

When computing an aggregate value, a large set of rows is converted into a single value. Special [aggregate functions](../../../datalens/function-ref/aggregation-functions.md) are used for this. The most common functions are `SUM`, `MIN`, `MAX`, `AVG`, and `COUNT`. Aggregate functions compute and return one resulting value for all query strings. If data grouping is used, values are computed and returned separately for each group, which the query result is divided into.

In {{ datalens-short-name }}, you can't use aggregated and non-aggregated values in the same expression. You can't use [measures](../../dataset/data-model.md#field) (displayed in the dataset and wizard in blue) and [dimensions](../../dataset/data-model.md#field) (displayed in the dataset and wizard in green) in the same expression.

Examples:

- `[Sales] / SUM([Sales])`. You can compute the `SUM([Sales])` aggregate value (measure) for this expression. It will be a single value for all query strings. However, the `Sales` field is neither an aggregation nor a dimension within the group. It does not have a fixed value and may vary from row to row. Therefore, it is impossible to determine what specific value of the `Sales` field needs to be selected to calculate the `[Sales] / SUM([Sales])` expression. It is impossible to compute this expression. An error occurs in such cases. To avoid an error, you can specify an aggregation type for the `Sales` field. In this case, this field will become a measure and the original formula will be correct, e.g., `AVG([Sales]) / SUM([Sales])`.
- `[Total Sales] - [Profit]`. Where the `Total Sales` field is an aggregated expression (measure), whilst the `Profit` field is an unaggregated expression. This produces an error because this expression cannot be computed: `[Total Sales]` is the output of aggregating all the records in a group whereas the `[Profit]` expression has a different value for every record, and it is unclear which value should be used for the group. Such an expression does not make sense. In this situation, the user is most likely looking for `[Total Sales] - SUM([Profit])`.

Another error is likely to occur when the window function in the `WITHIN` section has fields that are neither an aggregation nor a dimension in the chart.
