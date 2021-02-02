Create a [trigger for {{ container-registry-name }}](../../functions/concepts/trigger/cr-trigger.md) that will run your function when you create or delete [Docker images](../../container-registry/concepts/docker-image.md) of {{ container-registry-full-name }} or their tags.

To create a trigger, you need:

1. [Functions](../../functions/concepts/function.md) that the trigger will call. If you don't have a function:
    * [Create a function](../../functions/operations/function/function-create.md).
    * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).
1. [Registries](../../container-registry/concepts/registry.md) whose Docker image events will fire the trigger. If you don't have a registry, [create one](../../container-registry/operations/registry/registry-create.md).
1. The [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that the function couldn't process are moved. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).
1. A service account with rights for function call. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where you want to create a trigger.
    1. Open **{{ sf-name }}**.
    1. Go to the **Triggers** tab.
    1. Click **Create trigger**.
    1. Under **Basic parameters**:
        * Enter a name and description for the trigger.
        * In the **Type** field, select **Container Registry**.
    1. Under **Container Registry settings**:
        * In the **Registry** field, select the registry where you want to create a trigger for image events.
        * In the **Event types** field, select the [events](../../functions/concepts/trigger/cr-trigger.md#event) that will fire the trigger.
        * (optional) In the **Docker image name** field, enter the [image name](../../functions/concepts/trigger/os-trigger.md#filter) for filtering.
        * (optional) In the **Docker image tag** field, enter the [image tag](../../functions/concepts/trigger/os-trigger.md#filter) for filtering.
    1. Under **Function settings**:
        * Select the function for the trigger to call.
        * Specify the [function version tag](../../functions/concepts/function.md#tag).
        * Specify the service account to be used to call the function.
    1. Under **Repeat request settings**:
        * In the **Interval** field, specify the time after which the function will be invoked again if the current attempt fails. Acceptable values are from 10 to 60 seconds.
        * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Acceptable values are from 1 to 5.
    1. Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and service account with rights to write messages to it.
    1. Click **Create trigger**.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To create a trigger, run the command:

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

    where:
    * `--name`: Trigger name.
    * `--registry-id`: [Registry ID](../../container-registry/operations/registry/registry-list.md).
    * `--events`: [Events](../../functions/concepts/trigger/cr-trigger.md#event) that will fire the trigger.
    * `--invoke-function-id`: Function ID.
    * `--invoke-function-service-account-id`: Service account with rights to call the function.
    * `--retry-attempts`: The time after which the function will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
    * `--retry-interval`: The number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.
    * `--dlq-queue-id`: ID of the [Dead Letter Queue](../../functions/concepts/dlq.md).
    * `--dlq-service-account-id`: Service account with rights to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md).

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
            queue-id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:dlq
            service-account-id: aje3932acd0c5ur7dagp
    status: ACTIVE
    ```

- API

    You can create a trigger for {{ container-registry-name }} using the [create](../../functions/triggers/api-ref/Trigger/create.md) API method.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}

