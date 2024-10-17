---
title: How to delete authorized keys in {{ iam-full-name }}
description: In this tutorial, you will learn how to delete authorized keys in {{ iam-full-name }} via the management console, CLI, and API.
---

# Deleting authorized keys

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Choose a service account and click the row with its name.
   1. Under **{{ ui-key.yacloud.iam.folder.service-account.overview.section_keys }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the key to be deleted and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-confirm_button_delete }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Get a list of authorized key `IDs` for a specific service account. Specify the service account name in the `--service-account-name` parameter:

      ```bash
      yc iam key list --service-account-name <service_account_name>
      ```

      Result:

      ```text
      +----------------------+-------------------------------------+-----------+---------------------+
      |          ID          |               SUBJECT               | ALGORITHM |     CREATED AT      |
      +----------------------+-------------------------------------+-----------+---------------------+
      | ajeave7oktut******** | serviceAccount:ajeedllrkjma******** | RSA_2048  | 2022-03-13 20:14:22 |
      | ajeb794igb80******** | serviceAccount:ajeedllrkjma******** | RSA_2048  | 2022-03-13 20:06:13 |
      +----------------------+-------------------------------------+-----------+---------------------+
      ```

   1. Delete the old authorized key. Instead of `<ID>`, specify the authorized key ID:

      ```bash
      yc iam key delete <ID>
      ```

- API {#api}

   To delete an authorized key, use the [delete](../../api-ref/Key/delete.md) REST API method for the [Key](../../api-ref/Key/index.md) resource or the [KeyService/Delete](../../api-ref/grpc/Key/delete.md) gRPC API call.

{% endlist %}