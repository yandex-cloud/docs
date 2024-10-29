---
title: How to delete a secret in {{ lockbox-full-name }}
description: Follow this guide to delete a secret.
---

# Deleting a secret

To delete a secret:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. In the left-hand menu, select **{{ ui-key.yacloud.lockbox.label_section-secrets }}**.
  1. Next to the secret you need, click ![image](../../_assets/console-icons/ellipsis.svg).
  1. In the menu that opens, select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI delete secret command:

     ```bash
     yc lockbox secret delete --help
     ```

  1. Request a list of secrets:

     ```bash
     yc lockbox secret list --cloud-id <cloud_ID> --folder-name <folder_name>
     ```

     Result:

     ```text
     +----------------------+------------------+------------+---------------------+----------------------+--------+
     |          ID          |       NAME       | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
     +----------------------+------------------+------------+---------------------+----------------------+--------+
     | e6q942hj2r5n******** | <secret_1_name>  |            | 2021-11-09 13:07:12 | e2r9pdm39tn2******** | ACTIVE |
     | e4qkyo469mu2******** | <secret_2_name>  |            | 2021-12-09 06:50:37 | e6fpq386othp******** | ACTIVE |
     +----------------------+------------------+------------+---------------------+----------------------+--------+
     ```

  1. To delete a secret, run the command:

     ```bash
     yc lockbox secret delete --id e4qkyo469mu2********
     ```

     Result:

     ```text
     id: e4qkyo469mu2********
     folder_id: b1ulgko2th57********
     created_at: "2021-11-08T17:13:48.393Z"
     ...
       status: ACTIVE
       payload_entry_keys:
       - <key>
     ```

  1. Make sure the secret is not in the list:

     ```bash
     yc lockbox secret list --cloud-id <cloud_ID> --folder-name <folder_name>
     ```

     Result:

     ```text
     +----------------------+-----------------+------------+---------------------+----------------------+--------+
     |          ID          |      NAME       | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
     +----------------------+-----------------+------------+---------------------+----------------------+--------+
     | e6q942hj2r5n******** | <secret_1_name> |            | 2021-11-09 13:07:12 | e2r9pdm39tn2******** | ACTIVE |
     +----------------------+-----------------+------------+---------------------+----------------------+--------+
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the part with the secret description:

     {% cut "Sample secret description in the {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_lockbox_secret" "my_secret" {
       name                = "My secret"
       description         = "test secret from tf"
       folder_id           = "b1gmitvfx321d3********"
       kms_key_id          = "abjp8q2fjfg0s********"
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

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the secret deletion using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

    ```bash
    yc lockbox secret list
    ```

- API {#api}

  To delete a secret, use the [delete](../api-ref/Secret/delete.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/Delete](../api-ref/grpc/Secret/delete.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/secret.md)
