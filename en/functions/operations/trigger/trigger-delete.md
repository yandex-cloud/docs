# Deleting a trigger

{% include [trigger-list-note](../../../_includes/functions/trigger-list-note.md) %}

## Deleting a trigger

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/functions/triggers.svg) **Triggers**.
   1. Select the trigger you want to update.
   1. In the upper-right corner of the page, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Delete the trigger:

   ```
   yc serverless trigger delete <trigger name>
   ```

   Result:

   ```
   id: dd0gj5tsj2pq9at8ja8i
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-08-28T12:26:25.675Z"
   name: my-trigger
   description: My YMQ trigger.
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
       service_account_id: bfbqqeo6jkpls2tse5o6
       batch_settings:
         size: "10"
         cutoff: 10s
       invoke_function:
         function_id: b09e5lu91ta21vdrrgma
         function_tag: $latest
         service_account_id: bfbqqeo6jkpls2tse5o6
   status: PAUSED
   ```

- API

   You can delete a trigger using the [delete](../../triggers/api-ref/Trigger/delete.md) API method.

{% endlist %}
