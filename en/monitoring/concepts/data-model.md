---
title: "Data model in {{ monitoring-full-name }}"
description: "The article describes the data model used in {{ monitoring-full-name }}. Metric is a timeseries that shows a change of some value over time. Metrics are identified using text labels. A label is a metric's characteristic in the key/value format. Each metric is identified by an unordered set of labels. Use a parameter that takes a limited set of values as a label."
---

# Data model in {{ monitoring-name }}


{{ monitoring-full-name }} stores data as [timeseries](https://en.wikipedia.org/wiki/Time_series).

## Metrics {#metric}
_Metric_ is a timeseries that shows a change of some value over time. For example, the resource status of a {{ yandex-cloud }} service: the amount of used disk space, network data transfer rate, and so on.

Metrics are identified using text labels.

### Labels {#label}
A _label_ is a metric characteristic in `key: "value"` format. Each metric is identified by an unordered set of labels. Use a parameter that takes a limited set of values as a label. For example, the HTTP status code, the types of procedures being performed in a database, and so on.

The service has mandatory and optional labels. Mandatory labels:

- `cloudId`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) the resource belongs to.
- `folderId`: ID of the folder the resource belongs to.
- `service`: Indicates the {{ yandex-cloud }} service that the resource belongs to. For example, `compute` or `managed-postgresql`.

{% note warning %}

When uploading custom metrics, you should write the `custom` value in the `service` label.

{% endnote %}

#### Label constraints and their values {#limits}

The following constraints apply to labels and their values:

* A metric can have no more than 16 labels, including the mandatory `cloudId`, `folderId`, and `service` labels.
* Label name cannot be empty.
* Label name cannot include the `-` character.
* Name length: 32 characters or less.
* Label name must start with an uppercase or lowecase letter and may contain letters, digits, the `.` and `_` characters.
* Label names and metric values cannot include any non-Latin letters.

### Metric types {#metric-types}
The {{ monitoring-full-name }} service offers the following metric types:

| Type | Description |
----- | -----
| `DGAUGE` | Numeric value (decimal). It shows the metric value at a certain point in time. For example, the amount of used RAM. |
| `IGAUGE` | Numeric value (integer). It shows the metric value at a certain point in time. |
| `COUNTER` | Counter. It shows the metric value that increases over time. For example, the number of days of service continuous running. |
| `RATE` | Derivative value. It shows the change in the metric value over time. For example, the number of requests per second. |

### Queries {#queries}

A query is an arbitrary expression in the [query language](querying.md) that results in a line or a set of lines. Query text may refer to the results of higher-level queries as variables.

{{ monitoring-name }} allows you to create queries to select a set of metrics and display them on a chart. You can also use templates as label values.

The following templates are available in {{ monitoring-name }}:

| Syntax | Description |
----- | -----
| `label="*"` | Outputs all metrics with the specified label. For example, the `host="*"` query displays all metrics with `host` label. |
| `label="glob"` | Displays all metrics whose label value matches a [glob expression](https://en.wikipedia.org/wiki/Glob_(programming)):<br/><br/>`*`: Any number of characters (including none). For example, `name="folder*"` displays all metrics that have the `name` label and whose value begins with the `folder` prefix.<br/><br/>`?`: One arbitrary character. For example, `name="metric?"` displays all labels that have one character after `metric`<br/><br/>`|`: All specified options. For example, `name="metric1|metric2"` displays two metrics with label values `metric1` and `metric2`. |




## See also {#see-also}

- [{#T}](visualization/index.md)
