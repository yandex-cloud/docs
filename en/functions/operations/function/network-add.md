# Specifying a cloud network where the function will be executed

{% include [note-preview](../../../_includes/note-preview.md) %}

You can specify a [cloud network](../../../vpc/concepts/network.md#network) where the function will be executed.

{% include [network](../../../_includes/functions/network.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
   1. Select a function.
   1. Go to the **Editor** tab.
   1. Under **Parameters**, in the **Network** field, choose a network for function execution.
   1. Click **Create version**.

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

   * `--function-name`: The function name.
   * `--runtime`: The runtime environment.
   * `--entrypoint`: The entry point specified in the <function file name>.<handler name> format.
   * `--memory`: The amount of RAM.
   * `--execution-timeout`: The maximum function execution time before the timeout is reached.
   * `--source-version-id`: The ID of the function version to copy the code of.
   * `--network-id`: ID of a cloud network where the function will be executed.

- API

   You can specify a cloud network using the [createVersion](../../functions/api-ref/Function/createVersion.md) API method.

{% endlist %}

## See also

* [Networking in {{ sf-name }}](../../concepts/networking.md).