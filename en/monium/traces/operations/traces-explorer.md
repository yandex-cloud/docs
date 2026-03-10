---
title: Viewing your applications' traces in {{ monium-name }}
description: Follow this guide to view detailed traces for your applications.
---

# Viewing your applications' traces in {{ traces-name }}

The tracing interface enables you to:

* View traces by ID.
* Search for spans and traces by various criteria.
* Build aggregated charts based on span attributes.

## Searching and viewing traces

{% list tabs group=instructions %}

- Management console {#console}

  1. Set up data delivery, e.g., with the [OTel Collector](../../collector/opentelemetry.md).
  1. On the [{{ monium-name }} home page]({{ link-monium }}), select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}** on the left.
  1. At the top, set the search interval using the timeline, a preset interval, or by entering the time value directly.
  1. Select **{{ ui-key.yacloud_monitoring.traces.traces-search.mode.traces }}** or **{{ ui-key.yacloud_monitoring.traces.traces-search.mode.spans }}**.
  1. To open a trace, specify its ID in the **{{ ui-key.yacloud_monitoring.traces.trace-id-input.placeholder }}** field at the top right.
  1. To search for a trace or span, enter your [query](../../concepts/querying.md) in the search bar using this format:

       ```
       { <key>="<value>", <key>="<value>", ... }
       ```

       Traces and spans have their own keys. You can either enter the key manually or select it from the list if available. The search uses [operations](#operations) to match keys with values.

{% endlist %}

## Query string operations {#operations}

{% include [query-operations](../../../_includes/monium/query-operations.md) %}

## Searching for traces {#traces-search}

### Searching for traces by parameters {#parameters-search}

By default, the search covers the last 24 hours, but you can change the interval as needed.

The results will include traces that have _at least one span matching the search criteria_.

Supported keys:

* `project="value"`: `value` project spans allowing the `=` operator. This is a required key.
* `service="value"`: `value` service spans supporting all [string operators](#strings).
* `cluster="value"`: `value` cluster spans supporting all string operators.
* `span.name="value"`: Spans with the specified name, using all string operators.
* `span.id="value"`: Spans with the specified ID, using the `=` and `!=` operators.
* `span.status="(OK)|(ERROR)|(UNKNOWN)"`: Spans with the specified status, using the `=` and `!=` operators.
* `span.duration>duration_string`: Spans with the specified duration, using the [duration operators](#duration).

All other keys will be interpreted as [labels](#labels-search).

##### Query examples {#parameters-search-examples}

Search for traces containing spans from the `foo` project:
```
{ project="foo" }
```

Search for traces containing spans from the `foo` project and from the `bar` service:
```
{ project="foo", service="bar" }
```

Search for traces containing spans with the `some_process` name from the `foo` project:
```
{ project="foo", span.name="some_process" }
```

Search for traces containing spans from the `foo` project and from the `bar` service, each lasting more than one second:
```
{ project="foo", service="bar", span.duration>=1s }
```

Search for traces containing spans from the `foo` project and from the `bar` service, each having the `fizz` label set to `buzz`:
```
{ project="foo", service="bar", "fizz"="buzz" }
```

Search for traces containing spans from the `foo` project and from the `bar` service that have the `mark` and `tag` labels set to `test` and `best`, respectively:
```
{ project="foo", service="bar", "fizz"="test", "tag"="best" }
```

## Searching for spans within a trace {#spans-search}

The search focuses on a single trace you select. The results will include spans meeting _all_ search criteria.

Supported keys:

* `project="value"`: `value` project spans allowing the `=` operator. This is a required key.
* `service="value"`: `value` service spans supporting all [string operators](#strings).
* `span.name="value"`: Spans with the specified name, using all string operators.
* `span.id="value"`: Spans with the specified ID, using the `=` and `!=` operators.
* `span.status="(OK)|(ERROR)|(UNKNOWN)"`: Spans with the specified status, using the `=` and `!=` operators.
* `span.critical_path="(PRESENT)|(ABSENT)"`: Spans, both on and off the critical path, using the `=` operator.
* `span.duration>duration_string`: Spans with the specified duration, using the [duration operators](#duration).

All other keys will be interpreted as [labels](#labels-search).

##### Query examples {#spans-search-examples}

Search for all spans with an error:
```
span.status="ERROR"
```

Search for spans with an error in the `foo` service:
```
span.status="ERROR", service="foo"
```

## Searching by labels {#labels-search}

### Searching for spans

By default, the search covers the last 24 hours, but you can change the interval as needed.

The results will include spans meeting all search criteria.

The `<key>="<value>"` query will return spans containing the `<key>` label set to `<value>`. All [string operators](#labels-search) are supported.

You can specify `*` and `-` for the `<value>`.

* The `some_label="*"` selector will find all spans that have the `some_label` label, regardless of its value.
* The `some_label="-"` selector will find all spans without the `some_label` label.

If you specify multiple labels, the search will find spans that include every listed label.

## Incomplete traces

Some traces show an incomplete data warning. This means that certain spans are missing in the system or in the interface, which distorts the view of the request execution path.

A trace can be marked as incomplete:

* When the root span is missing.
* When more than one root span appears because the parent span is missing.

Reasons for missing spans in the tracing system:

* The application fails to send spans, e.g., during a crash, such as an OOM or segfault.
* Spans contain validation errors.
* The project exceeds its quotas.

Reasons for missing spans in the interface:

* Duplicated `span.id`: Manual ID generation causes the interface to show only the first span with that ID.
* Your trace exceeds the limit of 100,000 spans: The system only shows the spans within this limit.

## Span links {#span-links}

A span can be linked to one or more other spans defined in `SpanContext`. A link may reference a span within the same trace or from a different one. Links can be used to represent batch operations where multiple parent spans initiate a single span.

For more information on how to use span links via the API, see [this OTEL guide](https://opentelemetry.io/docs/specs/otel/trace/api/#link).

The interface shows span links alongside the span name.

## Span events {#span-events}

A span can be labeled with one or more events. Each event contains `key:value` pairs and a timestamp.

You can use events to send information related to the span, such as error messages.

Events are not searchable. If you need to search for events, move them to logs and use log search.

Span events are marked with a triangle icon and can be viewed in the span details.

## Critical path of a request {#critical-path}

In a distributed system, a request goes through a chain of operations (spans) across different services. Tracing renders this path as a graph of spans, where each operation adds to the total execution time.

The critical path is the span sequence that drives the total request execution time. It consists of operations that directly affect the request completion time. Optimizing spans on this path shortens the total execution time and makes it a key focus for performance improvements.

{% cut "How the calculation works" %}

Critical path calculation operates under the following conditions:

* The parent span initiates its child spans.
* The parent span waits for all child spans to finish.
* If the trace structure violates these conditions, such as in asynchronous calls, the critical path may be calculated incorrectly.

{% endcut %}

Critical path segments are highlighted on spans with black lines. When hovering over a span, you can see the operation duration and the total time the span spent on the critical path. You can use the span search selector to filter spans.

### Critical path calculation algorithm {#critical-path-algorithm}

To determine the critical path, the algorithm traverses the span tree starting from the root. Child spans are sorted by end time in descending order. The algorithm picks the last finishing child (LFC). This span lies on the critical path, as the parent span waited for it to complete before proceeding. The algorithm then recurses on the LFC. After recursion, the algorithm selects the next LFC that finished before the previous LFC started, ensuring spans do not overlap.

### Limitations {#critical-path-limitations}

The critical path is calculated for traces with a single root span. If a trace lacks a root span or has multiple root spans, the critical path will not be calculated.
