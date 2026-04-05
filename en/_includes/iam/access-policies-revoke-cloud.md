To delete an access policy created for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get](../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned) a list of IDs of access policy templates assigned for the cloud.
  1. Run this command:

      ```bash
      yc resource-manager cloud unbind-access-policy \
        --name <cloud_name> \
        --access-policy-template-id=<policy_template_ID>
      ```

      Where:

      * `--name`: Name of the cloud that you want to delete the policy for. Instead of the cloud name, you can provide its [ID](../../resource-manager/operations/cloud/get-id.md) in the `--id` parameter.
      * `--access-policy-template-id`: ID of the access policy template you want to delete from the specified cloud.
  1. [Make sure](../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned) the policy was deleted.

- API {#api}

  Use the [unbindAccessPolicy](../../resource-manager/api-ref/Cloud/unbindAccessPolicy.md) REST API method for the [Cloud](../../resource-manager/api-ref/Cloud/index.md) resource or the [CloudService/UnbindAccessPolicy](../../resource-manager/api-ref/grpc/Cloud/unbindAccessPolicy.md) gRPC API call.

{% endlist %}

The specified access policy will no longer apply to resources within all folders in the given cloud.