# How to access a managed database from a function


## Case description {#case-description}

You need to connect to a managed database from a function.

## Solution {#case-resolution}

By default, a cloud function runs in an isolated IPv4 network with a [NAT gateway](../../../vpc/concepts/gateways.md) enabled.

To access a cluster, specify the ID of your cloud network containing the cluster in the function properties. In this case, the function will have access not only to the internet but also to user resources within the specified network, including VMs. For more information, see [this article](../../../functions/concepts/networking.md).

You can also configure database access from a function via external networks. This requires enabling public access on the database cluster. You will also need to set up an encrypted connection, which is required for accessing a database from external networks as per PCI DSS. For more info on connecting to a {{ mmy-name }} cluster, see [this guide](../../../managed-mysql/operations/connect.md).

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Cloud function ID.
1. Issue description.
