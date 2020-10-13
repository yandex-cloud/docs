### load-balancer.privateAdmin {#lb-private-admin}

The `{{ roles-lb-private-admin }}` role lets you create, update, and delete [load balancers](../load-balancer/concepts/index.md) and [target groups](../load-balancer/concepts/target-resources.md). However, this role doesn't let you make a load balancer available from the internet. For this, you need the `{{ roles-lb-admin }}` role.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}

