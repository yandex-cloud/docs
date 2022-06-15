# yc vpc

Managing {{ vpc-full-name }} resources.

#### Command usage

Syntax:

`yc vpc <group>`

#### Groups

- `yc vpc network`: Manage [cloud networks](../../../vpc/concepts/network.md#network).
   - `get`: Get information about the specified cloud network.
   - `list`: Get a list of cloud networks.
   - `create`: [Create a cloud network](../../../vpc/operations/network-create.md).
   - `update`: [Update the specified cloud network](../../../vpc/operations/network-update.md).
   - `delete`: [Delete the specified cloud network](../../../vpc/operations/network-delete.md).
   - `list-subnets`: Get a list of subnets of the specified cloud network.
   - `list-operations`: Get a list of operations for the specified cloud network.
- `yc vpc subnet`: Manage [subnets](../../../vpc/concepts/network.md#subnet).
   - `get`: Get information about the specified subnet.
   - `list`: Get a list of subnets.
   - `create`: [Create a subnet in the specified cloud network](../../../vpc/operations/subnet-create.md).
   - `update`: [Update the specified subnet](../../../vpc/operations/subnet-update.md).
   - `delete`: [Delete the specified subnet](../../../vpc/operations/subnet-delete.md).
   - `list-operations`: Get a list of operations for the specified subnet.
