# yc vpc

Manage {{ vpc-full-name }} resources.

#### Usage

Syntax:

`yc vpc <group>`

#### Groups

- `yc vpc network` — manage [networks](../../../vpc/concepts/network.md#network).
    - `get` — show information about the specified network.
    - `list` — list networks.
    - `create` — [create a network](../../../vpc/operations/network-create.md).
    - `update` — [update the specified network](../../../vpc/operations/network-update.md).
    - `delete` — [delete the specified network](../../../vpc/operations/network-delete.md).
    - `list-subnets` — list subnets from the specified network.
    - `list-operations` — list operations for the specified network.
- `yc vpc subnet` — manage [subnets](../../../vpc/concepts/network.md#subnet).
    - `get` — show information about the specified subnet.
    - `list` — list subnets.
    - `create` — [create a subnet in the specified network](../../../vpc/operations/subnet-create.md).
    - `update` — [update the specified subnet](../../../vpc/operations/subnet-update.md).
    - `delete` — [delete the specified subnet](../../../vpc/operations/subnet-delete.md).
    - `list-operations` — list operations for the specified subnet.
