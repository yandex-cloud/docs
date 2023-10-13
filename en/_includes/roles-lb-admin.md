#### load-balancer.admin {#lb-admin}

The `{{ roles-lb-admin }}` role allows you to:
- Create, update, and delete [load balancers](../network-load-balancer/concepts/index.md) and [target groups](../network-load-balancer/concepts/target-resources.md).
- Assign a [public IP address](../vpc/concepts/address.md) to a load balancer.

{% note info %}

If you have both the `{{ roles-lb-admin }}` role and the create VM permission, you can create VMs with public IPs. If this is not what you want, use the `{{ roles-lb-private-admin }}` role.

{% endnote %}

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
