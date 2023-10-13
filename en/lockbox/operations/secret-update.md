# Updating secrets

To update a secret:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. In the left menu, select **{{ ui-key.yacloud.lockbox.label_section-secrets }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the required secret.
   1. In the menu that opens, select **{{ ui-key.yacloud.common.edit }}**.
   1. Update the name and description of the secret. If necessary, select **{{ ui-key.yacloud.lockbox.forms.field_deletion-protection }}**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

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

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the Terraform configuration file and edit the fragment with the secret description:

      {% cut "Sample secret description in the {{ TF }} configuration" %}

      ```
      ...
      resource "yandex_lockbox_secret" "my_secret" {
        name                = "My secret"
        description         = "test secret from tf"
        folder_id           = "b1gmitvfx321d3kr4mhjmo"
        kms_key_id          = "abjp8q2fjfg0sedaqfkl0"
        deletion_protection = true
        labels              = {
          tf-label    = "tf-label-value",
          empty-label = ""
        }
      }
      ...
      ```

      {% endcut %}

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   You can verify that the secret has been changed and its configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

   ```bash
   yc lockbox secret get <secret_name>
   ```

- API

   To update a secret, use the [update](../api-ref/Secret/update.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/Update](../api-ref/grpc/secret_service.md#Update) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/secret.md)
