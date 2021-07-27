---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
{% include [errors-handling](../../_includes/errors-handling.md) %}

## Handling asynchronous errors {#async-errors}

When asynchronous operations are called, the server returns the [Operation](operation.md) object. If an error occurs, the `Status` message is added to the `Operation` object in the `error` field.

