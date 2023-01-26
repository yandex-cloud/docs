# Deleting a trigger label in {{ sf-name }}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To delete a trigger label, run the command:

   ```bash
   yc serverless trigger remove-labels <trigger name> --labels <key>
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

- API

   You can delete a trigger label using the [update](../../triggers/api-ref/Trigger/update.md) API method.

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   To delete a trigger label:

   1. Open the {{ TF }} configuration file and delete the unnecessary label in the `labels` section.

      ```hcl
      ...
      resource "yandex_function_trigger" "my_trigger" {
        name   = "some_name"
        labels = {
          tf-label    = "tf-label-value"
          empty-label = ""
        }
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

      For more information about the `yandex_function_trigger` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/function_trigger).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the trigger using this [CLI](../../../cli/quickstart.md) command:

      ```
      yc serverless trigger get <trigger ID>
      ```

{% endlist %}
