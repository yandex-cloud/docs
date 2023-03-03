{% if audience != "internal" %}

If you no longer need the created resources, delete the [VM instance](../../compute/operations/vm-control/vm-delete.md) and the [{{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).

If you have reserved a public static IP address for the created VM, [delete it](../../vpc/operations/address-delete.md).

{% else %}

If you no longer need the created resources, delete the VM instance and the {{ mkf-name }} cluster.

If you have reserved a public static IP address for the created VM, delete it.

{% endif %}
