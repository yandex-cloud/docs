---
title: "How to specify a cloud network where the function will be executed"
description: "This guide describes how you can specify a cloud network where the function will be executed."
---

# Specifying a cloud network where the function will be executed

{% include [note-preview](../../../_includes/note-preview.md) %}

You can specify a [cloud network](../../../vpc/concepts/network.md#network) where the function will be executed.

{% include [network](../../../_includes/functions/network.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select a function.
   1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
   1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, in the **{{ ui-key.yacloud.vpc.label_network }}** field, choose a network for function execution.
   1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To specify a cloud network, run the command:

   ```
   yc serverless function version create \
     --function-name=<function name> \
     --runtime <runtime environment> \
     --entrypoint <entry point> \
     --memory 128m \
     --execution-timeout 5s \
     --source-version-id <version ID> \
     --network-id <network ID>
   ```
   Where:

   * `--function-name`: Function name.
   * `--runtime`: Runtime environment.
   * `--entrypoint`: Entry point specified in the <function file name>.<handler name> format.
   * `--memory`: Amount of RAM.
   * `--execution-timeout`: Maximum function execution time before the timeout is reached.
   * `--source-version-id`: ID of the function version to copy the code of.
   * `--network-id`: ID of a cloud network where the function will be executed.

- API

   To specify a cloud network, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call.

{% endlist %}

## See also

* [Networking in {{ sf-name }}](../../concepts/networking.md).