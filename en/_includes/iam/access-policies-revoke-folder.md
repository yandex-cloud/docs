To revoke an access policy assigned for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get](../../resource-manager/operations/folder/manage-access-policies.md#view-assigned) a list of access policy IDs assigned for the folder.
  1. Run this command:

      ```bash
      yc resource-manager folder unbind-access-policy \
        --name <folder_name> \
        --access-policy-template-id=<access_policy_ID>
      ```

      Where:

      * `--name`: Name of the folder you want to revoke the policy from. Instead of the folder name, you can provide its [ID](../../resource-manager/operations/folder/get-id.md) in the `--id` parameter.
      * `--access-policy-template-id`: ID of the access policy you want to revoke from the specified folder.
  1. [Make sure](../../resource-manager/operations/folder/manage-access-policies.md#view-assigned) the policy has been revoked.

- API {#api}

  Use the [unbindAccessPolicy](../../resource-manager/api-ref/Folder/unbindAccessPolicy.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UnbindAccessPolicy](../../resource-manager/api-ref/grpc/Folder/unbindAccessPolicy.md) gRPC API call.

{% endlist %}

The specified access policy will no longer apply to resources in the specified folder.