# Creating an email trigger that invokes a {{ sf-name }} function

Create a [mail trigger](../../concepts/trigger/mail-trigger.md) to call a {{ sf-name }} [function](../../concepts/function.md) when an email arrives. The service automatically generates an email address when creating the trigger.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * (Optional) Enter a trigger name and description.
      * In the **Type** field, select **Email**.
      * In the **Launched resource** field, select **Function**.

   1. Under **Function settings**, select a function and specify:

      {% include [function-settings](../../../_includes/functions/function-settings.md) %}

   1. (Optional) Under **Repeat request settings**:

      {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

   1. (Optional) Under **Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a function, run this command:

   
   ```bash
   yc serverless trigger create mail \
     --name <trigger name> \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead Letter Queue ID> \
     --dlq-service-account-id <service account ID>
   ```
  

   Where:

   * `--name`: Trigger name.

   {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

   Result:

   
   ```text
   id: a1sfe084v4**********
   folder_id: b1g88tflru**********
   created_at: "2022-12-04T08:45:31.131391Z"
   name: mail-trigger
   rule:
     mail:
       email: a1s8h8avgl**********-cho1****@serverless.yandexcloud.net
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

   To create an email trigger, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

{{ sf-name }} will automatically generate an email address that will cause the trigger to fire when messages are sent to it. To see it, [retrieve detailed trigger information](trigger-list.md#trigger-get).

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [Email trigger that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/mail-trigger-create.md).
