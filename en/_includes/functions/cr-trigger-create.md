Create a [{{ container-registry-name }} trigger](../../functions/concepts/trigger/cr-trigger.md) that calls a {{ sf-name }} [function](../../functions/concepts/function.md) or {{ serverless-containers-name }} [container](../../serverless-containers/concepts/container.md) when you create or delete {{ container-registry-full-name }} [Docker images](../../container-registry/concepts/docker-image.md) or their tags.

To create a trigger, you need:

* A function or a container the trigger will launch.

   * If you don't have a function:

      * [Create a function](../../functions/operations/function/function-create.md).
      * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).

   * If you don't have a container:

      * [Create a container](../../serverless-containers/operations/create.md).
      * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).

* [Registry](../../container-registry/concepts/registry.md) whose Docker image events will fire the trigger. If you don't have a registry, [create one](../../container-registry/operations/registry/registry-create.md).

* (optional) A [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that could not be processed by a function or a container will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service account](../../iam/concepts/users/service-accounts.md) with rights to invoke a function or a container and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

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
      * Choose what the trigger will launch — a function or a container.

   1. Under **Container Registry settings**:

      * In the **Registry** field, select the registry where you want to create a trigger for image events.
      * In the **Event types** field, select the [events](../../functions/concepts/trigger/cr-trigger.md#event) that will fire the trigger.
      * (optional) In the **Docker image name** field, enter the [image name](../../functions/concepts/trigger/cr-trigger.md#filter) for filtering.
      * (optional) In the **Docker image tag** field, enter the [image tag](../../functions/concepts/trigger/cr-trigger.md#filter) for filtering.

   1. If the trigger launches:

      * A function, select one under **Function settings** and specify:

         * [Tag of the function version](../../functions/concepts/function.md#tag);
         * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

      * A container, select one under **Container settings** and specify:

         * [A container revision](../../serverless-containers/concepts/container.md#revision);
         * [A service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the container.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the function or the container will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges to this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger that launches a function, run the command:

   ```
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
