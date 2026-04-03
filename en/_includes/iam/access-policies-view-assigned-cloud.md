To view the list of [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) access policies:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  Run the command, specifying the name or [ID](../../resource-manager/operations/cloud/get-id.md) of the cloud for which you want to view the created policies:

  ```bash
  yc resource-manager cloud list-access-policy-bindings <cloud_name_or_ID>
  ```

  Result:

  ```
  +---------------------------------------+
  |      ACCESS POLICY TEMPLATE ID        |
  +---------------------------------------+
  | iam.denyServiceAccountApiKeysCreation |
  +---------------------------------------+
  ```

- API {#api}

  Use the [listAccessPolicyBindings](../../resource-manager/api-ref/Cloud/listAccessPolicyBindings.md) REST API method for the [Cloud](../../resource-manager/api-ref/Cloud/index.md) resource or the [CloudService/ListAccessPolicyBindings](../../resource-manager/api-ref/grpc/Cloud/listAccessPolicyBindings.md) gRPC API call.

{% endlist %}