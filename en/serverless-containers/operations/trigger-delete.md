# Deleting a trigger in {{ serverless-containers-name }}

{% include [trigger-list-note](../../_includes/serverless-containers/trigger-list-note.md) %}

## Deleting a trigger {#delete}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Open **{{ serverless-containers-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.
   1. Select the trigger you want to update.
   1. In the upper-right corner of the page, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ng**********:dlq
           service-account-id: aje3lebfem**********
   status: PAUSED
   ```

- API

   You can delete a trigger using the [delete](../triggers/api-ref/Trigger/delete.md) API method.

{% endlist %}
