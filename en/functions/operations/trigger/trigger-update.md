# Updating a trigger in {{ sf-name }}

You can update any parameters except for the trigger type and launched resource type.

{% note info %}

Your changes will apply within five minutes.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
    1. Select the trigger whose parameters you want to update.
    1. In the top-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
    1. Edit the trigger parameters and click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_update-trigger }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [trigger-list-note](../../../_includes/functions/trigger-list-note.md) %}

  1. View a description of the CLI command for updating trigger parameters:

      ```bash
      yc serverless trigger update <trigger_type> --help
      ```

  1. Update the trigger parameters, e.g., rename it:

      ```bash
      yc serverless trigger update <trigger_type> <trigger_name> \
        --new-name <new_trigger_name>
      ```

      Result:

      
      ```text
      id: dd0gj5tsj2**********
      folder_id: aoek49ghmk**********
      created_at: "2019-08-28T12:26:25.675Z"
      name: my-trigger
      rule:
        object_storage:
          event_type:
          - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_DELETE_OBJECT
          - OBJECT_STORAGE_EVENT_TYPE_UPDATE_OBJECT
          bucket_id: s3-for-trigger
          prefix: dev
          suffix: 12.jpg
          invoke_function:
            function_id: d4eofc7n0m03********
            function_tag: $latest
            service_account_id: aje3932acd0c********
            retry_settings:
              retry_attempts: "1"
              interval: 10s
            dead_letter_queue:
              queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknn********:dlq
              service-account-id: aje3932acd0c********
      status: ACTIVE
      ```




- {{ TF }} {#tf}

  For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  To edit trigger parameters:

  1. Open the {{ TF }} configuration file and edit the trigger parameters:

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

      For more information about the `yandex_function_trigger` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/function_trigger).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   You can check the trigger update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

    ```
    yc serverless trigger get <trigger_ID>
    ```

- API {#api}

  To update parameters of a trigger, use the [update](../../triggers/api-ref/Trigger/update.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Update](../../triggers/api-ref/grpc/trigger_service.md#Update) gRPC API call.

{% endlist %}
