To create a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) access policy from a [template without parameters](../../iam/concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get](../../iam/operations/access-policies/list.md) a list of supported access policy templates with their IDs.
  1. Run this command:

      ```bash
      yc resource-manager folder bind-access-policy \
        --name <folder_name> \
        --access-policy-template-id=<policy_template_ID>
      ```

      Where:

      * `--name`: Name of the folder to create the policy for. Instead of the folder name, you can provide its [ID](../../resource-manager/operations/folder/get-id.md) in the `--id` parameter.
      * `--access-policy-template-id`: ID of the template to use as the basis for the new access policy for the folder.
  1. [Make sure](../../resource-manager/operations/folder/manage-access-policies.md#view-assigned) the policy was created.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../terraform-install.md) %}

  1. [Get](../../iam/operations/access-policies/list.md) the ID of the access policy template without parameters.
  1. Add the `yandex_resource_manager_folder_iam_policy_binding` resource to the configuration:

      ```hcl
      resource "yandex_resource_manager_folder_iam_policy_binding" "policy" {
        folder_id = "<folder_ID>"
        access_policy_template_id = "<policy_template_ID>"
      }
      ```

      Where `folder_id` is the folder ID, and `access_policy_template_id` is the access policy template ID. This resource creates a policy template binding rather than assigning a role to a subject.

      For more information, see [this provider guide]({{ tf-provider-resources-link }}/resource_manager_folder_iam_policy_binding).
  1. Apply the configuration:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

  Use the [bindAccessPolicy](../../resource-manager/api-ref/Folder/bindAccessPolicy.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/BindAccessPolicy](../../resource-manager/api-ref/grpc/Folder/bindAccessPolicy.md) gRPC API call.

{% endlist %}

The created access policy will apply to all resources in the specified folder.