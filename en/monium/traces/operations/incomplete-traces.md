---
title: Incomplete traces
description: Find out why traces are incomplete and learn how to diagnose data delivery issues.
---

# Incomplete traces

A trace is considered incomplete if the system fails to build a full span tree, typically because the root span or certain parent spans are missing.

## Causes of incomplete traces {#causes}

### Missing root span {#no-root-span}

A root span is a parentless span that marks the start of a trace. The system displays a trace as incomplete if the root span is not delivered, fails validation, or originates from an uninstrumented service.

### Missing parent spans {#missing-parent-spans}

If a child span is missing its parent in the tree, the system cannot link spans correctly. This typically results from context propagation errors between services or when the parent span is rejected during validation.

### Span limit exceeded {#span-limit}

The UI displays up to 100,000 spans per trace. Any spans exceeding this limit are omitted, which may cause the trace to appear incomplete.

## Troubleshooting {#diagnostics}

### Checking data delivery {#check-delivery}

1. Make sure all services in the call chain are instrumented and sending data.
1. Review agent logs (OpenTelemetry Collector or {{ unified-agent-short-name }}) for data delivery errors.
1. Check trace delivery metrics on the _Monium – Traces overview_ service dashboard.

### Checking validation {#check-validation}

Spans may be rejected during validation for the following reasons:
* Missing required fields (`trace_id`, `span_id`, timestamps, etc.).
* Invalid field value format (e.g., incorrect `trace_id` format).
* Exceeded span or attribute size limit.

Learn more about validation rules [here](../limits.md).

### Checking context propagation {#check-propagation}

Make sure trace context is correctly propagated across services:
* HTTP interactions use `traceparent` and `tracestate` headers.
* For asynchronous operations, context is included in message metadata.
* All services use compatible OpenTelemetry SDK versions.
