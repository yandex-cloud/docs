---
title: Trace-to-log correlation
description: 'Two-way integration of traces and logs: navigate from a log to a trace using trace_id/span_id, and from a trace to logs through the interface.'
---

# Trace-to-log correlation

Traces and logs describe the same application from different perspectives: traces show the request's path through services and operations, whereas logs capture events and messages in each component. In {{ monium-name }}, logs and traces are linked: from a log, you can navigate to a trace or span, and from a trace or span to related logs. This gives you the full context of the request from the same place to help you diagnose the problem faster.

Most OpenTelemetry instrumentation libraries automatically add trace IDs to log entries:

* `trace_id`: Trace ID.
* `span_id`: Span ID.

Here is an example of a log entry in JSON format with tracing context:

```json
{
  "level": "INFO",
  "time": "2026-02-18T13:58:22.200Z",
  "project": "folder__{{ folder-id-example }}",
  "cluster": "default",
  "service": "frontend-proxy",
  "host": "frontend-proxy-f55dc9f55-ktxwv",
  "message": "Request successfuly served",
  "span_id": "a4df8085ed748a6b",
  "trace_id": "7d069c8223d982cd72e549860de9d210",
  "labels": {
    "k8s.deployment.name": "frontend-proxy",
    "k8s.namespace.name": "default",
    "k8s.node.name": "cl1c63baqn6458a167ec-omor"
  }
}
```

Field names in logs may vary depending on the delivery format, e.g., `trace.id` and `span.id` instead of `trace_id` and `span_id`. To navigate to a trace, use the ID value.

## Searching for traces by logs {#search-traces-by-logs}

To open a trace or span by log and view the full request execution context:

1. Open the logs page and locate the entry you need. For more information on viewing logs, see [{#T}](../../logs/logs-explorer.md).
1. In the entry, find the field with the trace ID (`trace_id` or `trace.id`) or span ID (`span_id` or `span.id`) and click its value.

This will open the [trace view](trace-view.md) page with the selected span or the root span of the trace.

## Searching for logs by traces {#search-logs-by-traces}

To find all logs related to a trace or particular span:

1. Open the trace you need in the [trace search](traces-explorer.md) and select the span on the [trace view page](trace-view.md).
1. In the right-hand span details panel, click **Go to logs** and select **Trace logs** or **Span logs**.

This will open the [{#T}](../../logs/logs-explorer.md) page with a filter by `trace_id` or `trace_id` and `span_id` already set.
