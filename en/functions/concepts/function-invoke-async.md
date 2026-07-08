---
title: Asynchronous function invocation in {{ sf-full-name }}
description: When creating a function version in {{ sf-full-name }}, you can set up asynchronous invocation to invoke the function without waiting for it to complete.
---

# Asynchronous function invocation

{% include [note-preview](../../_includes/note-preview.md) %}

When you create a new function version, you can set up asynchronous invocation to invoke the function without waiting for it to complete.

To invoke a function asynchronously, specify the `?integration=async` request string parameter. When invoked this way, a function cannot parse or set HTTP headers:
* HTTPS request body content is provided as the first argument (without converting to a JSON structure).
* HTTPS request body content is the same as the function's response (without converting and checking the structure); the HTTP response status is `202`.

You have the option to either ignore the function's output or send it to {{ message-queue-full-name }}.

## Useful links {#see-also}

* [Invoking a function asynchronously](../operations/function/function-invoke-async.md)
