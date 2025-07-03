
{% note warning %}

To use the [YC CLI](../../cli/quickstart.md) or [API](../../overview/api.md) calls for resource create and update operations in [Cloud Interconnect](../../interconnect/concepts/index.md) and [Cloud Router](../../cloud-router/concepts/index.md), contact support.

{% endnote %}

## Steps to follow {#order}

Follow these steps when using [Cloud Interconnect](../../interconnect/concepts/index.md) and [Cloud Router](../../cloud-router/concepts/index.md) resources to create hybrid cloud network topologies:
1. Create a [trunk](../../interconnect/concepts/trunk.md) to establish physical connectivity between the on-prem infrastructure and the cloud. This resource is created in the cloud folder you specify.
1. Create a [private connection](../../interconnect/concepts/priv-con.md) in your trunk to establish IP and BGP connectivity between the on-prem infrastructure and the cloud. This resource is created in the same folder as the trunk.
1. Create a [routing instance](../../cloud-router/concepts/routing-instance.md) in the specified folder to build the required network topology, which typically includes [virtual networks (VPCs)](../../vpc/concepts/network.md) and private connections.
1. Add a private connection to the routing instance.
1. Add a list of defined subnet IP prefixes from virtual networks (VPCs) to the routing instance.
1. *Optionally*, add a list of defined static routes to the private connection to build the `VPC Stitching` network topology. 

Currently, to manage [Cloud Interconnect](../../interconnect/concepts/index.md) and [Cloud Router](../../cloud-router/concepts/index.md) resources, you can do one of the following:
* Contact support.
* Use the [YC CLI](../../cli/quickstart.md) or [API calls](../../overview/api.md). At the moment, these tools have limited availability.

Below, we provide a list of operations you can perform on [Cloud Interconnect](../../interconnect/concepts/index.md) and [Cloud Router](../../cloud-router/concepts/index.md) resources with links to relevant guides. You can also find the guides in `Step-by-step guides` and `Tutorials` for Cloud Interconnect or Cloud Router.


## Trunk {#trunk}

Action | Support | YC CLI
--- | --- | ---
Getting information about a trunk | — | [Description](../../interconnect/operations/trunk-get-info.md)
Getting a list of trunk operations | — | [Description](../../interconnect/operations/trunk-operations.md)
Creating a direct trunk | [Description](../../interconnect/tutorials/trunk-priv-add.md) | [Description](../../interconnect/operations/trunk-create.md#direct)
Updating trunk parameters | Yes | [Description](../../interconnect/operations/trunk-update.md)
Updating trunk capacity | [Description](../../interconnect/tutorials/trunk-capacity-change.md) | Not supported
Deleting a trunk | [Description](../../interconnect/tutorials/trunk-del.md) | [Description](../../interconnect/operations/trunk-delete.md)


## Private connection {#prc}

Action | Support | YC CLI
--- | --- | ---
Getting information about a private connection | — | [Description](../../interconnect/operations/priv-con-get-info.md)
Getting a list of operations for a private connection | — | [Description](../../interconnect/operations/priv-con-operations.md)
Creating a private connection | [Description](../../interconnect/tutorials/trunk-priv-add.md#priv-create) | [Description](../../interconnect/operations/priv-con-create.md)
Updating private connection parameters | Yes | [Description](../../interconnect/operations/priv-con-update.md)
Deleting a private connection | [Description](../../interconnect/tutorials/priv-del.md) | [Description](../../interconnect/operations/priv-con-delete.md)
**Adding static routes to a private connection** (VPC stitching) | **Yes** | [Description](../../interconnect/operations/priv-con-static-upsert.md)
**Removing static routes from a private connection** (VPC stitching) | **Yes** | [Description](../../interconnect/operations/priv-con-static-remove.md)


## Routing instance {#ri}

Action | Support | YC CLI
--- | --- | ---
Getting information about a routing instance | — | [Description](../../cloud-router/operations/ri-get-info.md)
Getting a list of operations in a routing instance | — | [Description](../../cloud-router/operations/ri-operations.md)
Creating a routing instance | Yes | [Description](../../cloud-router/operations/ri-create.md)
Updating routing instance parameters | Yes | [Description](../../cloud-router/operations/ri-update.md)
Updating the list of IP prefixes in a routing instance | [Description](../../cloud-router/tutorials/ri-prefixes-upsert.md) | [Description](../../cloud-router/operations/ri-prefixes-upsert.md)
Deleting IP prefixes from a routing instance | Yes | [Description](../../cloud-router/operations/ri-prefixes-remove.md)
Adding a private connection to a routing instance | Yes | [Description](../../cloud-router/operations/ri-priv-con-add.md)
Deleting a private connection from a routing instance | Yes | [Description](../../cloud-router/operations/ri-priv-con-del.md)
Deleting a routing instance | Yes | [Description](../../cloud-router/operations/ri-delete.md)


## Public connection {#pbc}

Action | Support | YC CLI
--- | --- | ---
Getting information about a public connection | — | [Description](../../interconnect/operations/pub-con-get-info.md)


## Other {#other}

Action | Support | YC CLI
 --- | --- | ---
Getting information about CIC partners | — | [Description](../../interconnect/operations/partner-get-info.md)
Getting information about points of presence | — | [Description](../../interconnect/operations/pop-get-info.md)

