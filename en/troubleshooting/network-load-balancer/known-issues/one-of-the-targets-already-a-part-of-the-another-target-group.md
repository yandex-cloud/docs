# Resolving the `One of the targets already a part of the another target group` error


## Issue description {#issue-description}

When creating a new {{ network-load-balancer-name }}, e.g., to deploy an NGINX Ingress Controller, the load balancer is not assigned a valid external IP address.

In the logs, you see errors like this:

```
Error syncing load balancer: failed to ensure load balancer: failed to ensure cloud target group: failed to start lb target group creation: request-id = <request_id> rpc error: code = FailedPrecondition desc = One of the targets already a part of the another target group: <ip_address>#<subnet_id> -> [<target_group_id>]
```

## Solution {#issue-resolution}

The error means that the nodes in your cluster are already part of a target group with this ID: `<target_group_id>`. This is why the system cannot create a {{ network-load-balancer-name }}: each load balancer can only have one target group connected, with target resources defined by the subnet ID and the internal IP address.

To solve this issue, remove nodes from the problematic group. You can do this in its settings.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). When creating a ticket, provide the following information:

1. Affected {{ network-load-balancer-name }}'s ID.
1. Date and time when the load balancer creation started.
1. Screenshot or text output of the error message from your ingress controller logs.
