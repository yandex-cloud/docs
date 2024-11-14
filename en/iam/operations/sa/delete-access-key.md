---
title: How to delete static access keys in {{ iam-full-name }}
description: In this tutorial, you will learn how to delete static access keys in {{ iam-full-name }} via the management console, CLI, and API.
---

# Deleting static access keys

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder that the service account belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the required service account.
  1. Under **{{ ui-key.yacloud.iam.folder.service-account.overview.section_service-account-keys }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) in the line with the key to delete, and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete-api-key }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Get a list of static key IDs (`ID`) for a specific service account. Specify the service account name in the `--service-account-name` parameter:

     ```bash
     yc iam access-key list --service-account-name <service_account_name>
     ```

     Result:

     ```text
     +----------------------+----------------------+----------------------+
     |          ID          |  SERVICE ACCOUNT ID  |        KEY ID        |
     +----------------------+----------------------+----------------------+
     | aje8bdtqec6l******** | ajeedllrkjma******** | R9JK04o1Dfaf******** |
     | ajegqpa91bta******** | ajeedllrkjma******** | cWXGkDoBRho5******** |
     +----------------------+----------------------+----------------------+
     ```

  1. Delete the old static key. Replace `<ID>` with your API key ID:

     ```bash
     yc iam access-key delete <ID>
     ```

- API {#api}

  To delete a static key, use the [delete](../../awscompatibility/api-ref/AccessKey/delete.md) REST API method for the [AccessKey](../../awscompatibility/api-ref/AccessKey/index.md) REST API resource or the [AccessKeyService/Delete](../../awscompatibility/api-ref/grpc/AccessKey/delete.md) gRPC API call.

{% endlist %}