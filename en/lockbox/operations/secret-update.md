# Updating secrets

To update a secret:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. In the menu on the left, select **Secrets**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the required secret.
   1. In the menu that opens, select **Edit**.
   1. Update the name and description of the secret. If necessary, select **Don't destroy secret**.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for adding resources to a secret:
      ```bash
      yc lockbox secret update --help
      ```

   1. Run the command, specifying the secret name or ID:
      ```bash
      yc lockbox secret update \
        --id <secret ID> \
        --new-name <new secret name> \
        --description <new secret description>
      ```

      Result:
      ```
      id: e6q2ig0u9b97tk2d251j
      folder_id: b1gyggt2th593evcld2a
      created_at: "2021-11-08T19:23:00.383Z"
      name: <new secret name>
      description: <new secret description>
      status: ACTIVE
      current_version:
        id: e6q8ma3b6pd1kckgtaib
        secret_id: e6q2ug0o9b24tk2d941j
        created_at: "2021-11-08T19:23:00.383Z"
        status: ACTIVE
        payload_entry_keys:
        - <key>
      ```

- API

   To update a secret, use the [update](../api-ref/Secret/update.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/Update](../api-ref/grpc/secret_service.md#Update) gRPC API call.

{% endlist %}