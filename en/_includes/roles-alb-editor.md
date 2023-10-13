#### alb.editor {#alb-editor}

The `{{ roles-alb-editor }}` role allows you to create, update, and delete resource model objects:
* [L7 load balancers](../application-load-balancer/concepts/application-load-balancer.md).
* [HTTP routers](../application-load-balancer/concepts/http-router.md).
* [Backend groups](../application-load-balancer/concepts/backend-group.md).
* [Target groups](../application-load-balancer/concepts/target-group.md).

{% note info %}

If you have both the `{{ roles-alb-admin }}` and `vpc.publicAdmin` roles to the network where the load balancer is located, you can create L7 load balancers with public IP addresses.

{% endnote %}

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
