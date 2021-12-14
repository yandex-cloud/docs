{% note alert %}

When creating instance groups, keep the [limits](../../compute/concepts/limits.md) in mind. To ensure {{ ig-name }} runs properly, don't manually modify or delete any of the resources it created: [target group](../../application-load-balancer/concepts/target-group.md) {{ alb-name }}, VMs, or disks. Instead of this, change or delete the entire group.

{% endnote %}

