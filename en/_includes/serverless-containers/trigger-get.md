{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
   1. In the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
   1. Select the trigger to get detailed information about.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   Get detailed information about a trigger:

   ```bash
   yc serverless trigger get <trigger_name>
   ```

   Result:

   
   ```text
   id: a1sfe084v4**********
   folder_id: b1g88tflri**********
   created_at: "2022-12-04T08:45:31.131391Z"
   name: mail-trigger
   description: My trigger for mail.
   rule:
     mail:
       email: a1smdtklem**********-xivn****@serverless.yandexcloud.net
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

   To get information about a trigger, use the [get](../../serverless-containers/triggers/api-ref/Trigger/get.md) REST API method for the [Trigger](../../serverless-containers/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Get](../../serverless-containers/triggers/api-ref/grpc/trigger_service.md#Get) gRPC API call.

{% endlist %}
