# Asynchronous operations

Any operations that change the state of a resource (create, change, or delete it) are asynchronous operations. This means that when they are called, the server returns the [Operation](operation.md) object.

The `Operation` object contains information about the operation: its status, ID, creation date, and so on. You can use this object for [operation status monitoring](operation.md#monitoring). The operation status is displayed in the `done` field. If the field value is <q>true</q>, the operation is completed; otherwise, the operation is still in progress.

{% include [create-operation-response](../_includes/create-operation-response.md) %}

If an error occurs while performing an asynchronous operation, the server aborts all running procedures and returns the system to the previous state. The resources created during the operation are deleted. The `Operation` object has the additional `error` field describing the error. However, the operation is considered completed only when the system entirely rolls back to the previous state. For more information, see the [Operation object description](operation.md).

