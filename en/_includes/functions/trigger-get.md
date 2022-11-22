{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.
   1. Select the trigger to get detailed information about.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   Get detailed information about a trigger:

   ```bash
   yc serverless trigger get <trigger name>
   ```

   Result:

   ```text
   id: dd0gj5tsj2**********
   folder_id: aoek49ghmk**********
   created_at: "2019-08-28T12:26:25.675Z"
   name: my-trigger
   description: My YMQ trigger.
   rule:
     message_queue:
       arn: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:my-mq
       service_account_id: bfbqqeo6jk**********
       batch_settings:
         size: "10"
         cutoff: 10s
       invoke_function:
         function_id: b09e5lu91t**********
         function_tag: $latest
         service_account_id: bfbqqeo6jk**********
   status: ACTIVE
   ```

- API

   You can get detailed information about a trigger using the [get](../../functions/triggers/api-ref/Trigger/get.md) API method.

{% endlist %}
