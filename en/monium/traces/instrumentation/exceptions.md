# Handling errors

When an operation throws an exception, a span must log the `ERROR` status and the `exception` event with the error details. Spans with the `ERROR` status are highlighted in the {{ traces-name }} interface and can be filtered.

For information about the basic error handling pattern, see [{#T}](manual.md#status). This page describes the `exception` event attributes based on the [OpenTelemetry specification](https://opentelemetry.io/docs/specs/semconv/exceptions/exceptions-spans/).

## Exception event attributes {#attributes}

For example, in Python, calling `record_exception` creates an `exception` event with the following attributes:

#|
|| Attribute | Description ||
|| `exception.type` | Exception type: `OSError`, `ValueError`, or `java.lang.RuntimeException` ||
|| `exception.message` | Error message: `Can't convert 'int' object to str implicitly` ||
|| `exception.stacktrace` | Exception stack trace ||
|#

For a full list of attributes, see the [OpenTelemetry specification for exception events](https://opentelemetry.io/docs/specs/semconv/exceptions/exceptions-spans/).

## Example {#example}

The `parse_message` operation fails with an error:

#|
|| Attribute | Value ||
|| Name | `parse_message` ||
|| Kind | `INTERNAL` ||
|| Status | `ERROR` ||
|| `exception.type` | `ValueError` ||
|| `exception.message` | `Can't convert 'int' object to str implicitly` ||
|| `exception.stacktrace` | `Traceback (most recent call last): ...` ||
|#
