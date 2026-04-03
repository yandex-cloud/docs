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
      * `--access-policy-template-id`: ID of the access policy template you want to delete from the specified organization.
  1. [Make sure](../../organization/operations/manage-access-policies.md#view-assigned) the policy was deleted.

- API {#api}

  Use the [unbindAccessPolicy](../../organization/api-ref/Organization/unbindAccessPolicy.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/UnbindAccessPolicy](../../organization/api-ref/grpc/Organization/unbindAccessPolicy.md) gRPC API call.

{% endlist %}

The access policy will no longer apply to resources within all clouds in the specified organization.