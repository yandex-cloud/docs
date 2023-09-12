# DataProc cluster is in the Unknown state immediately after creation

## Issue description {#issue-description}

When you create a DataProc cluster, its nodes remain in the Unknown state immediately after creation

## Solution {#issue-resolution}

The cluster can be in the UNKNOWN state because its instances are created without public IP addresses
They are not available from the internet and do not have internet access by default.

To grant online access to these instances, use the NAT gateway functionality.
1. [Create a NAT gateway](../../../vpc/operations/create-nat-gateway).
2. [Add a routing table](../../../vpc/operations/static-route-create) by selecting the created gateway as a NextHop node.
3. Link the routing table to the subnet with the cluster's instances:
4. [Set up security groups](../../../data-proc/operations/cluster-create#change-security-groups) if required.
   If you do not use security groups, skip this step.

As a result of these actions, the cluster should change to Running within several minutes.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:
1. ID of the problem DataProc cluster.
2. Date and time when the cluster creation started.
