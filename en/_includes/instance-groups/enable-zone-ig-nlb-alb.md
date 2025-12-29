{% note warning %}

If you are using a network or an L7 load balancer in combination with an instance group [with autoscaling](../../compute/concepts/instance-groups/scale.md#auto-scale), before enabling a zone in the load balancer, first, [enable](../../compute/operations/instance-groups/disable-enable-zone.md#enable) this zone for the instance group to distribute its instances across the zones.

{% endnote %}