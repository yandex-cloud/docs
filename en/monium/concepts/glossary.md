# Basic terms in {{ monium-name }}

This section describes the terms used in {{ monium-name }} and its guides.

## Common terms in {{ monium-name }} {#common-terms}

### Quick links {#project-menu}

_Quick links_ are links displayed in the {{ monium-name }} interface that you can configure for each [project](#project) via the UI or API.

### Timeseries {#timeseries}

_Timeseries_ is a time-ordered set of values of a variable with a timestamp for each measurement: `[[(time_stamp_1, value_1), (time_stamp_2, value_2), ...]`. For more information, see [{#T}](data-model.md).

### Chart {#graph}

1. Visual representation of a set of [metrics](#metric).
1. [Dashboard](#dashboard) element.

### Dashboard {#dashboard}

_Dasboard_ is a {{ monium-name }} configuration object that includes sets of [charts](#graph) and their display settings.

### Cluster {#cluster}

_Cluster_ is a {{ monium-name }} configuration object defining the set of hosts {{ monium-name }} will poll to collect metrics in metric Pull mode. The cluster is usually aligned with the environment (installation) of the client application delivering the metrics, e.g., production, test, or regional clusters.

### Label {#label}

_Label_ is a pair of strings in `<name>="<value>"` format, e.g., `host="monitoring-kfront-man-00"` or `code="200"`. Labels describe various slices used to visualize metrics delivered to {{ monium-name }}. A set of labels identify a [metric](#metric). For more information, see [{#T}](data-model.md).

### Metric {#metric}

_Metric_ is a [timeseries](#timeseries) and its identifying set of [labels](#label) enclosed in curly brackets.

### Dashboard parameter {#dashboard-param}

_Dashboard parameters_ let you create interactive dashboards whose content changes depending on the user's choice. For example, a dashboard presenting aggregated VM status information can be parameterized using the VM ID.

### Project {#project}

_Project_ is a top-level {{ monium-name }} configuration object containing observation data. It is used for logical grouping of related services and assignment of access permissions for telemetry data to project teams. A project can contain data on resources of an individual [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), in which case the project ID format is `folder_<folder_ID>`. With a project, you can restrict access to data by assigning [roles](../../iam/concepts/access-control/roles.md).

### Decimation {#downsampling}

1. _Read data decimation_ is a mechanism that limits the number of data points on the [chart](#graph). For more information, see [{#T}](decimation.md#reading-decimation).

1. _Historical data decimation_ is a mechanism used to archive historical data in {{ monium-name }}. To reduce the amount of stored historical data, all metrics saved in {{ monium-name }} get aggregated on a 5-minute grid after a week. For more information, see [{#T}](decimation.md#history-decimation).

### Service {#service}

_Service_ is a {{ monium-name }} configuration object that defines the methods used to deliver data to {{ monium-name }} (Pull or Push). The service is usually aligned with the client application delivering the metrics, e.g., a web server, database, or another component.

### Shard {#shard}

_Shard_ is a {{ monium-name }} configuration object that owns the metrics from a particular [service](#service)-[cluster](#cluster) pair, as well as their storage settings, e.g., [TTL](#ttl).

### Expression Language {#query-language}

_Expression Language_ (or simply Expression) is a method to describe how to calculate and transform metrics when configuring charts and alerts and exporting data over the API. For more information, see [{#T}](querying.md).

### TTL (Time-to-Live) {#ttl}

_TTL_ is a mechanism used to automatically delete obsolete metrics that have not been receiving new values for a given period of time.

For example, a TTL of 7 means that metrics whose last point's timestamp is more than 7 days in the past will be automatically deleted.

For more information, see [{#T}](#ttl)

### Unified Agent {#unified-agent}

_Unified Agent_ is a program used to collect, store, transform, and deliver metrics and logs to {{ monium-name }}.

## Logging terms {#logging-terms}

{% include notitle [logging-terms](../logs/concepts/glossary.md) %}

## Tracing terms {#tracing-terms}

{% include [tracing-terms](../../_includes/monium/tracing-terms.md) %}