# How to recover an accidentally deleted external IP address for a VM or load balancer


## Case description {#case-description}

You need to regain the IP address that disappeared after restarting the VM or load balancer.

## Solution {#case-resolution}

The address may already be occupied by another client, so we recommend reserving a static public IP address. For more details, see [this article](../../../vpc/operations/get-static-ip.md).

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. IP address.
1. Folder ID.
