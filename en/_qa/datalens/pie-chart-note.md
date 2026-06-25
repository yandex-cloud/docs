### How do I make a signature with both the sector name and percentage in a pie chart? {#pie-chart-note}

Create a signature using a calculated field:

`[<name>] + ' ' + STR(INT(SUM([<value>])/SUM(SUM([<value>]) TOTAL) * 100)) + '%'`

Where:

* `<name>`: Field for the sector name.
* `<value>`: Field to show as a percentage.

**How does the formula work?**

1. The `SUM([<value>])/SUM(SUM([<value>]) TOTAL) * 100` part calculates the sector's percentage.
1. The calculated value is rounded by the [INT](../../datalens/function-ref/INT.md) function.
1. The value is converted to a string using the [STR](../../datalens/function-ref/STR.md) function to create labels on the chart.
1. The sector name, calculated value, and the `%` character are concatenated into a string using the addition operator, `+`.

Alternatively, you can use a formula with an [LOD expression](../../datalens/concepts/lod-aggregation.md#fixed):

`[<name>] + ' ' + STR(INT(SUM([<value>])/SUM([<value>] FIXED) * 100)) + '%'`

You will get the same result as with the first formula. Try both and pick the one that works best for you.

**Example**

Formula: `[Category] + ' ' + STR(INT(SUM([Sales])/SUM(SUM([Sales]) TOTAL) * 100)) + '%'`

See the [screenshot](https://storage.yandexcloud.net/doc-files/pie-chart.png).
