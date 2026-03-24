Create a [service account](../../../iam/concepts/users/service-accounts.md) to be used for backups.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `sa-backup-to-s3`.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `storage.editor` [role](../../../storage/security/index.md#storage-editor).
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create a service account:

      ```bash
      yc iam service-account create --name sa-backup-to-s3 \
        --folder-name <folder_name>
      ```

      Result:

      ```yaml
      id: ajeab0cnib1p********
      folder_id: b0g12ga82bcv********
      created_at: "2025-10-03T09:44:35.989446Z"
      name: sa-backup-to-s3
      ```

  1. Assign the `storage.editor` [role](../../../storage/security/index.md#storage-editor) for the folder to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_name> \
        --service-account-name sa-backup-to-s3 \
        --role storage.editor \
        --folder-name <folder_name>
      ```

      Result:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: storage.editor
            subject:
              id: ajeab0cnib1p********
              type: serviceAccount
      ```

- API {#api}

  1. Create a service account named `sa-backup-to-s3`. Do it by using the [create](../../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.
  1. Assign the `storage.editor` [role](../../../storage/security/index.md#storage-editor) for the current folder to the the service account. Do it by using the [setAccessBindings](../../../resource-manager/api-ref/Folder/setAccessBindings.md) REST API method for the [Folder](../../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/SetAccessBindings](../../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md) gRPC API call.

{% endlist %}

{% note info %}

{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}

{% endnote %}