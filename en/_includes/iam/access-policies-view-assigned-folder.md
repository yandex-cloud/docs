To view a list of access policies created for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Run this command by specifying the name or [ID](../../resource-manager/operations/folder/get-id.md) of the folder for which you want to view the new policies:

  ```bash
  yc resource-manager folder list-access-policy-bindings <folder_name_or_ID>
  ```

  Result:

  ```
  +---------------------------------------+
  |      ACCESS POLICY TEMPLATE ID        |
  +---------------------------------------+
  | iam.denyServiceAccountApiKeysCreation |
  +---------------------------------------+
  ```

- API {#api}

  Use the [listAccessPolicyBindings](../../resource-manager/api-ref/Folder/listAccessPolicyBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/ListAccessPolicyBindings](../../resource-manager/api-ref/grpc/Folder/listAccessPolicyBindings.md) gRPC API call.

{% endlist %}