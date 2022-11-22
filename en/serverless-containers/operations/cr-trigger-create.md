# Creating a trigger for {{ container-registry-full-name }}

Create a [trigger for {{ container-registry-name }}](../concepts/trigger/cr-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when you create or delete {{ container-registry-full-name }} [Docker images](../../container-registry/concepts/docker-image.md) or Docker image tags.

## Before you begin {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Registry](../../container-registry/concepts/registry.md) whose Docker image events will fire the trigger. If you don't have a registry, [create one](../../container-registry/operations/registry/registry-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

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
      * In the **Event types** field, select the [events](../concepts/trigger/cr-trigger.md#event) that will fire the trigger.
      * (optional) In the **Docker image name** field, enter an image name [to filter for](../concepts/trigger/cr-trigger.md#filter). To get the name of a Docker image, [retrieve a list of Docker images in the registry](../../container-registry/operations/docker-image/docker-image-list.md).
      * (optional) In the **Docker image tag** field, enter the image tag for filtering.

   1. Under **Container settings**, select a container and specify:

      {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (optional) Under **Repeat request settings**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (optional) **Under Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also

* [Trigger for {{ container-registry-name }} that calls a {{ sf-name }} function](../../functions/operations/trigger/cr-trigger-create.md).
