# {{ traces-name }} limits and features

For proper trace handling, follow the {{ traces-name }} limits and configuration rules when sending data.

## Storage limits {#storage-limits}

The system retains data on all spans for `4 days`.

## Write limits {#write-limits}

* The maximum size of a span batch is `4 MB`.

* Both the start (`startTimeUnixNano`) and end (`endTimeUnixNano`) times of a span are required.

* The span start time (`startTimeUnixNano`) can be in the past, but no more than `24 hours` ago.

* The span end time (`endTimeUnixNano`) can be in the future, but no more than `1 hour` ahead.

* The `service.name` field is required in the [span attributes](https://github.com/open-telemetry/opentelemetry-proto/blob/f674adf15f7e779c6b83ef0dce240fa286b860d8/opentelemetry/proto/trace/v1/trace.proto#L71).

* `TraceId` and `SpanId` of a span cannot be empty strings.

* The span `name` is required and cannot be longer than `2,048` characters.

* The maximum number of span `attributes` is `512`.

* The maximum length of each attribute name is `256` characters.

* The maximum length of each attribute value is `2,097,152` characters.

* The maximum number of span `events` is `256`.

* `events` attributes follow the same limits as span attributes.

## Read limits {#read-limits}

The trace viewer displays up to `100,000` spans.

For larger traces, you can split them into multiple traces and link them using [span links](https://opentelemetry.io/docs/concepts/signals/traces/#span-links).