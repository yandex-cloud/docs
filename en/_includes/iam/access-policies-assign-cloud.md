To create an access policy for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) based on a [template without additional parameters](../../iam/concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. [Get](../../iam/operations/access-policies/list.md) a list of supported access policy templates with their IDs.
  1. Run this command:

      ```bash
      yc resource-manager cloud bind-access-policy \
        --name <cloud_name> \
        --access-policy-template-id=<policy_template_ID>
      ```

      Where:

      * `--name`: Name of the cloud to create the policy for. Instead of the cloud name, you can provide its [ID](../../resource-manager/operations/cloud/get-id.md) in the `--id` parameter.
      * `--access-policy-template-id`: ID of the template to use as the basis for the new access policy for the cloud.
  1. [Make sure](../../resource-manager/operations/cloud/manage-access-policies.md#view-assigned) the policy was created.

- API {#api}

  Use the [bindAccessPolicy](../../resource-manager/api-ref/Cloud/bindAccessPolicy.md) REST API method for the [Cloud](../../resource-manager/api-ref/Cloud/index.md) resource or the [CloudService/BindAccessPolicy](../../resource-manager/api-ref/grpc/Cloud/bindAccessPolicy.md) gRPC API call.

{% endlist %}

The new access policy will apply to resources within all folders in the specified cloud.