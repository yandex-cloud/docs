To delete an access policy created for an [organization](../../organization/concepts/organization.md), follow these steps:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get](../../organization/operations/manage-access-policies.md#view-assigned) a list of IDs of access policy templates assigned for the organization.
  1. Run this command:

      ```bash
      yc organization-manager organization unbind-access-policy \
        --name <organization_name> \
        --access-policy-template-id=<policy_template_ID>
      ```

      Where:

      * `--name`: Name of the organization to delete the policy for. Instead of the organization name, you can provide its [ID](../../organization/operations/organization-get-id.md) in the `--id` parameter.
      * `--access-policy-template-id`: ID of the access policy template you want to delete for the specified organization.
  1. [Make sure](../../organization/operations/manage-access-policies.md#view-assigned) the policy was deleted.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../terraform-install.md) %}

  1. In the configuration, locate the `yandex_organization_manager_organization_iam_policy_binding` resource with the IDs of the policy template in `access_policy_template_id` and organization in `organization_id`.
  1. Remove the section of that resource. The organization resource itself should not be deleted.
  1. Apply the configuration:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Make sure the plan removes only the correct policy binding. These steps apply to the binding managed by the current {{ TF }} configuration.

- API {#api}

  Use the [unbindAccessPolicy](../../organization/api-ref/Organization/unbindAccessPolicy.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/UnbindAccessPolicy](../../organization/api-ref/grpc/Organization/unbindAccessPolicy.md) gRPC API call.

{% endlist %}

The access policy will no longer apply to resources within all clouds in the specified organization.