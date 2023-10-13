---
title: "How to delete static access keys in {{ iam-full-name }}"
description: "In this tutorial, you will learn how to delete static access keys in {{ iam-full-name }} via the management console, CLI, and API."
---

# Deleting static access keys

{% list tabs %}

- Management console

   1. Go to the folder that the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Choose a service account and click the line with its name.
   1. Under **{{ ui-key.yacloud.iam.folder.service-account.overview.section_service-account-keys }}**, click ![image](../../../_assets/options.svg) next to the key to be deleted and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete-api-key }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-confirm_button_delete }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Get a list of static key `IDs` for a specific service account. Specify the service account name in the `--service-account-name` parameter:

      ```bash
      yc iam access-key list --service-account-name <service account name>
      ```

      Result:

      ```text
      +----------------------+----------------------+----------------------+
      |          ID          |  SERVICE ACCOUNT ID  |        KEY ID        |
      +----------------------+----------------------+----------------------+
      | aje8bdtqec6llp7fe49h | ajeedllrkjmam6jsn9n4 | R9JK04o1Dfaf1onhJ33a |
      | ajegqpa91btat1gvhvl6 | ajeedllrkjmam6jsn9n4 | cWXGkDoBRho5KISqk8An |
      +----------------------+----------------------+----------------------+
      ```

   1. Delete the old static key. Instead of `<ID>`, specify the static key ID:

      ```bash
      yc iam access-key delete <ID>
      ```

- API

   To delete a static key, use the [delete](../../api-ref/AccessKey/delete.md) REST API method for the [AccessKey](../../api-ref/AccessKey/index.md) REST API resource or the [AccessKeyService/Delete](../../api-ref/grpc/access_key_service.md#Delete) gRPC API call.

{% endlist %}