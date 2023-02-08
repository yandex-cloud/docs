# Working with operations

Any operations that change the state of a resource are [asynchronous signature](async.md) operations. When they are called, the server returns the `Operation` object. Use this object for [operation status monitoring](operation.md#monitoring).

All asynchronous operations support _idempotency_. This means that if the same operation is called multiple times, the server performs this operation only once. For information about how idempotency works and how it can be used, see the section [Idempotency](idempotency.md).
