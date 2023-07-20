# Updating the description of a trigger in {{ sf-name }}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/functions/triggers.svg) **Triggers**.
   1. Select the trigger whose description you want to update.
   1. In the upper-right corner of the page, click **Edit**.
   1. Edit the description and click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To update the trigger description, run this command:

   ```bash
   yc serverless trigger update <trigger name> --description "<trigger description>"
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
       queue_id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:my-mq
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

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   To update the trigger description:

   1. Open the {{ TF }} configuration file and edit the `description` field in the trigger description:

      ```hcl
      ...
      resource "yandex_function_trigger" "my_trigger" {
        name        = "some_name"
        description = "any description"
        timer {
          cron_expression = "* * * * ? *"
        }
        function {
          id = "tf-test"
        }
      }
      ...
      ```

      For more information about the `yandex_function_trigger` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the trigger in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

      ```
      yc serverless trigger get <trigger ID>
      ```

- API

   To update a trigger description, use the [update](../../triggers/api-ref/Trigger/update.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Update](../../triggers/api-ref/grpc/trigger_service.md#Update) gRPC API call.

{% endlist %}