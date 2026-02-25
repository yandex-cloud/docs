To assign an access policy for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), follow these steps:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get](../../iam/operations/access-policies/list.md) a list of supported access policies with their IDs.
  1. Run this command:

      ```bash
      yc resource-manager cloud bind-access-policy \
        --name <cloud_name> \
        --access-policy-template-id=<access_policy_ID>
      ```

      Where:

      * `--name`: Name of the cloud you want to assign the access policy for. Instead of the cloud name, you can provide its [ID](../../resource-manager/operations/cloud/get-id.md) in the `--id` parameter.
      * `--access-policy-template-id`: ID of the access policy you want to assign for the cloud.
  1. [Make sure](../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned) the policy was assigned.

- API {#api}

  Use the [bindAccessPolicy](../../resource-manager/api-ref/Cloud/bindAccessPolicy.md) REST API method for the [Cloud](../../resource-manager/api-ref/Cloud/index.md) resource or the [CloudService/BindAccessPolicy](../../resource-manager/api-ref/grpc/Cloud/bindAccessPolicy.md) gRPC API call.

{% endlist %}

The assigned access policy will apply to resources within all folders in the specified cloud.