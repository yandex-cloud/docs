# Idempotency

{{ yandex-cloud }} services support [idempotency](https://en.wikipedia.org/wiki/Idempotence). An idempotent operation returns the same result for multiple calls.

By default, some operations in the API do not work in an idempotent manner, e.g., operations that change the state of resources. To make them work in an idempotent manner, specify the `Idempotency-Key` header in requests. The header must contain the UUID. Generate the UUIDs for each operation separately.

```
Idempotency-Key: <UUID>
```

We recommend using a **v4** UUID.

When the service receives your request with the `Idempotency-Key` header, it checks whether an operation with this UUID has already been created. If so, the server returns the `Operation` object with this operation's current status. If no operation with this UUID is found, the service starts executing it.


{% note info %}

AI services, such as {{ yagpt-full-name }}, {{ speechkit-full-name }}, {{ translate-full-name }}, and {{ vision-full-name }}, do no support idempotency even with the `Idempotency-Key` header.

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

If you send this request again with the same `Idempotency-Key`, the server will not restart the VM. Instead, the server will return the `Operation` object with the status of the operation that was called as a result of the first request.

### Example 2 {#example-2}

In this scenario, a [race condition](https://en.wikipedia.org/wiki/Race_condition) occurs.

Let's assume that a client sent a request to stop a running VM. No `Idempotency-Key` header was specified.

The connection failed when sending the request and the client did not receive a response from the server. The VM was stopped, but the client does not know the operation status as they have not received any response.

At the same time, another client restarts this VM, e.g., using the UI console.

However, when the first client reconnects to the internet, they will resend the stop VM request. Since there is no `Idempotency-Key` header, the VM that the second client needs will be stopped.

If the first client had provided the `Idempotency-Key` in its stop VM requests, the VM would not have been stopped when the request was resent.
