{% if audience != "internal" %}

**Endpoint network interface**: Select or [create](../../../../../vpc/operations/subnet-create.md) a subnet in the desired [availability zone](../../../../../overview/concepts/geo-scope.md).

{% else %}

**Endpoint network interface**: Select or create a subnet in the desired availability zone.

{% endif %}

If the source and target are geographically close, connecting via the selected subnet speeds up the transfer.
