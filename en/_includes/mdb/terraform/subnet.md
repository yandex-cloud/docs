{% if audience != "internal" %}
Subnets: Description of the [subnets](../../../vpc/concepts/network.md#subnet) to connect the cluster hosts to. If you already have suitable subnets, you don't have to describe them again.
{% else %}
Subnets: Description of the subnets to connect the cluster hosts to. If you already have suitable subnets, you don't have to describe them again.
{% endif %}
