# Creating an email trigger

Create an [email trigger](../concepts/trigger/mail-trigger.md) to call a {{ serverless-containers-name }} [container](../concepts/container.md) when an email arrives. The service automatically generates an email address when creating the trigger.

## Before you begin {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Select **{{ serverless-containers-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * (optional) Enter a trigger name and description.
      * In the **Type** field, select **Email**.
      * In the **Launched resource** field, select **Container**.

   1. Under **Container settings**, select a container and specify:

      {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (optional) Under **Repeat request settings**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (optional) **Under Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that launches a container, run the command below:

   ```
   yc serverless trigger create mail \
     --name <trigger_name> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--invoke-container-id`: Container ID.
   * `--invoke-container-service-account-id`: Service account with rights to invoke container.
   * `--retry-attempts`: Time to retry invoking container if current attempt fails. Optional. Values can be from 10 to 60 seconds. The default is 10 seconds.
   * `--retry-interval`: The number of invocation retries before the trigger moves a message to the Dead Letter Queue. Optional. Values can be from 1 to 5. The default is 1.
   * `--dlq-queue-id`: Dead Letter Queue ID. Optional.
   * `--dlq-service-account-id`: Service account with rights to write messages to the Dead Letter Queue. Optional.

   Result:

   ```
   id: a1sfe084v4**********
   folder_id: b1g88tflru**********
   created_at: "2022-12-04T08:45:31.131391Z"
   name: mail-trigger
   rule:
     mail:
       invoke_container:
         container_id: d4eofc7n0m**********
         service_account_id: aje3932acd**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
           service-account-id: aje3932acd**********
   status: ACTIVE
   ```

{% endlist %}

{{ serverless-containers-name }} will automatically generate an email address that will cause the trigger to fire when messages are sent to it. To see it, [retrieve detailed trigger information](trigger-list.md#trigger-get).

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also

* [Email trigger that calls a {{ sf-name }} function](../../functions/operations/trigger/mail-trigger-create.md).
