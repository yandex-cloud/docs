---
title: "How to delete a trigger in {{ serverless-containers-full-name }}"
description: "In this tutorial, you will learn how to delete a trigger in {{ serverless-containers-full-name }}."
---

# Deleting a trigger in {{ serverless-containers-name }}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
   1. Select the trigger you want to update.
   1. In the top-right corner of the page, click **{{ ui-key.yacloud.serverless-functions.list.button_action-delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.serverless-functions.list.popup-confirm_button_delete }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   {% include [trigger-list-note](../../_includes/serverless-containers/trigger-list-note.md) %}

   Delete the trigger:

   ```bash
   yc serverless trigger delete <trigger_name>
   ```

   Result:

   ```text
   id: a1s5msktij**********
   folder_id: b1gmit33hg**********
   created_at: "2022-10-24T15:19:15.353909857Z"
   name: timer-test
   rule:
     timer:
       cron_expression: 5 10 ? * * *
       invoke_container_with_retry:
         container_id: bba5jb38o8**********
         service_account_id: aje03adgd2**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
   status: PAUSED
   ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To delete a trigger created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the `function_trigger` resource description.

      Sample `function_trigger` resource description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "sc-timer"
        timer {
          cron_expression = "*/5 * ? * * *"
        }
        container {
          id                 = "bbaomb25tl68********"
          service_account_id = "ajej9vu5f62d********"
          retry_attempts     = 1
          retry_interval     = 15
        }
        dlq {
          queue_id           = "yrn:yc:ymq:ru-central1:b1geoelk7fld********:formycontainer"
          service_account_id = "ajej9vu5f62d********"
        }
      }
      ```

   1. Delete resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc serverless trigger list
      ```

- API {#api}

   To delete a trigger, use the [delete](../triggers/api-ref/Trigger/delete.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Delete](../triggers/api-ref/grpc/trigger_service.md#Delete) gRPC API call.

{% endlist %}
