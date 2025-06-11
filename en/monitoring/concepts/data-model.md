---
title: Data model in {{ monitoring-full-name }}
description: This article describes the data model used in {{ monitoring-full-name }}. A metric is a time series that shows a change of some value over time. Metrics are identified using text labels. A label is a metric's characteristic in the key/value format. Each metric is identified by an unordered set of labels. Use a parameter that takes a limited set of values as a label.
---

# Data model in {{ monitoring-name }}

{{ monitoring-full-name }} stores data as [time series](https://en.wikipedia.org/wiki/Time_series).

## Metrics {#metric}
A _metric_ is a time series that shows a change of some value over time. For example, the resource status of a {{ yandex-cloud }} service: the amount of used disk space, network data transfer rate, and so on.

Metrics are identified using text [labels](#label).

### Query aggregation {#aggregation}

Some metrics, e.g., `disk.write_latency` in {{ compute-full-name }}, track massive numbers of queries, at times reaching tens of thousands per second. Queries in such metrics are initially aggregated in buckets depending on their values.

Such metrics have multiple buckets, e.g., `1`, `2`, `5`, `10`, etc. Thus, bucket `1` stores queries that took up to 1 ms to complete, bucket `2` up to 2 ms, bucket `5` up to 5 ms, etc.

When executing a query, the service measures its completion time and decides which bucket to put it into. For example, a query completed in 7 ms will go into bucket `10`, same as all other queries which took from 5 to 10 ms to complete.

The value of such metrics is a floating-point number representing the average number of queries for an interval of time, e.g., 5 seconds.

Usually, the `histogram_percentile` [filter](./querying.md#histogram_percentile) applies to such metrics, taking as the parameter the percentage of queries for which it is required to calculate the minimum time it takes to complete this percentage of queries.

Here is an example:

> There were 1,000 queries, of which:
> - 500 queries were completed in 0.5 ms.
> - 499 queries were completed in 1.5 ms.
> - One query was completed in 1,000 ms.

The arithmetic mean per query is around 2 ms. However, this value will be of little use due to the large peak value that is not inlcluded in the calculation. It would be much more useful to know that maximum query execution time was 1,000 ms, but 99% of queries were completed within 2 ms, i.e., the 99th percentile of the queries was 2 ms. You can get this percentile by providing `99` to the `histogram_percentile` filter.

Metric values are also affected by the [data decimation policy](decimation.md).

### Labels {#label}
A _label_ is a metric characteristic in `key: "value"` format. Each metric is identified by an unordered set of labels. Use a parameter that takes a limited set of values as a label. For example, the HTTP status code, the types of procedures being performed in a database, and so on.

There are required and optional labels. Required labels:

- `cloudId`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) the resource resides in.
- `folderId`: ID of the folder the resource resides in.
- `service`: Indicates the {{ yandex-cloud }} service the resource belongs to, e.g., `compute` or `managed-postgresql`.

{% note warning %}

When uploading custom metrics, you should write the `custom` value into the `service` label.

{% endnote %}

#### Label constraints and their values {#limits}

The following constraints apply to labels and their values:

* A metric can have a maximum of 16 labels, including the required `cloudId`, `folderId`, and `service`.
* Label name must not be empty.
* Label name must not consist of the `-` character.
* Name length: 32 characters or less.
* Label name must start with an uppercase or lowecase letter and may contain letters, digits, `.`, and `_`.
* Label names and metric values must not contain any non-Latin letters.

### Metric types {#metric-types}
{{ monitoring-full-name }} offers the following metric types:

Type | Description
----- | -----
`DGAUGE` | Numeric value (decimal). It shows the metric value at a certain point in time. For example, the amount of used RAM.
`IGAUGE` | Numeric value (integer). It shows the metric value at a certain point in time.
`COUNTER` | Counter. It shows the metric value that increases over time. For example, the number of days of service continuous running.
`RATE` | Derivative value. It shows the change in the metric value over time. For example, the number of requests per second.

### Queries {#queries}

A query is an arbitrary expression in the [query language](querying.md) that results in a line or a set of lines. Query text may refer to the results of higher-level queries as variables.

{{ monitoring-name }} allows you to create queries to select a set of metrics and display them on a chart. You can also use templates as label values.

The following templates are available in {{ monitoring-name }}:

Syntax | Description
----- | -----
`label="*"` | Outputs all metrics with the specified label. For example, the `host="*"` query will return all metrics with the `host` label.
`label="glob"` | Displays all metrics whose label value complies with a [glob expression](https://en.wikipedia.org/wiki/Glob_(programming)):<br/><br/>`*`: Any number of characters (including none). For example, `name="folder*"` will return all metrics whose `name` label value begins with the `folder` prefix.<br/><br/>`?`: Any single character. For example, `name="metric?"` will return all labels whose value contains one character after `metric`<br/><br/>`\|`: All specified options. For example, `name="metric1\|metric2"` will return two metrics labeled `metric1` and `metric2`.
