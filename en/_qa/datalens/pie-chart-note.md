### How do I make a signature with both the sector name and percentage in a pie chart? {#pie-chart-note}

Create a signature using a calculated field:

`[<name>] + ' ' + STR(INT(SUM([<value>])/SUM(SUM([<value>]) TOTAL) * 100)) + '%'`

Where:

* `<name>` — field to be used to determine the sector name;
* `<value>` — field whose value is to be displayed as a percentage.

**How does the formula work?**

1. The `SUM([<value>])/SUM(SUM([<value>]) TOTAL) * 100` snippet calculates the sector share as a percentage.
1. The calculated value is rounded by the [INT](../../datalens/function-ref/INT.md) function.
1. The value is converted to a string using the [STR](../../datalens/function-ref/STR.md) function to create signatures on the chart.
1. The sector name, calculated value, and the `%` character are concatenated into a string using the addition operator `+`.

You can use a formula with an [LOD expression](../../datalens/concepts/lod-aggregation.md#fixed) as an alternative:

`[<name>] + ' ' + STR(INT(SUM([<value>])/SUM([<value>] FIXED) * 100)) + '%'`

This alternative yields the same result as the previous one. You can try both and pick the one that works best for you.

**Example**

Formula: `[Category] + ' ' + STR(INT(SUM([Sales])/SUM(SUM([Sales]) TOTAL) * 100)) + '%'`

For details, see [Image](https://storage.yandexcloud.net/doc-files/pie-chart.png).
