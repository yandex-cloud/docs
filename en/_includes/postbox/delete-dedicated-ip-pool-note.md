{% note info %}

You cannot delete a pool linked to a [configuration](../../postbox/concepts/configuration.md). First, detach the pool from all configurations to which it is linked.

You can delete a pool even if it contains dedicated IP addresses: when you delete a pool, all IP addresses are automatically moved to the default pool named `ses-default-dedicated-pool`.

{% endnote %}
