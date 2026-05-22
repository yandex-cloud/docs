---
title: Query language in {{ monium-name }}
description: In {{ monium-name }}, you can search for data by metrics, logs, and traces using a unified query language.
---

# Query language in {{ monium-name }}

## Queries {#queries}

A _query_ is any valid expression in the [query language](querying.md). The query result depends on the data type:

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
    {service='compute', host='*', name='exceptionCount'}
    ```

* **Bool**: For metrics, `true` or `false`.

### Query string operations {#operations}

{% include [query-operations](../../_includes/monium/query-operations.md) %}


### Data filtering expressions {#expressions}

The query language is used to describe filters for telemetry data and provides common constructs for different types of data (metrics, logs, traces). There are also differences due to the features of the data model for each data type.

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

To search through labels stored in the `meta` metadata, use the fully qualified name: `meta.label_name`. Supported operators are the same as for the top-level labels in all telemetry types.

The `message` field is there in logs only.

#### Trace-specific keys {#trace-keys}

When searching for traces or spans, you can use additional keys:

* `span.name`: Span name; supports all string operators.
* `span.id`: Span ID; supports the `=` and `!=` operators.
* `span.status`: Span status, `OK`, `ERROR` or `UNKNOWN`; supports the `=` and `!=` operators.
* `span.duration`: Span duration; supports the `>`, `>=`, `<`, and `<=` comparison operators with duration literals, e.g., `500ms` or `2s`.
* `span.critical_path`: Whether or not the span belongs to the critical path, `PRESENT` or `ABSENT`; supports the `=` operator.
* `trace.id`: Trace ID (to search for logs by trace).

For more information about searching for traces, see [{#T}](../traces/operations/traces-explorer.md).

The {{ monium-name }} query language is used for conversion of metrics when configuring [dashboards](./visualization/dashboard.md) and [alerts](./alerting.md), as well as in the [MetricsData.read](../api-ref/MetricsData/read.md) API method.

## Uploading metrics {#selectors}

Select multiple metrics using the metric name and selectors to filter label values (for more information, see [{#T}](./data-model.md#label)). You can use the sets of metrics you created in alerts or transmit them to a function as an argument.

Here is an example of a metric query:

```
cpu_usage{project="folder__zoeu2rgjpqak********", service="compute"}
```

This query will return metrics named `cpu_usage` for all {{ compute-full-name }} VMs in the project (folder) with the `zoeu2rgjpqak********` ID.

{% note warning %}

Consider the following for the `project` label:

* The label value must always match the selected project (folder). You cannot request data from other projects. This applies to all the query language use cases: when creating charts, dashboards, alerts, or calling API methods.

* For API calls, provide the label value in the `x-monium-project` header, not the query body.

{% endnote %}

## Using query names as variables {#query-name-as-variable}

The query language supports links to the results of executing other queries as to names of variables.

Here is an example:

A: `"temperature"{project="folder__my_folder_id", service="custom", room="bedroom", building="home", sensor="sensor1" }`

B: `"temperature"{project="folder__my_folder_id", service="custom", room="bedroom", building="home", sensor="sensor2" }`

C: `(A + B) / 2`

These links can only refer by name in text mode, and only to higher-level queries in the same alert or chart. You can apply any supported arithmetic operations and query language [functions](querying-functions.md) to variables.