# Handling errors in the {{ yandex-cloud }} API

If an operation completes successfully, the server returns the OK status to the client. If an error occurs during the operation, the server returns a message with the error description.

{% include [errors-handling](../../_includes/errors-handling.md) %}

## Handling asynchronous errors {#async-errors}

When asynchronous operations are called, the server returns the [Operation](operation.md) object. If an error occurs, the `Status` message is added to the `Operation` object in the `error` field.
