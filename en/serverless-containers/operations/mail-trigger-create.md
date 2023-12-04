# Creating an email trigger that invokes a {{ serverless-containers-name }} container

Create an [email trigger](../concepts/trigger/mail-trigger.md) to invoke a {{ serverless-containers-name }} [container](../concepts/container.md) when an email arrives. The service automatically generates an email address when creating the trigger.

## Getting started {#before-you-begin}

To create a trigger, you need:

* A container that the trigger will invoke. If you do not have a container:

   * [Create a container](../../serverless-containers/operations/create.md).
   * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).

* (Optional) A [dead letter queue](../../serverless-containers/concepts/dlq.md) where messages that could not be processed by a container will be redirected. If you do not have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights:

   * To invoke a container.
   * (Optional) To write to a Dead Letter Queue.
   * (Optional) To upload objects to buckets.

   You can use the same service account or different ones. If you do not have a service account, [create one](../../iam/operations/sa/create.md).

* (Optional) [Bucket](../../storage/concepts/bucket.md) to save email attachments to. If you do not have a bucket, [create one](../../storage/operations/buckets/create.md) with restricted access.

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

   1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * (Optional) Enter a trigger name and description.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_mail }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_mail-attachments }}**:

      {% include [mail-trigger-attachements](../../_includes/functions/mail-trigger-attachements.md) %}

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run this command:

   
   ```bash
   yc serverless trigger create mail \
     --name <trigger_name> \
     --batch-size <batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --attachements-bucket <bucket_name> \
     --attachements-service-account-id <service_account_ID> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```


   Where:

   * `--name`: Trigger name.

   {% include [batch-settings-messages](../../_includes/serverless-containers/batch-settings-messages.md) %}

   {% include [attachments-params](../../_includes/functions/attachments-params.md) %}

   {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

   Result:

   
   ```
   id: a1sfe084v4**********
   folder_id: b1g88tflru**********
   created_at: "2022-12-04T08:45:31.131391Z"
   name: mail-trigger
   rule:
     mail:
       email: a1s8h8avgl**********-cho1****@serverless.yandexcloud.net
       batch_settings:
         size: "3"
         cutoff: 20s
       attachments_bucket:
         bucket_id: bucket-for-attachments
         service_account_id: ajejeis235ma********
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


- API

   To create an email trigger, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

{{ serverless-containers-name }} will automatically generate an email address that will cause the trigger to fire when messages are sent to it. To see it, [retrieve detailed trigger information](trigger-list.md#trigger-get).

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [Email trigger that invokes a {{ sf-name }} function](../../functions/operations/trigger/mail-trigger-create.md).
