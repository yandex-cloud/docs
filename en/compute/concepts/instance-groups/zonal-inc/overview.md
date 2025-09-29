# {{ compute-full-name }} instance groups during a zonal incident

A _zonal incident_ is a {{ yandex-cloud }} infrastructure failure affecting a single [availability zone](../../../../overview/concepts/geo-scope.md) within a [region](../../../../overview/concepts/region.md). Such incidents may impact the availability of resources in the affected zone as well as the behavior of multizonal resources, e.g., [instance groups](../index.md).

The [allocation policy](../policies/allocation-policy.md) distinguishes between these two instance group types:

* _Zonal_: All instances in the group are located in one availability zone.
* _Multizonal_: Instances in the group are distributed across multiple availability zones.

Instance group behavior during zonal incidents may vary depending on the instance group type:

* [Zonal group with instances outside the incident zone](#zonal-out)
* [Zonal group with instances in the incident zone](#zonal-in)
* [Multi-zonal group with instances outside the incident zone](#multi-zone-out)
* [Multi-zonal group with instances in the incident zone](#multi-zone-in)

Also, zonal incidents affect the behavior of services [running on instance groups](#other-services).

{% note warning %}

In case of a zonal incident, it is essential you take steps to mitigate its adverse effects on your own.

{% endnote %}

After the incident, instance groups are automatically fully recovered. If you modified the instance group configuration prior to the incident, it will be restored once the incident is over.

## Zonal group with instances outside the incident zone {#zonal-out}

Zonal incidents have no impact on zonal instance groups located outside the incident zone.

## Zonal group with instances in the incident zone {#zonal-in} 

{% note warning %}

In case of a zonal incident, a zonal instance group located in the incident zone may be fully unavailable. 

{% endnote %}

Once the incident is over, the group will be fully recovered. If the instance group was modified during the incident, e.g., the number of instances or their template was updated, these updates will automatically apply after the incident.

{% note tip %}

During an incident, create a new instance group in a healthy availability zone.

Also, to ensure fault tolerance, we recommend hosting instance groups in all availability zones.

{% endnote %}

## Multi-zonal group with instances outside the incident zone {#multi-zone-out}

Zonal incidents have no impact on instance groups located in multiple unaffected zones.

> For example, if the incident only affected the `{{ region-id }}-a` zone, and the group’s instances are located in the `{{ region-id }}-b` and `{{ region-id }}-d` zones.

{% note tip %}

During an incident, avoid updating the instance group’s allocation policy in terms of instance placement in the affected zone.

{% endnote %}

## Multi-zonal group with instances in the incident zone {#multi-zone-in}

{% note warning %}

In case of a zonal incident, all instances located in the incident zone may be unavailable. 

{% endnote %}

Zonal incidents affect instance group behavior in the incident area. To the most part, such an instance group will work correctly on other zones. For more information, see [{#T}](./multi-zonal.md).

## {{ yandex-cloud }} services running on instance groups {#other-services}

Some {{ yandex-cloud }} services base their resources on instance groups, e.g.:
* {{ alb-full-name }} uses instance groups as L7 load balancer [resource units](../../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling).
* {{ managed-k8s-full-name }} uses instance groups as cluster [node groups](../../../../managed-kubernetes/concepts/index.md#node-group).
* {{ ydb-full-name }} uses instance groups as [cluster nodes in dedicated mode](../../../../ydb/concepts/serverless-and-dedicated.md#dedicated).

{% note tip %}

To mitigate the effects of a zonal incident for such services, we recommend the same measures as when working with instance groups directly.

To compensate for lost capacity from the affected zone, set the maximum number of nodes or resource units with a performance buffer.

{% endnote %}