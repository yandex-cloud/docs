# Fixing the `Permission denied to create UDP listener in folder` error when creating a {{ network-load-balancer-name }}



## Issue description {#issue-description}

When trying to create a network load balancer, you get this error message:

```
Error syncing load balancer: failed to ensure load balancer: failed to ensure cloud loadbalancer: failed to start cloud lb creation: rpc error: code = PermissionDenied desc = Permission denied to create UDP listener in folder b1g*****************
```

## Solution {#issue-resolution}

The option to enable a UDP port for a load balancer is currently being tested. You need to request access to it by [creating a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the cloud for which you need to enable UDP in {{ network-load-balancer-name }}.
1. Description of the scenario where you need this option and issues it will help you solve.

{% note info %}

Please note that UDP in {{ network-load-balancer-name }} is based on the *round-robin per-packet* algorithm. Therefore, for protocols that require *sticky sessions*, there is no guarantee that packets within one session will be delivered to the same target server.

{% endnote %}