To revoke an access policy assigned for an [organization](../../organization/concepts/organization.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get](../../organization/operations/manage-access-policies.md#view-assigned) a list of access policy IDs assigned for the organization.
  1. Run this command:

      ```bash
      yc organization-manager organization unbind-access-policy \
        --name <organization_name> \
        --access-policy-template-id=<access_policy_ID>
      ```

      Where:

      * `--name`: Name of the organization you want to revoke the policy from. Instead of the organization name, you can provide its [ID](../../organization/operations/organization-get-id.md) in the `--id` parameter.
      * `--access-policy-template-id`: ID of the access policy you want to revoke from the specified organization.
  1. [Make sure](../../organization/operations/manage-access-policies.md#view-assigned) the policy has been revoked.

- API {#api}

  Use the [unbindAccessPolicy](../../organization/api-ref/Organization/unbindAccessPolicy.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/UnbindAccessPolicy](../../organization/api-ref/grpc/Organization/unbindAccessPolicy.md) gRPC API call.

{% endlist %}

The access policy will no longer apply to resources within all clouds in the specified organization.