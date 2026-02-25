To assign an access policy for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get](../../iam/operations/access-policies/list.md) a list of supported access policies with their IDs.
  1. Run this command:

      ```bash
      yc resource-manager folder bind-access-policy \
        --name <folder_name> \
        --access-policy-template-id=<access_policy_ID>
      ```

      Where:

      * `--name`: Name of the folder to assign the policy for. Instead of the folder name, you can provide its [ID](../../resource-manager/operations/folder/get-id.md) in the `--id` parameter.
      * `--access-policy-template-id`: ID of the access policy to assign for the folder.
  1. [Make sure](../../resource-manager/operations/folder/manage-access-policies.md#view-assigned) the policy was assigned.

- API {#api}

  Use the [bindAccessPolicy](../../resource-manager/api-ref/Folder/bindAccessPolicy.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/BindAccessPolicy](../../resource-manager/api-ref/grpc/Folder/bindAccessPolicy.md) gRPC API call.

{% endlist %}

The assigned access policy will apply to all resources in the specified folder.