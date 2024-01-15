`security_groups`: [Security groups](../../../../../vpc/concepts/security-groups.md) for network traffic.

Security group rules apply to a transfer. They allow opening up network access from the transfer VM to the VM with the database. For more information, see [{#T}](../../../../../data-transfer/concepts/network.md).

Security groups must belong to the same network as the `subnet_id` subnet, if the latter is specified.

{% note info %}

In {{ TF }}, it is not required to specify a network for security groups.

{% endnote %}
