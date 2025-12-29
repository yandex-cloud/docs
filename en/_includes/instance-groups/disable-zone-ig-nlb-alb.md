{% note warning %}

If you are using a network or an L7 load balancer in combination with an instance group [with autoscaling](../../compute/concepts/instance-groups/scale.md#auto-scale), before disabling a zone in the load balancer, first, [disable](../../compute/operations/instance-groups/disable-enable-zone.md#disable) this zone for the instance group. Otherwise, the instance group will continue creating instances in a zone which does not receive traffic.

{% endnote %}