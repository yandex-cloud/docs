In {{ compute-name }}, you can temporarily disable one or more [availability zones](../../overview/concepts/geo-scope.md) for an [instance group](../../compute/concepts/instance-groups/index.md). This helps maintain your services available during events affecting the availability zone, such as testing, maintenance, outages, or [incidents](../../compute/concepts/instance-groups/zonal-inc/overview.md).

> For example, disabling a zone for an instance group prevents _gray failures_ in that zone, i.e., situations where health checks and monitoring tools show no failures, yet a portion of the actual traffic fails to reach your instances there.
> 
> Also, a good practice is to temporarily disable a zone during a zonal incident, so you can gradually reintroduce instances from the affected zone in a controlled manner. See [Instance group in a temporarily disabled zone during an incident](../../compute/concepts/instance-groups/disable-enable-zone.md#zonal-inc-shift) for details.

{% note warning %}

You cannot temporary disable zones for instance groups created by a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) as its node groups.

{% endnote %}

You can re-enable a group’s availability zone at any time or set a timeout for automatic reactivation.