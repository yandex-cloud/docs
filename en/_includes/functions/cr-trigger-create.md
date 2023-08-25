Create a [trigger for {{ container-registry-name }}](../../functions/concepts/trigger/cr-trigger.md) to call a {{ sf-name }} [function](../../functions/concepts/function.md) when you create or delete {{ container-registry-name }} [Docker images](../../container-registry/concepts/docker-image.md) or Docker image tags.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* [Registry](../../container-registry/concepts/registry.md) whose Docker image events will fire the trigger. If you don't have a registry, [create one](../../container-registry/operations/registry/registry-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **{{ container-registry-name }}**.
      * In the **Launched resource** field, select **Function**.

   1. Under **{{ container-registry-name }} settings**:

      * In the **Registry** field, select the registry where you want to create a trigger for image events.
      * In the **Event types** field, select the [events](../../functions/concepts/trigger/cr-trigger.md#event) that will fire the trigger.
      * (Optional) In the **Docker image name** field, enter an image name for [filtering](../../functions/concepts/trigger/cr-trigger.md#filter). To learn the Docker image name, [retrieve a list of Docker images in the registry](../../container-registry/operations/docker-image/docker-image-list.md).
      * (Optional) In the **Docker image tag** field, enter the [image tag](../../functions/concepts/trigger/cr-trigger.md#filter) for filtering.

   1. Under **Function settings**, select a function and specify:

      {% include [function-settings](function-settings.md) %}

   1. (Optional) Under **Repeat request settings**:

      {% include [repeat-request.md](repeat-request.md) %}

   1. (Optional) Under **Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger that invokes a function, run this command:

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
   * `--events`: [Events](../../functions/concepts/trigger/cr-trigger.md#event) activating the trigger.

   {% include [trigger-cli-param](trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s92agr8m**********
   folder_id: b1g88tflru**********
   created_at: "2020-09-08T06:26:22.651656Z"
   name: registry-trigger
   rule:
     container_registry:
       event_type:
       - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE
       - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE
       - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
       - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG
       registry_id: crtlds4tdfg12kil77**********
       invoke_function:
         function_id: d4eofc7n0m**********
         function_tag: $latest
         service_account_id: aje3932acd**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
           service-account-id: aje3932acd**********
   status: ACTIVE
   ```

- API

   To create a trigger for {{ container-registry-name }}, use the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}

## See also {#see-also}

* [Trigger for {{ container-registry-name }} that invokes a {{ serverless-containers-name }} container](../../serverless-containers/operations/cr-trigger-create.md).
