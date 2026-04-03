To create an access policy for an [organization](../../organization/concepts/organization.md) based on a [template without optional parameters](../../iam/concepts/access-control/access-policies.md#fixed):

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

- API {#api}

  Use the [bindAccessPolicy](../../organization/api-ref/Organization/bindAccessPolicy.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/BindAccessPolicy](../../organization/api-ref/grpc/Organization/bindAccessPolicy.md) gRPC API call.

{% endlist %}

The new access policy will apply to resources within all clouds in the specified organization.