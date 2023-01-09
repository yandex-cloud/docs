{% note info %}

Currently, session affinity only works if a single backend is active (has a positive weight) in a group of backends, includes one or more target groups, and the `MAGLEV_HASH` [load balancing mode](../../application-load-balancer/concepts/backend-group.md#balancing-mode) is selected for it.

{% endnote %}
