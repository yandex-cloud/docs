# Migrating between zones

To migrate [subnets](../../vpc/concepts/network.md#subnet) for [{{ sf-name }}](../../functions/concepts/function.md), [{{ serverless-containers-name }}](../../serverless-containers/concepts/container.md), or [{{ api-gw-name }}](../../api-gateway/concepts/index.md) to a different zone, follow these steps:

1. In the [cloud network](../../vpc/concepts/network.md#network) hosting the subnets, [create](../../vpc/operations/subnet-create.md) a new subnet.

    The requirements are as follows:
    * The subnet must be in the zone you want to migrate your resources to.
    * Make sure the subnet is the same for all functions, containers, and API gateways.
    * It must not contain any resources except functions, containers, and API gateways.
1. Provide the new subnet ID to [technical support]({{ link-console-support }}).

The support team will migrate your resources to the specified subnet for you.
