To assign an access policy for an [organization](../../organization/concepts/organization.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get](../../iam/operations/access-policies/list.md) a list of supported access policies with their IDs.
  1. Run this command:

      ```bash
      yc organization-manager organization bind-access-policy \
        --name <organization_name> \
        --access-policy-template-id=<access_policy_ID>
      ```

      Where:

      * `--name`: Name of the organization you want to assign the policy to. Instead of the organization name, you can provide its [ID](../../organization/operations/organization-get-id.md) in the `--id` parameter.
      * `--access-policy-template-id`: ID of the access policy you want to assign to the specified organization.
  1. [Make sure](../../organization/operations/manage-access-policies.md#view-assigned) the policy was assigned.

- API {#api}

  Use the [bindAccessPolicy](../../organization/api-ref/Organization/bindAccessPolicy.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/BindAccessPolicy](../../organization/api-ref/grpc/Organization/bindAccessPolicy.md) gRPC API call.

{% endlist %}

The assigned access policy will apply to resources within all clouds in the specified organization.