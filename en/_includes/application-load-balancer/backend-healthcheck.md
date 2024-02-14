{% note alert %}

If all backends in an availability zone with health checks enabled fail the checks, traffic will stop routing to the zone, even if there are working backends without health checks in the zone.

We recommend configuring [health checks](../../application-load-balancer/concepts/backend-group.md#health-checks) for all backends.

{% endnote %}