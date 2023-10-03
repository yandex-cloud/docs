{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. In the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
   1. Select the trigger to get detailed information about.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   {% include [trigger-list-note](trigger-list-note.md) %}

   Get detailed information about a trigger:

   ```bash
   yc serverless trigger get <trigger name>
   ```

   Result:

   ```text
   id: a1s9q2li6t**********
   folder_id: b1g9hv2loa**********
   created_at: "2023-08-01T12:36:14.321Z"
   name: my-trigger
   description: Trigger for uploaded objects
   rule:
     object_storage:
       event_type:
         - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
       bucket_id: **********
       batch_settings:
         size: "10"
         cutoff: 10s
       invoke_function:
         function_id: d4e5muirrt**********
         function_tag: $latest
         service_account_id: ajek0fou8e**********
   status: ACTIVE
   ```

- API

   To get detailed information about a trigger, use the [get](../../functions/triggers/api-ref/Trigger/get.md) REST API method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Get](../../functions/triggers/api-ref/grpc/trigger_service.md#Get) gRPC API call.

{% endlist %}
