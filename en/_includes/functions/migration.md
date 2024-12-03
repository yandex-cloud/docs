# Migration to the {{ region-id }}-d availability zone

If you created [subnets](../../vpc/concepts/network.md#subnet) for {{ sf-name }} [functions](../../functions/concepts/function.md), {{ serverless-containers-name }} [containers](../../serverless-containers/concepts/container.md), or {{ api-gw-name }} [API gateways](../../api-gateway/concepts/index.md) and submitted a request to use them to technical support, follow the steps below to migrate resources from the `{{ region-id }}-c` availability zone:

1. In the [cloud network](../../vpc/concepts/network.md#network) hosting the subnets, [create](../../vpc/operations/subnet-create.md) a new subnet.

   The requirements are as follows:
   * The subnet must be in the `{{ region-id }}-d` availability zone.
   * Make sure the subnet is the same for all functions, containers, and API gateways.
   * It must not contain any resources except functions, containers, and API gateways.
1. Contact [technical support]({{ link-console-support }}) and provide them with the new subnet's ID.

The support team will migrate the resources to the specified subnet.
