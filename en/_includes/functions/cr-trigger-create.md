Create a [trigger for {{ container-registry-full-name }}](../../functions/concepts/trigger/cr-trigger.md) that calls a {{ sf-name }} [function](../../functions/concepts/function.md) when you create or delete {{ container-registry-name }} [Docker images](../../container-registry/concepts/docker-image.md) or their tags.

For more information about creating a trigger for {{ container-registry-name }} that calls a container, see the [{{ serverless-containers-full-name }} documentation](../../serverless-containers/operations/cr-trigger-create.md).

## Before you begin {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* [Registry](../../container-registry/concepts/registry.md) whose Docker image events will fire the trigger. If you don't have a registry, [create one](../../container-registry/operations/registry/registry-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Container Registry**.
      * In the **Launched resource** field, select **Function**.

   1. Under **Container Registry settings**:

      * In the **Registry** field, select the registry where you want to create a trigger for image events.
      * In the **Event types** field, select the [events](../../functions/concepts/trigger/cr-trigger.md#event) that will fire the trigger.
      * (optional) In the **Docker image name** field, enter an image name [to filter for](../../functions/concepts/trigger/cr-trigger.md#filter). To get the name of a Docker image, [retrieve a list of Docker images in the registry](../../container-registry/operations/docker-image/docker-image-list.md).
      * (optional) In the **Docker image tag** field, enter the [image tag](../../functions/concepts/trigger/cr-trigger.md#filter) for filtering.

   1. Under **Function settings**, select a function and specify:

      * [Tag of the function version](../../functions/concepts/function.md#tag);
      * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the function will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  To create a trigger that launches a function, run the command:

  ```bash
  yc serverless trigger create container-registry \
    --name <trigger name> \
    --registry-id <registry ID> \
    --events 'create-image', 'delete-image', 'create-image-tag', 'delete-image-tag' \
    --invoke-function-id <function ID> \
    --invoke-function-service-account-id <service account ID> \
    --retry-attempts 1 \
    --retry-interval 10s \
    --dlq-queue-id <Dead Letter Queue ID> \
    --dlq-service-account-id <service account ID>
  ```

  Where:
  * `--name`: Trigger name.
  * `--registry-id`: [Registry ID](../../container-registry/operations/registry/registry-list.md).
  * `--events`: [Events](../../functions/concepts/trigger/cr-trigger.md#event) after which the trigger activates.
  * `--invoke-function-id`: Function ID.
  * `--invoke-function-service-account-id`: Service account with rights to invoke the function.
  * `--retry-attempts`: The time after which the function will be invoked again if the current attempt fails. Optional. Values can be from 10 to 60 seconds. The default is 10 seconds.
  * `--retry-interval`: The number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional. Values can be from 1 to 5. The default is 1.
  * `--dlq-queue-id`: [Dead Letter Queue](../../functions/concepts/dlq.md) ID. Optional.
  * `--dlq-service-account-id`: Service account with rights to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional.

  Result:

  ```
  id: a1s92agr8mpgeo3kjt48
  folder_id: b1g88tflru0ek1omtsu0
  created_at: "2020-09-08T06:26:22.651656Z"
  name: registry-trigger
  rule:
    container_registry:
      event_type:
      - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE
      - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE
      - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
      - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG
      registry_id: crtlds4tdfg12kil77sdfg345ghj
      invoke_function:
        function_id: d4eofc7n0m03lmudsk7y
        function_tag: $latest
        service_account_id: aje3932acd0c5ur7drte
        retry_settings:
          retry_attempts: "1"
          interval: 10s
        dead_letter_queue:
          queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknnpj1ll45e:dlq
          service-account-id: aje3932acd0c5ur7dagp
  status: ACTIVE
  ```

- API

  You can create a trigger for {{ container-registry-name }} using the [create](../../functions/triggers/api-ref/Trigger/create.md).

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}