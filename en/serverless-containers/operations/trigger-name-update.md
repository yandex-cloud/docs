# Changing the name of a trigger in {{ serverless-containers-name }}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
   1. In the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
   1. Select the trigger whose name you want to update.
   1. In the top-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
   1. Edit the name and click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_update-trigger }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   {% include [trigger-list-note](../../_includes/serverless-containers/trigger-list-note.md) %}

   To change the trigger name, run this command:

   ```bash
   yc serverless trigger update <trigger_name> --new-name <new_trigger_name>
   ```

   Result:

   ```text
   id: a1sfe084v4**********
   folder_id: b1g88tflru**********
   created_at: "2022-12-04T08:45:31.131391Z"
   name: my-trigger
   rule:
     mail:
       email: a1s8h8avgl**********-cho1****@serverless.yandexcloud.net
       invoke_container:
         container_id: bba5jb38o8**********
         service_account_id: aje03adgd2**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
   status: ACTIVE
   ```

- API

   To rename a trigger, use the [update](../triggers/api-ref/Trigger/update.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Update](../triggers/api-ref/grpc/trigger_service.md#Update) gRPC API call.

{% endlist %}
