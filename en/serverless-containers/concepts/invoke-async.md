---
title: Asynchronous container invocation in {{ serverless-containers-full-name }}
description: When creating a container revision in {{ serverless-containers-name }}, you can set up an asynchronous invocation of your container without waiting for the request to complete.
---

# Asynchronous container invocation

{% include [note-preview](../../_includes/note-preview.md) %}

When creating a [container](container.md) revision, you can set up an asynchronous invocation of your container without waiting for the request to complete.

To invoke a container asynchronously, do the following:

* When creating a revision, specify the service account to invoke the container.
* When invoking, specify the `X-Ycf-Container-Integration-Type: async` header.

For this method, invocation headers will be provided to the [HTTP server](container.md#runtime). The HTTP status on successful invocation is `202`.

{% note warning %}

Containers do not support sending results to a {{ message-queue-full-name }}, but you can implement it inside the container.

{% endnote %}


## See also {#see-also}

* [Invoking a container asynchronously](../operations/invoke-async.md)
