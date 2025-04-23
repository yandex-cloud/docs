---
title: Idempotency in the API
description: In this article, you will learn about the idempotency mechanism and see the examples of idempotent operations.
---

# Idempotency

{{ yandex-cloud }} services support [idempotency](https://en.wikipedia.org/wiki/Idempotence). An idempotent operation returns the same result for multiple calls.

By default, some operations in the API are not idempotent, e.g., operations that change the state of resources. To make them idempotent, specify the `Idempotency-Key` header in your requests. The header must contain the UUID. Generate the UUIDs for each operation separately.

```
Idempotency-Key: <UUID>
```

We recommend using a **v4** UUID.

As soon as the service gets your request with the `Idempotency-Key` header, it will check if an operation with this UUID had been created previously. If so, the server will return the `Operation` object with this operation's current status. If no operation with this UUID is found, the service will start executing it.


{% note info %}

AI services, such as {{ foundation-models-full-name }}, {{ speechkit-full-name }}, {{ translate-full-name }}, and {{ vision-full-name }}, do no support idempotency even with the `Idempotency-Key` header.

{% endnote %}


## Examples {#examples}

The examples below demonstrate how to use idempotency when working with {{ yandex-cloud }} APIs.

### Example 1 {#example-1}
 
Let's assume you sent a start VM request:

```
POST /compute/v1/instances/e0m97h0gbq0foeuis03:start
HTTP/1.1
Host: compute.{{ api-host }}
Idempotency-Key: c1700de3-b8cb-4d8a-9990-e4ebf052e9aa
```
 
If you send this request again with the same `Idempotency-Key`, the server will not restart the VM. Instead, the server will return the `Operation` object containing the status of the operation called as a result of the first request.

### Example 2 {#example-2}
 
In this scenario, a [race condition](https://en.wikipedia.org/wiki/Race_condition) occurs.
 
Let's assume that a client sent a request to stop a running VM. No `Idempotency-Key` header was specified.

The connection failed when sending the request and the client did not receive a response from the server. The VM was stopped, but the client does not know the operation status as they have not received any response.

At the same time, another client restarts this VM, e.g., using the UI console.

However, when the first client reconnects to the internet, they will resend the stop VM request. Since there is no `Idempotency-Key` header, the VM the second client needs will be stopped.

If the first client had provided `Idempotency-Key` in their stop VM requests, the VM would not be stopped when resending the request.
