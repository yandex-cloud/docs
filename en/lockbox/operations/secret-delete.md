# Deleting secrets

To delete a secret:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. In the left menu, select **{{ ui-key.yacloud.lockbox.label_section-secrets }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the required secret.
   1. In the menu that opens, select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI delete secret command:

      ```bash
      yc lockbox secret delete --help
      ```

   1. Request a list of secrets:

      ```bash
      yc lockbox secret list --cloud-id <cloud ID> --folder-name <folder name>
      ```

      Result:

      ```text
      +----------------------+------------------+------------+---------------------+----------------------+--------+
      |          ID          |       NAME       | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
      +----------------------+------------------+------------+---------------------+----------------------+--------+
      | e6q942hj2r5ni36j09ul | <secret 1 name>  |            | 2021-11-09 13:07:12 | e2r9pdm39tn2hg2koasn | ACTIVE |
      | e4qkyo469mu2det6pvku | <secret 2 name>  |            | 2021-12-09 06:50:37 | e6fpq386othpq93s4t8m | ACTIVE |
      +----------------------+------------------+------------+---------------------+----------------------+--------+
      ```

   1. To delete a secret, run the command:

      ```bash
      yc lockbox secret delete --id e4qkyo469mu2det6pvku
      ```

      Result:

      ```text
      id: e4qkyo469mu2det6pvku
      folder_id: b1ulgko2th573evfdh3a
      created_at: "2021-11-08T17:13:48.393Z"
      ...
        status: ACTIVE
        payload_entry_keys:
        - <key>
      ```

   1. Make sure the secret is not in the list:

      ```bash
      yc lockbox secret list --cloud-id <cloud ID> --folder-name <folder name>
      ```

      Result:

      ```text
      +----------------------+-----------------+------------+---------------------+----------------------+--------+
      |          ID          |      NAME       | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
      +----------------------+-----------------+------------+---------------------+----------------------+--------+
      | e6q942hj2r5ni36j09ul | <secret 1 name> |            | 2021-11-09 13:07:12 | e2r9pdm39tn2hg2koasn | ACTIVE |
      +----------------------+-----------------+------------+---------------------+----------------------+--------+
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and delete the part with the secret description:

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

   You can check the secret's deletion using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

   ```bash
   yc lockbox secret list
   ```

- API

   To delete a secret, use the [delete](../api-ref/Secret/delete.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/Delete](../api-ref/grpc/secret_service.md#Delete) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/secret.md)
