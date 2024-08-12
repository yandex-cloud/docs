---
title: "Invoking a function asynchronously"
description: "Follow this guide to configure and invoke a function asynchronously."
---

# Invoking a function asynchronously

{% include [note-preview](../../../_includes/note-preview.md) %}

## Setting up asynchronous invocation {#async}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing your function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select a function.
    1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_async }}**, switch the **{{ ui-key.yacloud.serverless-functions.item.editor.label_turn-on-button }}** toggle to on.
    1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_tries-count }}** field, specify the number of invocation retries before the call is considered failed.
    1. In the **{{ ui-key.yacloud.forms.label_service-account-select }}** field, specify a service account with rights to invoke the function.
    1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_success-sa }}** and **{{ ui-key.yacloud.serverless-functions.item.editor.label_failed-sa }}** fields, specify where messages on successful and unsuccessful function calls should be sent to, respectively:
        * `{{ ui-key.yacloud.serverless-functions.item.editor.option_queues-unset }}`: Do not send messages.
        * `{{ ui-key.yacloud.serverless-functions.item.editor.option_queues-mq }}`: Send messages to a queue in {{ message-queue-name }}:
            * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mq }}**: Queue in {{ message-queue-name }} to send messages to.
            * **{{ ui-key.yacloud.forms.label_service-account-select }}**: Service account with rights to write messages to the queue.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To set up asynchronous invocation, run the following command:

    ```bash
    yc serverless function version create \
      --function-name=<function_name> \
      --runtime <runtime_environment> \
      --entrypoint <entry_point> \
      --memory <RAM_amount> \
      --execution-timeout <maximum_execution_time> \
      --source-version-id <version_ID> \
      --async-max-retries <number_of_retry_invocation_attempts> \
      --async-service-account-id <service_account_ID> \
      --async-success-ymq-arn <message_queue> \
      --async-success-sa-id <service_account_ID> \
      --async-failure-ymq-arn <message_queue> \
      --async-failure-sa-id <service_account_ID>
    ```

    Where:

    * `--function-name`: Function name.
    * `--runtime`: Runtime environment.
    * `--entrypoint`: Entry point specified in the `<function_file_name>.<handler_name>` format.
    * `--memory`: Amount of RAM.
    * `--execution-timeout`: Maximum function execution time before the timeout is reached.
    * `--source-version-id`: ID of the function version to copy the code of.
    * `--async-max-retries`: Number of retry attempts to make before the invocation fails.
    * `--async-service-account-id`: ID of the service account with permissions to invoke the function.
    * `--async-success-ymq-arn`: ARN of the destination queue in {{ message-queue-name }} for messages about successful function invocations. If the parameter is omitted, messages will not be sent.
    * `--async-success-sa-id`: ID of the service account with permissions to write to the `async-success-ymq-arn` queue.
    * `--async-failure-ymq-arn`: ARN of the destination queue in {{ message-queue-name }} for messages about failed function invocations. If the parameter is omitted, messages will not be sent.
    * `--async-failure-sa-id`: ID of the service account with permissions to write to the `async-failure-ymq-arn` queue.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To set up asynchronous invocation:

  1. Open the {{ TF }} configuration file and add the `async_invocation` section to the function description:

     ```hcl
     resource "yandex_function" "test-function" {
       name               = "<function_name>"
       user_hash          = "<function_hash>"
       runtime            = "<runtime_environment>"
       entrypoint         = "<entry_point>"
       memory             = "<RAM_amount>"
       execution_timeout  = "<maximum_execution_time>"
       service_account_id = "<service_account_ID>"

       async_invocation {
         retries_count       = "<number_of_retry_invocation_attempts>"
         service_account_id  = "<service_account_ID>"
         ymq_failure_target {
           service_account_id = "<service_account_ID>"
           arn                = "<message_queue>"
         }
         ymq_success_target {
           service_account_id = "service_account_ID"
           arn                = "<message_queue>"
         }
       }
     }
     ```

     Where:

     * `async_invocation`: Asynchronous invocation parameters:
        * `retries_count`: Number of retry attempts to make before the invocation fails.
        * `service_account_id`: Service account with permissions to invoke the function.
        * `ymq_failure_target`: Parameters of the queue for failed invocations:
           * `service_account_id`: Service account with permissions to write to the queue for failed asynchronous invocations.
           * `arn`: ARN of the destination queue in {{ message-queue-name }} for messages about failed function invocations. If the parameter is omitted, messages will not be sent.
        * `ymq_failure_target`: Parameters of the queue for successful invocations:
           * `service_account_id`: Service account with permissions to write to the queue for successful asynchronous invocations.
           * `arn`: ARN of the destination queue in {{ message-queue-name }} for messages about successful function invocations. If the parameter is omitted, messages will not be sent.

     For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the function update and its new configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

  ```bash
  yc serverless function version get <function_version_ID>
  ```

- API {#api}

    To set up asynchronous invocation, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call.

{% endlist %}

## Invoke the function {#invoke}

[Invoke the function](function-invoke.md) using the HTTPS protocol and specifying the `?integration=async` query string parameter.

## See also {#see-also}

* [Asynchronous function invocation](../../concepts/function-invoke-async.md)
