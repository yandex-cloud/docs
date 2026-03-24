# Searching for traces and spans

The {{ traces-name }} interface enables you to search for traces and spans by specified criteria, view a trace by ID, and access aggregation charts by span attributes.

## Viewing a trace by ID {#open-by-id}

If you know the `trace_id`, enter it in the **{{ ui-key.yacloud_monitoring.traces.trace-id-input.placeholder }}** field in the top-right corner of the page and click **Open**. The [trace view](trace-view.md) page will open.

## Time range {#time-range}

The search is limited to the selected time range. By default, this is the last 24 hours. You can adjust this by selecting a new interval on the timeline.

## Trace search mode {#search-traces}

This mode retrieves **traces** that contain at least one span matching your query.

Enter your query in the search bar using the [query language](query-language.md) syntax. The search bar supports autocompletion: start typing an attribute name to see suggestions and select an attribute, then follow the same process to select its value.

```
{ project="foo", service="bar", span.duration>=1s }
```

The results are displayed as a list of traces. For each trace, the list shows its ID, root service, duration, and number of spans. Click the trace to [view and analyze](trace-view.md) it.

## Span search mode {#search-spans}

This mode retrieves individual **spans** meeting all criteria of your query. Use this mode to search for specific operations by attributes, regardless of their associated trace.

Span-based search supports all standard trace keys plus custom span attributes (labels). For more information on supported keys and operators, see [{#T}](query-language.md).

In addition to the span list, the page displays charts for the retrieved spans, showing span counts and duration percentiles. This data can be dynamically grouped by any attribute you select.
