### How do I create a signature only for the last point on the chart? {#sign-last-point}

Create a new measure using a formula. To create a signature only for the last point, the formula is as follows:

```
if(
    max([Order Date]) = max(max([Order Date]) total), --if the point date is the maximum date for the chart
    [Sales], --then output the value of the Sales measure
    null --else, show no signatures for any other dates
)
```

[Chart example](https://storage.yandexcloud.net/doc-files/line-chart.png)

For a line chart, you can drag-and-drop only measures, including the [Measure Values](../../datalens/concepts/chart/measure-values.md) measure, to the **Signatures** section.

If you move the same measure in the **Y** axis section to the **Signatures** section, you will see signatures on the chart (see the [screenshot](https://storage.yandexcloud.net/doc-files/signatures.png)).
