---
title: How to delete authorized keys in {{ iam-full-name }}
description: In this tutorial, you will learn how to delete authorized keys in {{ iam-full-name }} via the management console, CLI, and API.
---

# Deleting authorized keys

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the required service account.
  1. Under **{{ ui-key.yacloud.iam.folder.service-account.overview.section_keys }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) in the line with the key to delete, and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Get a list of authorized key IDs (`ID`) for a specific service account. Specify the service account name in the `--service-account-name` parameter:

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