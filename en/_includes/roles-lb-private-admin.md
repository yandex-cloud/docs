#### load-balancer.privateAdmin {#lb-private-admin}

The `{{ roles-lb-private-admin }}` role allows you to create, update, and delete [load balancers](../network-load-balancer/concepts/index.md) and [target groups](../network-load-balancer/concepts/target-resources.md). However, this role does not allow you to make a load balancer available from the internet. For this, you need the `{{ roles-lb-admin }}` role.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
