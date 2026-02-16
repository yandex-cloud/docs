{% note alert %}

If all backends with health checks enabled in an availability zone fail those checks, traffic will no longer route to that zone, even if functional backends without health checks remain.

We recommend configuring [health checks](../../application-load-balancer/concepts/backend-group.md#health-checks) for all backends.

{% endnote %}