To create a trigger, you need:

* A function that the trigger will invoke. If you don't have a function:

   * [Create a function](../../functions/operations/function/function-create.md).
   * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).

* (optional) A [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that could not be processed by a function will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights to invoke the function and (optionally) write messages to the Dead Letter Queue. You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).
