Create a {{ container-registry-full-name }} trigger to call a {{ serverless-containers-name }} [container](../../serverless-containers/concepts/container.md) when you create or delete {{ container-registry-name }} [Docker images](../../container-registry/concepts/docker-image.md) or Docker image tags.

For information about creating a trigger for {{ container-registry-name }} to call a function, see the [{{ sf-name }} documentation](../../functions/operations/trigger/cr-trigger-create.md).

## Before you begin {#before-begin}

{% include [trigger-before-you-begin](./trigger-before-you-begin.md) %}

* [Registry](../../container-registry/concepts/registry.md) whose Docker image events will fire the trigger. If you don't have a registry, [create one](../../container-registry/operations/registry/registry-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../functions/trigger-time.md) %}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.
  1. Select **{{ serverless-containers-name }}**.
  1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.
  1. Click **Create trigger**.
  1. Under **Basic parameters**:
     * Enter a name and description for the trigger.
     * In the **Type** field, select **Container Registry**.
     * In the **Launched resource** field, select **Container**.
  1. Under **Container Registry settings**:
     * In the **Registry** field, select the registry where you want to create a trigger for image events.
     * In the **Event types** field, select the [events](../../functions/concepts/trigger/cr-trigger.md#event) that will fire the trigger.
     * (optional) In the **Docker image name** field, enter an image name [to filter for](../../functions/concepts/trigger/cr-trigger.md#filter). To get the name of a Docker image, [retrieve a list of Docker images in the registry](../../container-registry/operations/docker-image/docker-image-list.md).
     * (optional) In the **Docker image tag** field, enter the [image tag](../../functions/concepts/trigger/cr-trigger.md#filter) for filtering.
  1. Under **Container settings**, select a container and specify:
     * A [container revision](../../serverless-containers/concepts/container.md#revision);
     * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the container.
  1. (optional) Under **Repeat request settings**:
     * In the **Interval** field, specify the time delay for the container to be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
     * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.
  1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.
  1. Click **Create trigger**.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}