To create a trigger, you need:
* A container that the trigger will launch. If you don't have a container:
  * [Create a container](../../serverless-containers/operations/create.md).
  * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).
* (optional) A [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that could not be processed by a container will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).
* [Service account](../../iam/concepts/users/service-accounts.md) with rights to invoke the container and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).