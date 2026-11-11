---
title: Query language in {{ monium-name }}
description: In {{ monium-name }}, you can search for data by metrics, logs, and traces using a unified query language.
---

# Query language in {{ monium-name }}

{{ monium-name }} uses a unified query language to search and filter telemetry data, such as metrics, logs, and traces. With this language, you can build selector expressions, apply functions to transform metrics, and reference results of other queries as variables.

For a data model description, including required attributes, labels, and metadata, see [{#T}](data-model.md). For configuration objects (project, cluster, and service) used in queries, see [{#T}](configuration-model.md).

## Queries {#queries}

A _query_ is any valid expression in the query language. The query result depends on the data type:

* Metrics: Line or a set of lines.
* Logs: Log entry or a set of log entries.
* Traces (spans): Set of operations or operation chains performed by a distributed application.

Query text may refer to the results of higher-level queries as variables.

A query consists of a key, a comparison operator, and a value:

```
{ <key>="<value>", <key>="<value>", ... }
```

The list of supported keys varies depending on whether you search for metrics, logs, traces, or spans within a trace.

In addition to searching by expression in the query string, you can use [functions](querying-functions.md) to get a selection of metrics.

### Data types {#data-types}

The query language supports the following data types:

* **String**: For all telemetry types.

   Any literal expression in single or double quotes will be represented as a string.

* **Scalar**: For metrics and logs.

   An [IEEE 754](https://en.wikipedia.org/wiki/IEEE_754-2008_revision)-compliant double-precision floating-point number. For metrics, the data type includes the special value, `NaN`; for logs, it does not.

   Here are some examples: `101`, `75.3`, `20G`, `1E-3`.

   The real number type supports scientific notation with the fraction and power of ten and the following suffixes:

   * `k`: 10^3^
   * `M`: 10^6^
   * `G`: 10^9^
   * `T`: 10^12^
   * `P`: 10^15^
   * `E`: 10^18^

* **Duration**: For metrics, traces, and spans.

   Follow `1s`, `10ms`, `150us`, `2m`, and `6h` format, without quotes.

* **Timeseries_vector**: For metrics.

   Example of a `timeseries_vector` type object. The following expression will return a metric vector with different values of the `host` label:

    ```json
    {service='__compute__', host='*', name='exceptionCount'}
    ```

* **Bool**: For metrics, `true` or `false`.

### Query string operations {#operations}

{% include [query-operations](../../_includes/monium/query-operations.md) %}


### Data filter expressions {#expressions}

The query language is used to describe filters for telemetry data and provides common constructs for different types of data (metrics, logs, traces). There are also some differences due to the specifics of the data model for each data type.

Top-level fields, such as `message` and `level`, are treated as labels. A selector consists of a label name, an operator, and an expression describing a set of label values. Conditions inside a selector are joined with `AND`.

#### Operators for all telemetry types {#operators}

| Selector type | Description | Examples |
|-|-|-|
| `label="<value>"`   | Returns all telemetry elements (logs, metrics, traces) with `label` equal to `value`. The value supports [glob expressions](https://en.wikipedia.org/wiki/Glob_(programming)) (the only allowed characters are `*`, `?`, and `\|`; `[` and `]` are not supported). | `host="vla"` returns elements with the `host` label set to `vla`.<br/><br/>`host="*"` returns elements which have the `host` label.<br/><br/>`host="sas-*"` returns elements with the `host` label value starting with the `sas-` prefix.<br/><br/>`host="sas-?00"` returns elements with the `host` label set to `sas-100`, `sas-200` and so on.<br/><br/>`host="sas*\|vla*"` returns elements with the `host` label value starting with the `sas` or `vla` prefix. |
| `label="-"` | Returns all elements missing the specified label. It applies to logs, metrics, and traces. | `host="-"` returns all elements without the `host` label.<br/><br/>`host="-\|myhost"` returns all elements without the `host` label or those with the `host` label set to `myhost`. |
| `label!="<value>"` | This selector is opposite to `label="<value>"`. It applies to logs, metrics, and traces. | `host!="myhost-*"` returns all elements without the `host` label or those whose `host` label value that does not start with the `myhost-` prefix. |
| `label=="<value>"`  | Returns elements whose `label` value exactly matches `<value>`, without `glob` support. It applies to logs, metrics, and traces. | `host=="myhost"` returns elements whose `host` label value matches the `myhost` string.<br/><br/>`host=="*"` returns elements whose `host` label value contains the literal `*` character. |
| `label!=="<value>"` | This selector is opposite to `label=="<value>"`. It applies to logs, metrics, and traces. | `host!=="myhost"` returns all elements without the `host` label or those whose `host` label value that does not match the `myhost` string. |
| `message=*"<substring>"` or `meta.key=*"<substring>"` | Returns elements whose label value contains `<substring>`, case-insensitive (`<substring>` may be `glob`). `message` applies to logs only; `meta.key` applies to logs, metrics, and traces that have the `meta.key` label. | `message=*"request"` returns logs with `message` equal to `Failed search request`, `Request cancelled`, etc.<br/><br/> `meta.error=*"failed*request"` returns elements where `meta.error` equals `Failed to make a request`, `Reader failed to retrieve data from a request`, etc. |
| `message!=*"<substring>"` or `meta.key!=*"<substring>"` | This operator is opposite to `=*`. `message` applies to logs only; `meta.key` applies to logs, metrics, and traces that have the `meta.key` label. | |
| `label=~"<regex>"` | Returns elements whose `label` value satisfies the `<regex>` regular expression in [re2](https://github.com/google/re2/wiki/Syntax) syntax. It applies to logs, metrics, and traces. | |
| `label!~"<regex>"` | This selector is opposite to `label=~"<regex>"`. It applies to logs, metrics, and traces. | |
| `label>300`         | Returns elements whose `label` value is greater than the specified value. It applies to logs and metrics for numeric labels, and to traces for `duration` type labels only (time values). | `duration>500ms` returns traces/spans with a duration greater than 500 ms.<br/><br/>Here is an example for metrics/logs with a numeric label: `value>0.95`. |
| `label>=300`        | Returns elements whose `label` value is greater than or equal to the specified value. It applies to logs and metrics for numeric labels, and to traces for `duration` type labels only. | `latency>=2s` returns traces/spans with a latency of 2 seconds or more. |
| `label<300` | Returns elements whose `label` value is less than the specified value. It applies to logs and metrics for numeric labels, and to traces for `duration` type labels only. | `elapsed<750ms` returns traces/spans with a duration of less than 750 ms. |
| `label<=300`        | Returns elements whose `label` value is less than or equal to the specified value. It applies to logs and metrics for numeric labels, and to traces for `duration` type labels only. | `duration<=1s` returns traces/spans with a duration of up to 1 second, inclusive. |

For the `>` `>=` `<`, and `<=` operators:
- Logs and metrics: RHS must be a numeric literal; the label value is converted to a number. The `level` label is an exception.
- Traces: Comparison works only for labels of the `duration` type. RHS must be a duration literal with units, e.g.,`500ms`, `2s`, and `150us`. If the label value cannot be converted to the required type, the result of this part of the expression is considered false.

To search through labels stored in the `meta` metadata, use the fully qualified name: `meta.label_name`. Supported operators are the same as for the top-level labels in all telemetry types. For more on labels and metadata, see [{#T}](data-model.md).

The `message` field is there in logs only.

#### Trace-specific keys {#trace-keys}

When searching for traces or spans, you can use additional keys:

* `span.name`: Span name; supports all string operators.
* `span.id`: Span ID; supports the `=` and `!=` operators.
* `span.status`: Span status, `OK`, `ERROR` or `UNKNOWN`; supports the `=` and `!=` operators.
* `span.duration`: Span duration; supports the `>`, `>=`, `<`, and `<=` comparison operators with duration literals, such as `500ms` or `2s`.
* `span.critical_path`: Specifies whether the span is on the critical path, `PRESENT` or `ABSENT`; supports the `=` operator.
* `trace.id`: Trace ID (to search for logs by trace).

In the query language, you can omit any number of leading zeros in a `trace.id` value. The following selectors are equivalent:

* `{trace.id="000000000000000036a91077c9806b4c"}`
* `{trace.id="000036a91077c9806b4c"}`
* `{trace.id="36a91077c9806b4c"}`

For information on searching traces, see [{#T}](../traces/operations/traces-explorer.md).

## Using query names as variables {#query-name-as-variable}

The query language supports links to the results of executing other queries as to names of variables.

Here is an example:

A: `{project="folder__my_folder_id", cluster="default", service="custom", room="bedroom", building="home", sensor="sensor1" }`

B: `{project="folder__my_folder_id", cluster="default", service="custom", room="bedroom", building="home", sensor="sensor2" }`

C: `(A + B) / 2`

These links can only refer by name in text mode, and only to higher-level queries in the same alert or chart. You can apply any supported arithmetic operations and query language [functions](querying-functions.md) to variables.

## Filtering metrics by time range {#time-range-filtering}

When searching for metrics, {{ monium-name }} considers the selector and the query’s time range. Time range filtering applies to metadata, without reading the metric values.

For each metric, the metadata stores:

* `first_point_seconds`: Timestamp of the first point recorded when the metric was created.
* `last_point_seconds`: Timestamp of the last recorded point.

These are the timestamps of the points themselves, not the time they were received by the service or the metric was created.

A metric matching the selector passes the filter for the `[from, to]` range if both conditions are met:

* `first_point_seconds ≤ to`: First recorded point, not later than the end of the range.
* `last_point_seconds ≥ from − lag`: Last point, not earlier than the start of the range, respecting the [metadata update delay](#reconciliation-lag) `lag`.

Passing the filter does not guarantee the selected range includes any points.

Charts, dashboards, the metric catalog, and query bar suggestions use the range selected in the UI. To find a metric whose recording has stopped, select a period containing its data. Its [retention period](common-ttl.md#ttl-metrics) must not have expired.

### Metadata update delay {#reconciliation-lag}

The `last_point_seconds` value is updated with a delay after a point is recorded. Thus, during filtering, the lower bound of the range is decreased by the _reconciliation lag_, referred to in the condition as `lag`. This ensures that metrics whose recording is still ongoing are not excluded from the sample due to the metadata update delay.

The reconciliation lag can be up to six hours. After recording stops, the metric remains in the sample for the current range for some time. New metrics and those with resumed recording are immediately available for search. Excluding a metric from the sample does not mean the data is deleted by TTL.

### Backfilling historical data {#backfill}

_Backfill_ is the recording of points for a past period.

Load historical data into a new metric in ascending order of timestamps, starting with the earliest point. Its timestamp will be saved in `first_point_seconds` and will be used for filtering.

When adding earlier points, `first_point_seconds` does not change. Even if a point is recorded, the metric will not pass the filter if the end of the query range precedes `first_point_seconds`.

Let’s imagine a point for 10:00 was recorded first, followed by a point for 09:00 on the same day. Here, `first_point_seconds` will remain 10:00, thus preventing a query for 09:00–09:30 from selecting the metric, even if the 09:00 point is saved.

## Aggregating metrics {#metric-aggregation}

_Aggregation_ combines multiple time series into one or more series, e.g., calculating the total number of requests across all hosts.

### Aggregation on read {#aggregation-on-read}

For aggregation by labels with a small number of distinct values, use [combining](querying-functions.md#combine-functions) or [ranking](querying-functions.md#rank-functions) functions. In this case, the total number of metrics loaded by the query must not exceed the limit.

Using the query language, you can process no more than 40,000 metrics on a single chart and no more than {{ alerting-metrics-limit }} metrics in a single regular alert or sub-alert. For a larger number of metrics, aggregate them in your application before sending them to {{ metrics-name }}.

A `Too many metrics are loaded by selectors` error when building a chart means your query selects more than [40,000 metrics](limits.md#limits-metrics-alerts). Narrow the selector to reduce the sample.

## Selector optimization {#selector-performance-tuning}

On sparse data, the system uses optimizations to narrow the search scope to specific parts of your storage. The more precisely a selector narrows the search scope, the faster the query runs.

Here are some examples:

* `{project = "...", service = "...", meta.order.id = "*abc*123*"}`: The query does not specify exact attribute values, forcing the system to search across the entire storage.

* `{project, service, meta.order.id = "bf090941d4f44867"}`: Providing an exact value makes search faster if the `id` is rare.

* `{project, service, meta.order.id = "*abc*123*", meta.request.id = "c7438471-fc0f46b9bc68"}`: Search by `order.id` with a glob pattern is slow, but using an exact `request.id` value improves query performance.

* `{project, service, geo.city = "very_small_city"}`: Optimization also works for `labels`.

* `{project, service, geo.city = "very_small_city", meta.purchase_token = "f97b68f2450e43e4"}`: This query runs faster than the previous one, as it first filters results by `geo.city` and then by `purchase_token`.

* `{project, service, trace.id="00008dsf7d8df7d"}`: Optimization works for `trace.id` and `span.id`.

We recommend storing high-cardinality labels, including IDs, in `meta` (metadata). For more on the difference between labels and metadata, see [{#T}](data-model.md).

#### See also {#see-also}

* [{#T}](data-model.md)
* [{#T}](configuration-model.md)
* [{#T}](visualization/query-string.md)
* [{#T}](querying-functions.md)