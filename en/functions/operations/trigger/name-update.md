# Changing the name of a trigger in {{ sf-name }}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. In the left-hand panel, select ![image](../../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
   1. Select the trigger whose name you want to update.
   1. In the upper-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
   1. Edit the name and click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_update-trigger }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To change the trigger name, run this command:

   ```bash
   yc serverless trigger update <trigger name> --new-name <new trigger name>
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

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   To change the name of a function:

   1. Open the {{ TF }} configuration file and edit the `name` field in the trigger description:

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

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the trigger update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```
      yc serverless trigger get <trigger ID>
      ```

- API

   To rename a trigger, use the [update](../../triggers/api-ref/Trigger/update.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Update](../../triggers/api-ref/grpc/trigger_service.md#Update) gRPC API call.

{% endlist %}