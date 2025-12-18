 
# {{ dataproc-name }} cluster is in the `UNKNOWN` state right after it has been created


## Issue description {#issue-description}

After you create a {{ dataproc-name }} cluster, its nodes remain in the `UNKNOWN` state.

## Solution {#issue-resolution}

A cluster may be in the `UNKNOWN` state if you are creating its VMs without public IP addresses. They are not available from the internet and do not have internet access by default.

To grant online access to these instances, you will need to use a NAT gateway.

1. [Create a NAT gateway](../../../vpc/operations/create-nat-gateway.md).
1. [Add a route table](../../../vpc/operations/static-route-create.md), selecting the gateway you created as a next-hop node.
1. Link the routing table to the subnet with the cluster's VMs.
1. [Set up security groups](../../../data-proc/operations/cluster-create.md#change-security-groups) if required. If you do not use security groups, skip this step.

As a result, the cluster should change to `RUNNING` within a few minutes.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the {{ dataproc-name }} cluster in question.
1. Date and time when you started creating the cluster.
