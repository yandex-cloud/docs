To provide the function with access to the secret, specify a [service account](../../iam/concepts/users/service-accounts.md) with the following roles in the function parameters:
* `lockbox.payloadViewer` for the secret (see [how to grant access rights to secrets](../../lockbox/operations/secret-access.md)).
* `kms.keys.encrypterDecrypter` for the encryption key if the secret was created using a {{ kms-full-name }} key (see [how to grant access rights to encryption keys](../../kms/operations/key-access.md)).

A new version of a function is created when secrets are transmitted. You cannot transmit secrets to an existing version.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Open **{{ sf-name }}**.
   1. Select a function where you want to transmit a {{ lockbox-name }} secret to.
   1. Go to the **Editor** tab.
   1. Under **Parameters**, specify:
      * In the **Service account** field, the service account with the `lockbox.payloadViewer` role.
      * In the **{{ lockbox-name }} secret** field:
         * Name of the environment variable where the secret will be kept.
         * Secret ID.
         * Secret version ID.
         * Non-secret key ID.
   1. Click **Add**. You can transmit several secrets to a function.
   1. Click **Create version**. A new version of the function with the specified secrets will be created.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To transmit a {{ lockbox-name }} secret to a function, run this command:

   {% note warning %}

   If the secrets were already sent to the previous function version, they are overwritten.

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

   * `--function-name`: Function name.
   * `--runtime`: Runtime environment.
   * `--entrypoint`: Entry point specified in the <function file name>.<handler name> format.
   * `--memory`: Amount of RAM.
   * `--execution-timeout`: Maximum function execution time before the timeout is reached.
   * `--source-version-id`: ID of the function version to copy the code of.
   * `--service-account-id`: ID of a service account with the `lockbox.payloadViewer` role.
   * `--secret`:
      * `environment-variable`: Name of the environment variable where the secret will be kept.
      * `id`: Secret ID.
      * `version-id`: Secret version ID.
      * `key`: Non-secret key ID.

- API

   You can transmit a {{ lockbox-name }} secret to a function using the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) API method.

{% endlist %}