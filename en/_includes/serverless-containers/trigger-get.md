{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Open **{{ serverless-containers-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.
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

{% endlist %}
