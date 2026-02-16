{% note info %}

Currently, session affinity only works for a single active backend in a group, containing at least one target group and using the `MAGLEV_HASH` [load balancing mode](../../application-load-balancer/concepts/backend-group.md#balancing-mode).

{% endnote %}