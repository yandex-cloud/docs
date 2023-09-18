# Creating a trigger for {{ cloud-logging-name }} that invokes a {{ serverless-containers-name }} container

Create a [trigger for {{ cloud-logging-name }}](../concepts/trigger/cloud-logging-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when entries are added to a [log group](../../logging/concepts/log-group.md).

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* The log group that activates the trigger when records are added to it. If you don't have a log group, [create one](../../logging/operations/create-group.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Open **{{ serverless-containers-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **{{ cloud-logging-name }}**.
      * In the **Launched resource** field, select **Container**.

   1. Under **{{ cloud-logging-name }} settings**, specify:

      * The log group.
      * (Optional) Resource types: {{ yandex-cloud }} or your services, such as, `serverless.function`.
      * (Optional) IDs of {{ yandex-cloud }} or your resources, such as {{ serverless-containers-name }} containers.
      * (Optional) Logging levels.

      A trigger activates when records that match all the optional settings are added to the specified log group. If an optional setting is undefined, the trigger activates for any value of the setting.

   1. (Optional) Under **Batch message settings**, specify:

      * Batch size. The values may range from 1 to 100. The default value is 1.
      * Maximum wait time. The values may range from 1 to 60 seconds. The default value is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a container. However, the number of messages does not exceed the specified group size.

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (Optional) Under **Repeat request settings**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (Optional) Under **Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run this command:

   
   ```bash
   yc serverless trigger create logging \
     --name <trigger_name> \
     --log-group-name <log_group_name> \
     --batch-size 1 \
     --batch-cutoff 1s \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```
  

   Where:

   * `--name`: Trigger name.
   * `--log-group-name`: Name of the log group that invokes a container when records are added.
   * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 to 100. The default value is 1.
   * `--batch-cutoff`: Maximum waiting time. This is an optional parameter. The values may range from 0 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a container. The number of messages cannot exceed `batch-size`.

   {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

   Result:

     
   ```text
   id: a1s5msktij**********
   folder_id: b1gmit33hg**********
   created_at: "2023-08-04T15:19:15.353909857Z"
   name: logging-trigger
   rule:
     logging:
       log_group_id: e23bidnftl**********
       batch_settings:
         size: "1"
         cutoff: 1s
       invoke_container:
         container_id: bba5jb38o8**********
         service_account_id: aje03adgd2**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ng**********:dlq
           service-account-id: aje3lebfem**********
   status: ACTIVE
   ```
  

- API

   To create a trigger for {{ cloud-logging-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ cloud-logging-name }} that invokes a {{ sf-name }} function](../../functions/operations/trigger/cloud-logging-trigger-create.md).
