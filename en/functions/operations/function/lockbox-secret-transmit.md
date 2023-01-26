# Transmitting {{ lockbox-name }} secrets to a function

{% include [note-preview-pp](../../../_includes/note-preview-pp.md) %}

[{{ lockbox-name }}](../../../lockbox/) is a service for storing secrets. You can transmit a {{ lockbox-name }} secret to a function in the [environment variable](../../concepts/runtime/environment-variables.md#env).

A function can access the secret when a service account with the `lockbox.payloadViewer` role is specified in the function's parameters. [How to create a service account](../../../iam/operations/sa/create.md).

A new version of a function is created when secrets are transmitted. You can't transmit secrets to an existing version.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Open **{{ sf-name }}**.
   1. Select a function where you want to transmit a {{ lockbox-name }} secret to.
   1. Go to the **Editor** tab.
   1. Under **Parameters**, specify:
      * In the **Service account** field, the service account with the `lockbox.payloadViewer` role.
      * In the **{{ lockbox-name }} secret** field:
         * The name of the environment variable where the secret will be kept.
         * Secret ID.
         * Secret version ID.
         * Non-secret key ID.
   1. Click **Add**. You can transmit several secrets to a function.
   1. Click **Create version**. A new version of the function with the specified secrets is created.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To transmit a {{ lockbox-name }} secret to a function, run the command:

   {% note warning %}

   If the secrets were already passed to the previous function version, they are overwritten.

   {% endnote %}

   ```

   yc serverless function version create \
     --function-name=test \
     --runtime nodejs16 \
     --entrypoint index.main \
     --memory 128m \
     --execution-timeout 5s \
     --source-version-id vfdsde*************** \
     --service-account-id bfbtfc************** \
     --secret environment-variable=KEY,id=fc3q4a**************,version-id=fc3gvv**************,key=key-id
   ```

   Where:

   * `--function-name`: The function name.
   * `--runtime`: The runtime environment.
   * `--entrypoint`: The entry point specified in the <function file name>.<handler name> format.
   * `--memory`: The amount of RAM.
   * `--execution-timeout`: The maximum function execution time before the timeout is reached.
   * `--service-account-id`: ID of the function version to copy the code of.
   * `--service-account-id`: ID of a service account with the `lockbox.payloadViewer` role.
   * `--secret`:
      * `environment-variable`: Name of the environment variable where the secret will be kept.
      * `id`: Secret ID.
      * `version-id`: Secret version ID.
      * `key`: Non-secret key ID.

- API

   You can transmit a {{ lockbox-name }} secret to a function using the [createVersion](../../functions/api-ref/Function/createVersion.md) API method.

{% endlist %}