# Viewing and analyzing traces

The trace view page displays the end-to-end request path: from the root span to final operations. To open a trace, use [search](traces-explorer.md) or type in its `trace_id`.

## Gantt chart {#gantt}

The trace is visualized as a Gantt chart, where each horizontal bar represents a span and its length indicates the operation duration. Nested spans are positioned beneath their parents, forming a call tree. Any spans with errors are highlighted in color.

## Span details {#span-details}

Click a span to open its details. The information is organized into tabs:

* **Attributes**: Key-value pairs added during instrumentation: HTTP method, URL, database table name, etc.
* **Events**: Timestamped data recorded within the span (e.g., an `exception` event).
* **Links**: References to associated spans within the same or a different trace. They are used in [asynchronous operations](../instrumentation/async.md). If a span has links, they are displayed next to its name.

The following actions are available from the span details:

* **Share**: Copies a link to the selected span to your clipboard.
* **Go to logs**: Opens logs for with the span or entire trace. For more information, see [{#T}](traces-logs.md).

## Analysis strategies {#strategies}

### Top-down {#top-down}

Use this approach when you lack prior context, e.g., when you receive a `trace_id` from an alert or a user. Start at the root span and follow the request’s path through each service to pinpoint latency hotspots or the exact point of failure.

### Bottom-up {#bottom-up}

Use this when you are investigating a specific service or operation. Use the [in-trace search bar](query-language.md) to find relevant spans: matching spans will be highlighted.

## Interface actions {#actions}

* **Show only found results**: Hides irrelevant spans, displaying only those that match your search.
* **Spans with errors**: Filters the trace to show only spans with `ERROR` status.
* **Spans on critical path**: Displays spans affecting the total request execution time. For more information, see [{#T}](critical-path.md).
* **Share**: Copies a link to the trace to your clipboard. If a specific span is open, the link will point directly to that span.
