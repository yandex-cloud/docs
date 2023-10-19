---
title: "Updating a trigger label in {{ sf-name }}"
description: "Follow this guide to update a trigger label in {{ sf-name }}."
---

# Updating a trigger label in {{ sf-name }}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To update a trigger label, run the command:

   {% note warning %}

   The existing set of `labels` is completely replaced by the set transmitted.

   {% endnote %}

   ```bash
   yc serverless trigger update <trigger name> --labels <key>=<value>
   ```

   Result:

   ```text
   id: a1s9q2li6t**********
   folder_id: b1g9hv2loa**********
   created_at: "2023-08-01T12:36:14.321Z"
   name: my-trigger
   description: Trigger for uploaded objects
   labels
     new_label: my-beta-trigger
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

   To change a trigger label:

   1. Open the {{ TF }} configuration file and change the `labels` section in the trigger description:

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

      You can verify the change to the trigger using this [CLI](../../../cli/quickstart.md) command:

      ```
      yc serverless trigger get <trigger ID>
      ```

- API

   To update a trigger label, use the [update](../../triggers/api-ref/Trigger/update.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Update](../../triggers/api-ref/grpc/trigger_service.md#Update) gRPC API call.

{% endlist %}