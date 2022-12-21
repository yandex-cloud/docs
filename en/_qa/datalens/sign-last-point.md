### How do I create a signature only for the last point on the chart? {#sign-last-point}

Create a new measure using a formula. To create a signature only for the last point, the formula looks like this:

```
if(
    max([Order Date]) = max(max([Order Date]) total), --if the point date is the maximum date for the chart
    [Sales], --then output the value of the Sales measure
    null --otherwise, show no signatures for any other dates
)
```

[Chart example](https://storage.yandexcloud.net/doc-files/line-chart.png)

In the case of a line chart, you can only drag-and-drop measures and the **Measure Values** technical field to the **Signatures** section.

If you move the same measure in the **Y** axis section to the **Signatures** section, then you'll see signatures on the chart (see the [screenshot](https://storage.yandexcloud.net/doc-files/signatures.png)).

