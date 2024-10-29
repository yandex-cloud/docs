---
title: How to specify a cloud network where the function will be executed
description: This guide describes how you can specify a cloud network where the function will be executed.
---

# Specifying a cloud network where the function will be executed

You can specify a [cloud network](../../../vpc/concepts/network.md#network) where the function will be executed.

{% include [network](../../../_includes/functions/network.md) %}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the folder containing the function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select a function.
    1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, in the **{{ ui-key.yacloud.vpc.label_network }}** field, choose a network for function execution.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
    
- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To specify a cloud network, run the command:

    ```bash
    yc serverless function version create \
      --function-name=<function_name> \
      --runtime <runtime_environment> \
      --entrypoint <entry_point> \
      --memory 128m \
      --execution-timeout 5s \
      --source-version-id <version_ID> \
      --network-id <network_ID>
    ```
    Where:

    * `--function-name`: Function name.
    * `--runtime`: Runtime environment.
    * `--entrypoint`: Entry point in the following format: `<function_file_name>.<listener_name>`.
    * `--memory`: Amount of RAM.
    * `--execution-timeout`: Maximum function running time before the timeout is reached.
    * `--source-version-id`: ID of the function version whose code you want to copy.
    * `--network-id`: ID of a cloud network where the function will be executed.

- API {#api}

    To specify a cloud network, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}

## See also

* [Networking in {{ sf-name }}](../../concepts/networking.md).