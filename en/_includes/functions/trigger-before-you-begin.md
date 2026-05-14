To create a trigger, you will need:

* Function the trigger will invoke. If you do not have a function:

    * [Create a function](../../functions/operations/function/function-create.md).
    * [Create a function version](../../functions/operations/function/version-manage.md).

* Optionally, a [dead-letter queue](../../functions/concepts/dlq.md) where to redirect the messages the function failed to process. If you do not have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with permissions to invoke the function and, optionally, write to the dead letter queue. You can use the same service account or different ones. If you do not have a service account, [create one](../../iam/operations/sa/create.md).
