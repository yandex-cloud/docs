# Troubleshooting {{ managed-k8s-name }} pod access via {{ network-load-balancer-name }}


## Issue description {#issue-description}

You cannot get access to applications in the {{ managed-k8s-name }} cluster via {{ network-load-balancer-name }} endpoints.
  
## Solution {#issue-resolution}

If you use a load balancer that is associated with a security group, you need to create a rule in this group allowing traffic from the load balancer to {{ managed-k8s-name }} cluster nodes on ports in the range from `30000` to `32767`.

{% note info % }

When routing traffic, the load balancer only changes the destination port, while the original IP address of the query remains the same. Therefore, you should specify the `0.0.0.0/0` address range in the allow rule.

{% endnote %}

Learn more about `NodePort` type services in [this official {{ k8s }} guide](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). In your request, provide the following information:

1. {{ network-load-balancer-name }} ID.
1. {{ managed-k8s-name }} cluster ID.
1. Information about pods running your applications that require network access via a load balancer, and the ports they receive traffic on.
