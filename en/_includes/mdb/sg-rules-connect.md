{% if audience != "internal" %}

To connect to a cluster, [security groups](../../vpc/concepts/security-groups.md) must include rules allowing traffic from certain ports, IP addresses, or from other security groups.

{% else %}

To connect to a cluster, security groups must include rules allowing traffic from certain ports, IP addresses, or from other security groups.

{% endif %}
