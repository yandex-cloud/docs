# Inconsistent aggregation among operands

`ERR.DS_API.VALIDATION.AGG.INCONSISTENT`

This occurs when a single function (or a single operator)uses an aggregated and an unaggregated expression as arguments (operands).

Examples:

- `[Sales] / SUM([Sales])`
- `[Total Sales] - [Profit]`. Where the `Total Sales` field is an aggregated expression (measure),while the `Profit` field is an unaggregated expression. This produces an errorbecause this expression cannot be computed: `[Total Sales]` is the output of aggregatingall the records in a group whereas the `[Profit]` expression has a different value for every record, and in a group, it is unclear,which value to use. Such an expression doesn't make sense. In this situation, the user is most likelylooking for `[Total Sales] - SUM([Profit])`.

Another error might occur when the window function in the `WITHIN` section has fields that are neither an aggregation nor a dimension in the chart.

