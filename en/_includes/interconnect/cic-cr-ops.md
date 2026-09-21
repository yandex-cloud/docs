## Steps to follow {#order}

To create a hybrid cloud network topology:

1. [Create a trunk](../../interconnect/operations/trunk-create.md) to establish physical connectivity between your infrastructure and {{ yandex-cloud }}.
1. In your trunk, create a [private](../../interconnect/operations/priv-con-create.md) or [public](../../interconnect/operations/pub-con-create.md) connection.
1. For a private connection, [create a virtual router](../../cloud-router/operations/ri-create.md).
1. [Add the private connection](../../cloud-router/operations/ri-priv-con-add.md) to the virtual router.
1. [Add cloud networks and IP prefixes](../../cloud-router/operations/ri-prefixes-upsert.md) to announce to your infrastructure.
1. If needed, [add static routes](../../interconnect/operations/priv-con-update.md) to the private connection for the VPC Stitching topology.

You can perform most operations with {{ interconnect-name }} and {{ cr-name }} resources yourself using the management console, CLI and API. You still need to contact support to create, update, and delete public connections, update trunk capacity, notify your partner, and physically cross-connect your direct connection.

## Trunk {#trunk}

Action | You | Support
--- | --- | ---
Getting information | [Guide](../../interconnect/operations/trunk-get-info.md) | —
Getting a list of operations | [Guide](../../interconnect/operations/trunk-operations.md) | —
Creating a direct connection | [Guide](../../interconnect/operations/trunk-create.md#direct) | Agreement letter and physical connection are described in the guide
Creating a partner connection | [Guide](../../interconnect/operations/trunk-create.md#partner) | Partner notification is described in the guide
Updating basic settings | [Guide](../../interconnect/operations/trunk-update.md#update) | —
Changing capacity | — | [Guide](../../interconnect/operations/trunk-update.md#capacity)
Moving to another folder | [Guide](../../interconnect/operations/trunk-move.md) | —
Deleting | [Guide](../../interconnect/operations/trunk-delete.md) | —

## Private connection {#prc}

Action | You | Support
--- | --- | ---
Getting information | [Guide](../../interconnect/operations/priv-con-get-info.md) | —
Getting a list of operations | [Guide](../../interconnect/operations/priv-con-operations.md) | —
Create | [Guide](../../interconnect/operations/priv-con-create.md) | —
Updating settings | [Guide](../../interconnect/operations/priv-con-update.md) | —
Moving to another folder | [Guide](../../interconnect/operations/priv-con-move.md) | —
Deleting | [Guide](../../interconnect/operations/priv-con-delete.md) | —
Adding or deleting static routes | [Guide](../../interconnect/operations/priv-con-update.md) | —

## Virtual router {#ri}

Action | You | Support
--- | --- | ---
Getting information | [Guide](../../cloud-router/operations/ri-get-info.md) | —
Getting a list of operations | [Guide](../../cloud-router/operations/ri-operations.md) | —
Create | [Guide](../../cloud-router/operations/ri-create.md) | —
Updating basic settings | [Guide](../../cloud-router/operations/ri-update.md) | —
Updating networks and IP prefixes | [Guide](../../cloud-router/operations/ri-prefixes-upsert.md) | —
Adding a private connection | [Guide](../../cloud-router/operations/ri-priv-con-add.md) | —
Deleting a private connection | [Guide](../../cloud-router/operations/ri-priv-con-del.md) | —
Deleting | [Guide](../../cloud-router/operations/ri-delete.md) | —

## Public connection {#pbc}

Action | You | Support
--- | --- | ---
Getting information | [Guide](../../interconnect/operations/pub-con-get-info.md) | —
Create | — | [Guide](../../interconnect/operations/pub-con-create.md)
Edit | — | [Contacting support]({{ link-console-support }})
Deleting | — | [Guide](../../interconnect/operations/pub-con-delete.md)

## Other {#other}

Action | You
--- | ---
Getting information about {{ interconnect-name }} partners | [Guide](../../interconnect/operations/partner-get-info.md)
Getting information about points of presence | [Guide](../../interconnect/operations/pop-get-info.md)
