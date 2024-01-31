---
title: "Asynchronous function invocation in {{ sf-full-name }}"
description: "When you create a new function version in {{ sf-full-name }}, you can set up asynchronous invocation to invoke the function without waiting for it to complete."
---

# Asynchronous function invocation

{% include [note-preview](../../_includes/note-preview.md) %}

When you create a new function version, you can set up asynchronous invocation to invoke the function without waiting for it to complete.

To invoke a function asynchronously, specify the `?integration=async` request string parameter. When invoked this way, a function cannot parse or set HTTP headers:
* The contents of the HTTPS request body are provided as the first argument (without converting to a JSON structure).
* The contents of the HTTPS response body is identical to the function response (without converting or checking the structure) and the HTTP response status is `202`.

You have the option to either ignore the function's output or send it to {{ message-queue-full-name }}.

## See also {#see-also}

* [Invoking a function asynchronously](../operations/function/function-invoke-async.md)
