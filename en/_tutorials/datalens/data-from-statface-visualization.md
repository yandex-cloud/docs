# Visualizing data from Statface reports

Use the ready-made solutions of this scenario to use data from [Statface](https://stat.yandex-team.ru/) [reports](https://doc.yandex-team.ru/stat/report-overview/concepts/about.html) for visualization in DataLens.

## Adding charts to dashboards {#add-graph-to-dashboard}

### Using a link from a report page {#use-link-from-report-page}

1. Go to a report chart.

1. In the chart's upper-right corner, click menu and select **Get link and code**.

   {% note info %}

   If you cannot receive a link (see the [ticket](https://st.yandex-team.ru/CHARTS-2018)), select **Open in new tab** in the same menu and copy a link from the address bar.

   {% endnote %}

1. Delete the `date_min` and `date_max` parameters from the link.

1. Add to the link the `_period_distance=n` parameter where `n` is the number of relevant time points to be displayed.

1. When adding a chart to a dashboard specify the received link.

You can configure the display of complex charts using the `graphs` report [configuration parameter](https://doc.yandex-team.ru/stat/report-overview/concepts/data/config.html#config__graphs):

```
graphs:
  - measure1
  - measure2
```

```
graphs:
  - fields:
    - measure1
    - measure2
```

{% note info %}

If a report cannot be edited, configure the chart display by specifying the parameters in the link from the report page.

{% endnote %}

You can add additional calculated fields using the `calculations` report [configuration parameter](https://doc.yandex-team.ru/stat/report-overview/concepts/data/config.html#config__calculations):

```
calculations:
  - nvalue:
      expression: '-value'
```

### Using the Statface report connector {#use-connector-statface-report}

1. Create a dataset based on [this connection](https://stat.yandex-team.ru/datasets/new?id=bibi7bswr5bs8).

   {% note warning %}

   The `scale` parameter must be specified in the link, other parameters are ignored.

   {% endnote %}

1. Create a chart.

1. For each dimension, select a single value in the filter or add a dimension to the display. If you do not do that, an `Insufficiently grouped result` error may occur (see the [ticket](https://st.yandex-team.ru/CHARTS-1588)).

   {% note warning %}

   When adding a chart, you can add only one dimension with one indicator or only a few indicators until [this ticket](https://st.yandex-team.ru/CHARTS-1577) is completed. In the future, this will occur when a new chart is created by a statface dataset.

   {% endnote %}

1. Add the **Date** dimension to the filter. If you do not add a dimension, default date filtering will be applied (according to the logic of the report page, most often only the last two dates).

## Adding selectors to dashboards {#selector-on-dashboard}

### Using the script {#via-script}

To add a selector for charts added using a link, we recommend using a [script](https://charts.yandex-team.ru/editor/nq4w4245ms3yj).

Script parameters:

* `name`: Report name.
* `dim`: Dimension name in the report.
* `label`: Selector name (optional, default value is empty).
* `param_name`: Parameter name for charts (optional, default value is `dim`).

A parameter with the name from `param_name` is used for specifying a default value. A value must be in a list of values in the report, before the dictionary overlay.

### Using the dataset {#via-dataset}

For charts added using the Statface report connector, we recommend creating selectors based on the Statface dataset.

{% note info %}

If an `Overlapping filters` error occurs in the chart, specify the **Ignore** link type for it with redundant selectors and charts.

{% endnote %}

Links between the selectors will not work in this case. It is easier to remove links between the selectors.
If the links have already been assigned, clear the running selectors and then edit the links.

To obtain dependent selectors, use one of the following options:

1. Using CHYT.

1. Write a custom editor-script that will print values from the report data for a limited period of time.

## Data processing {#data-processing}

### Export to YT {#upload-to-yt}

[Documentation](https://wiki.yandex-team.ru/statbox/statface/reportapi/data/dump/).

When the export is complete, re-sort and transfer the data via YQL. (If requested, we plan to attach a YQL-query template for transferring + re-sorting + dictionary overlay when exporting).
Add data via CHYT and start using it.

### Using the Statface report sql connector {#via-connector-statface-report-sql}

To export a small amount of data (up to 500,000 lines) from the Statface report and process it, use a [ready-made connection](https://stat.yandex-team.ru/datasets/new?id=3lyunp62vszs0).
The amount of data exported from the report can be reduced by using the **Equal to** / **In the list** dimension filters. The speed depends not only on the amount of exported data, but also on the report structure. If dimensions without filters are at the end of the list in the report configuration, data will be printed faster; if at the beginning of the list, slower.
These principles are relevant for any Statface export, but are highly relevant in the DataLens SQL connector.

A default filter is also applied to a date if it is not specified explicitly.

{% note warning %}

If there are **Total** values in the report, exclude them from unfiltered changes when grouping.

{% endnote %}

## Split a slice into a slice {#division}

This and other variations of calculations over different slices on the same date are a frequent user scenario in the [deprecated (old) wizard](https://charts-deprecated.yandex-team.ru/wizard/Users/hhell/oldwizard1).
The [datalens wizard](https://charts.yandex-team.ru/wizard/) does not support this scenario.
You can make calculations via an [editor-script](https://charts.yandex-team.ru/editor/new).

A recommended option for Statface reports is to add calculated numbers that are ready to be displayed to the report.
In individual cases, you can do this via `sum_if` over a Statface report sql connection.
