---
title: Updating a trigger in {{ serverless-containers-name }}
description: In this tutorial, you will learn how to update any trigger parameters in {{ serverless-containers-name }} except for the trigger type and launched resource type.
---

# Updating a trigger in {{ serverless-containers-name }}

You can update any parameters except for the trigger type and launched resource type.

{% note info %}

Your changes will apply within five minutes.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Select the trigger whose parameters you want to update.
  1. In the top-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the trigger parameters and click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_update-trigger }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% include [trigger-list-note](../../_includes/serverless-containers/trigger-list-note.md) %}

  1. See the description of the CLI command for updating trigger parameters:

      ```bash
      yc serverless trigger update <trigger_type> --help
      ```

  1. Update the trigger parameters, e.g., rename it:

      ```bash
      yc serverless trigger update <trigger_type> <trigger_name> \
        --new-name <new_trigger_name> 
      ```

      Result:

      ```text
      id: a1s5msktijh2********
      folder_id: b1gmit33hgh2********
      created_at: "2022-10-24T15:19:15.353909857Z"
      name: my-trigger
      rule:
        object_storage:
          event_type:
          - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT
          bucket_id: s3-for-trigger
          prefix: dev
          suffix: 12.jpg
          invoke_container:
            container_id: bba5jb38o8h2********
            service_account_id: aje3932acdh2********
            retry_settings:
              retry_attempts: "1"
              interval: 10s
            dead_letter_queue:
              queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmkh2********:dlq
              service-account-id: aje3932acdh2********
      status: ACTIVE
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and update the parameters of the `function_trigger` resource:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<timer_name>"
        timer {
          cron_expression = "<cron_expression>"
          payload         = "<message>"
        }
        container {
          id                 = "<container_ID>"
          service_account_id = "<service_account_ID>"
          retry_attempts     = <number_of_retry_attempts>
          retry_interval     = <time_between_retry_attempts>
        }
        dlq {
          queue_id           = "<dead-letter_queue_ID>"
          service_account_id = "<service_account_ID>"
        }
      }
      ```

      Where:

      * `name`: Timer name. The name format is as follows:

          {% include [name-format](../../_includes/name-format.md) %}

      * `timer`: Trigger parameters:
          * `cron_expression`: Container invocation schedule specified as a [cron expression](../concepts/trigger/timer.md#cron-expression).
          * `payload`: Message that will be sent to the function if the timer fires. The string length must not exceed 4,096 characters.

      * `container`: Settings for the container that will be activated by the trigger:

          {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

          {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}

      {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

      For more information about the `function_trigger` resource parameters, see the [relevant provider documentation]({{ tf-provider-resources-link }}/function_trigger).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      You can check the updates using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc serverless trigger list
      ```

- API {#api}

  To update parameters of a trigger, use the [update](../triggers/api-ref/Trigger/update.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Update](../triggers/api-ref/grpc/Trigger/update.md) gRPC API call.

{% endlist %}
