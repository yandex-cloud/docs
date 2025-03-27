To create a trigger, you will need:

* A container that the trigger will invoke. If you do not have a container:

    * [Create a container](../../serverless-containers/operations/create.md).
    * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).

* Optionally, a [dead letter queue](../../serverless-containers/concepts/dlq.md) where messages that could not be processed by a container will be redirected. If you do not have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service account](../../iam/concepts/users/service-accounts.md) with rights to invoke the container and (optionally) write messages to the dead letter queue. You can use the same service account or different ones. If you do not have a service account, [create one](../../iam/operations/sa/create.md).
