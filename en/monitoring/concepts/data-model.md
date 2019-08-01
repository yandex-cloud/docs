# Data model

{{ monitoring-full-name }} stores data as [time series](https://en.wikipedia.org/wiki/Time_series).

## Metrics {#metric}

_Metrics_ are time series that show a change of some value over time. For example, the status of a Yandex.Cloud resource: the amount of space used on the disk, the speed that data is transferred at over the network, and so on. Metrics are identified using text labels.

### Labels {#label}

_A label_ is a metric characteristic in `key: "value"` format. Each metric is identified by an unordered set of labels. Use a parameter that takes a limited set of values as a label. For example, the HTTP status code, the types of procedures being performed in a database, and so on.

The service has mandatory and optional labels. Mandatory labels:

- `project` — The ID of the cloud that the resource belongs to.
- `cluster` — The ID of the folder that the resource belongs to.
- `service` — Indicates the Yandex.Cloud service that the resource belongs to. For example, `compute` or `managed-postgresql`.

{% note important %}

When writing custom metrics, you should specify the `custom` value in the `service` label.

{% endnote %}

### Metric types {#metric-types}

The {{ monitoring-full-name }} service offers the following metric types:

| Type | Description |
| ----- | ----- |
| `DGAUGE` | Numeric value (double). It shows the metric value at a certain point in time. For example, the amount of used RAM |
| `IGAUGE` | Numeric value (integer). It shows the metric value at a certain point in time. |
| `COUNTER` | Counter. It shows the metric value that monotonically increases over time. For example, the number of days of service continuous running. |
| `RATE` | Derivative value. It shows the change in the metric value over time. For example, the number of requests per second. |

### Queries {#queries}

{{ monitoring-full-name }} allows you to create queries to select a set of metrics and display them on a chart. You can also use templates as label values.

The following templates are available in {{ monitoring-full-name }}:

| Syntax | Description |
| ----- | ----- |
| `label="*"` | Outputs all metrics with the specified label. For example, the `host="*"` query displays all metrics with `host` label. |
| `label="glob"` | Displays all metrics whose label satisfy [glob expression](https://en.wikipedia.org/wiki/Glob_(programming)):<br/><br/>`*` — Any number of characters (including none). For example, `name="folder*"` displays all metrics that have the `name` label and whose value begins with the `folder` prefix.<br/><br/>`?` — One arbitrary character. For example, `name="metric?"` displays all labels that have one character after `metric`<br/><br/>`|` — All specified options. For example, `name="metric1|metric2"` displays two metrics with label values `metric1` and `metric2`. |

For an example of a metric request, see [#T](../operations/chart/create-query.md).

#### See also

- [#T](visualization/index.md)

