To create an access policy for an [organization](../../organization/concepts/organization.md) based on a [template without parameters](../../iam/concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get](../../iam/operations/access-policies/list.md) a list of supported access policy templates with their IDs.
  1. Run this command:

      ```bash
      yc organization-manager organization bind-access-policy \
        --name <organization_name> \
        --access-policy-template-id=<policy_template_ID>
      ```

      Where:

      * `--name`: Name of the organization you want to create a policy for. Instead of the organization name, you can provide its [ID](../../organization/operations/organization-get-id.md) in the `--id` parameter.
      * `--access-policy-template-id`: ID of the template you want to use as the basis for the new access policy for the organization.
  1. [Make sure](../../organization/operations/manage-access-policies.md#view-assigned) the policy was created.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../terraform-install.md) %}

  1. [Get](../../iam/operations/access-policies/list.md) the ID of the access policy template without parameters.
  1. Add the `yandex_organization_manager_organization_iam_policy_binding` resource to the configuration:

      ```hcl
      resource "yandex_organization_manager_organization_iam_policy_binding" "policy" {
        organization_id = "<organization_ID>"
        access_policy_template_id = "<policy_template_ID>"
      }
      ```

      Where `organization_id` is the organization ID, and `access_policy_template_id`, the access policy template ID. This resource creates a policy template binding rather than assigning a role to a subject.

      For more information, see [this provider guide]({{ tf-provider-resources-link }}/organization_manager_organization_iam_policy_binding).
  1. Apply the configuration:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

  Use the [bindAccessPolicy](../../organization/api-ref/Organization/bindAccessPolicy.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/BindAccessPolicy](../../organization/api-ref/grpc/Organization/bindAccessPolicy.md) gRPC API call.

{% endlist %}

The new access policy will apply to resources within all clouds in the specified organization.