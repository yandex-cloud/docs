# Resolving the "Permission denied to create UDP listener in folder" error when creating an NLB Balancer



## Issue description {#issue-description}

When trying to create a new network level balancer, you see this error message:

```text
Error syncing load balancer: failed to ensure load balancer: failed to ensure cloud loadbalancer: failed to start cloud lb creation: rpc error: code = PermissionDenied desc = Permission denied to create UDP listener in folder b1gXXXXXXXXXXXXXXXXX
```

## Solution {#issue-resolution}

The option to enable UDP port in the load balancer is in the testing phase and requires separate access granted upon request.
To gain access to this feature, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. Cloud ID for which you need to activate the UDP protocol in the network level balancer.
2. Description of the use case where you need this functionality and issues it will help you solve.

{% note info %}

Please note that UDP in the network level balancer operates in the `round robin per-packet mode`. Consequently, for protocols that are aware of the `sticky sessions` parameter, packet delivery from the same session to the same target server is not guaranteed.

{% endnote %}