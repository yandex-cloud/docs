### How do I make a signature with both the sector name and percentage in a pie chart? {#pie-chart-note}

Create a signature using a calculated field:

`[<name>] + ' ' + str(int([<value>]/sum([<value>] TOTAL)*100)) + '%'`

Where:

- `<name>`: The field to determine the sector name.

- `<value>`: The field to be shown as a percentage.

**How does the formula work?**

1. The `([<value>]/sum([<value>] TOTAL)*100` fragment calculates the sector's percentage.

1. The calculated value is rounded by the [INT](../../../datalens/function-ref/INT.md) function.

1. The value is converted to a string by the [STR](../../../datalens/function-ref/STR.md) function to create signatures on the chart.

1. The sector name, calculated value, and the `%` character are concatenated into a string using the addition operator `+`.

**Example**

Formula: `[Category] + ' ' + str(int([Sales]/sum([Sales] TOTAL)*100)) + '%'`

See the [screenshot](https://storage.yandexcloud.net/doc-files/pie-chart.png).

