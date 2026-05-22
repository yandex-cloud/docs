To view the list of [organization](../../organization/concepts/organization.md) access policies:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Run the command, specifying the name or [ID](../../organization/operations/organization-get-id.md) of the organization for which you want to view the created policies:

  ```bash
  yc organization-manager organization list-access-policy-bindings <organization_name_or_ID>
  ```

  Result:

  ```
  +------------------------------+
  |  ACCESS POLICY TEMPLATE ID   |
  +------------------------------+
  | organization.denyUserListing |
  +------------------------------+
  ```

- API {#api}

  Use the [listAccessPolicyBindings](../../organization/api-ref/Organization/listAccessPolicyBindings.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource or the [OrganizationService/ListAccessPolicyBindings](../../organization/api-ref/grpc/Organization/listAccessPolicyBindings.md) gRPC API call.

{% endlist %}