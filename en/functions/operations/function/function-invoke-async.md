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

    ```
    yc serverless function version create \
      --function-name=<function_name> \
      --runtime <runtime_environment> \
      --entrypoint <entry_point> \
      --memory 128m \
      --execution-timeout 5s \
      --source-version-id <version_ID> \
      --async-max-retries 3 \
      --async-service-account-id <service_account_ID> \
      --async-success-ymq-arn <message_queue> \
      --async-success-sa-id <service_account_ID> \
      --async-failure-ymq-arn <message_queue> \
      --async-failure-sa-id <service_account_ID>
    ```
    Where:

    * `--function-name`: Function name.
    * `--runtime`: Runtime environment.
    * `--entrypoint`: Entry point specified in the <function_file_name>.<handler_name> format.
    * `--memory`: Amount of RAM.
    * `--execution-timeout`: Maximum function execution time before the timeout is reached.
    * `--source-version-id`: ID of the function version to copy the code of.
    * `--async-max-retries`: Number of invocation retries before the call is considered failed.
    * `--async-service-account-id`: Service account with rights to invoke the function.
    * `--async-success-ymq-arn`: Queue in {{ message-queue-name }} where messages about successful function calls should be sent to. If the parameter is omitted, messages will not be sent.
    * `--async-success-sa-id`: Service account with rights to write messages to the `async-success-ymq-arn` queue.
    * `--async-failure-ymq-arn`: Queue in {{ message-queue-name }} where messages about failed function calls should be sent to. If the parameter is omitted, messages will not be sent.
    * `--async-failure-sa-id`: Service account with rights to write messages to the `async-failure-ymq-arn` queue.

- API {#api}

    To set up asynchronous invocation, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call.

{% endlist %}

## Invoke the function {#invoke}

[Invoke the function](function-invoke.md) using the HTTPS protocol and specifying the `?integration=async` query string parameter.

## See also {#see-also}

* [Asynchronous function invocation](../../concepts/function-invoke-async.md)
