---
title: Data decimation in {{ monitoring-full-name }}
description: This article describes decimation of metrics when reading data from {{ monitoring-name }} and decimation of historical metrics aimed at optimizing data storage in {{ monitoring-name }}.
---

# Data decimation

In {{ monitoring-full-name }}, the concept of _data decimation_ is used in two cases:

* _Historical data decimation_, where the detail level of data in storage is gradually reduced to reduce the data size.

* _Read data decimation_, where the data detail level is reduced dynamically when building charts. This optimizes chart display by minimizing the point count to the adequate level.

## Historical data decimation {#history-decimation}

All metrics in the {{ monitoring-name }} storage older than one week are aggregated at the 5-minute interval to reduce the amount of stored historical data. You cannot change the decimation parameters.

{% note info %}

Prior to August 7, 2024, only the average value was saved by the decimation policy. Currently, not only the average, but also maximum, minimum, total, and last values are saved in historical data. New decimation algorithms enable you to get broader statistics and create smoother charts.

{% endnote %}

Different metric values saved when archiving data can be displayed on the dashboard or in the metric overview. With advanced archiving, you can select the decimation option when reading the monitoring data.

## Read data decimation {#reading-decimation}

When your chart or request to the {{ monitoring-name }} API encompasses a rather broad time interval, you will need to read a large amount of data from the {{ monitoring-name }} storage. As a result, your request may take more time or the results you see on the screen may be displayed incorrectly.

Data decimation helps to address these issues.

Decimation reduces the number of points returned from the {{ monitoring-name }} storage when reading data and aligns the timestamps of the returned data points to a certain grid. This also helps to reduce the load on the disks and network.

### How decimation works {#decimation-mechanism}

1. The decimation interval is calculated based on the requested time range and decimation settings.
1. The requested time range is broken down into sequential non-overlapping decimation intervals. The start of each interval is aligned with the [Unix time](https://en.wikipedia.org/wiki/Unix_time).
1. An aggregation function, e.g., the average value, is applied to the metric values from the interval. As the result, you get a decimated value.
1. The timestamp of the decimated value is the start of the interval in which the value is calculated.

You can select a decimation method when setting up charts in the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** and **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** sections. 

### Decimation methods {#decimation-methods}

* `Auto`: Automatic decimation, default.

   The decimation interval is set to keep the value density within one value per two monitor pixels.

* `By interval`: Sets the decimation interval in seconds, minutes, or days. For example, for a three minute interval, metric values for every three minutes will form a single value.

   Since the start of every interval is set relative to the UNIX epoch, which is `00:00 UTC`, you cannot aggregate metrics strictly by calendar days.

   For example, in the Moscow time zone, a one-day interval will span the period from 03:00 to 03:00 of the next day (UTC+3).

* `By points`: Sets the number of points to return by monitoring.

   The decimation interval is chosen to maintain the specified maximum of decimated points.

* `No decimation`: Disables decimation.

   However, you can disable decimation only for time intervals of up to seven days, inclusive. In addition, there is a limit for the amount of data transferred per request, 100 MB.

After you select a decimation method, specify an aggregation function and a method for populating value gaps.

### Aggregation functions for decimation {#aggregation-functions}

An aggregation function specifies how to calculate a decimated value by interval values.

* `By default`: Calculates the average value.
* `Average`: Calculates the average value over the decimation interval.
* `Maximum`: Calculates the maximum value over the interval, which allows you to track surges in metrics.
* `Minimum`: Calculates the minimum value over the interval, which allows you to track drops.
* `Last`: Calculates the last value in the interval, which allows you to view the original values.
* `Sum`: Calculates the sum of values over the interval.
* `Count`: Calculates the number of values in the decimation interval.

### Populating value gaps {#filling-missing-values}

You need to populate value gaps if a metric has no values within the decimation interval.

* `By default`: Use `Null`.
* `Null`: Use a null value.
* `No value`: Skip the decimation interval.
* `Previous value`: Return the start time of a decimation interval as the decimated value timestamp, and the decimated value from the previous interval, as the value.

## How decimation affects metric values

In some cases, calculating the average value in the decimation policy may distort metric values. For example, when the amount of RAM is changed from `16 GB` to `18 GB`, an interval may include both old and new values. In this case, the average decimated RAM value over the interval will be `17 GB` while in fact there was no such value.

Similarly, when viewing data for a larger time interval, short-term surges may be smoothed out. For example, a chart may indicate balanced CPU load of `50%`. But if you select a smaller interval or another decimation function, you will see surges of up to `100%` on the chart.

Therefore, you should select different aggregation options when viewing data. View data with average, last, maximum, or minimum values.