---
title: Temporarily disabling an availability zone for a {{ compute-full-name }} instance group
description: You can temporarily disable an availability zone for an instance group.
---

# Temporarily disabling availability zones for {{ compute-full-name }} instance groups

{% include [disable-enable-zone-intro](../../../_includes/instance-groups/disable-enable-zone-intro.md) %}

For more information, see [{#T}](../../operations/instance-groups/disable-enable-zone.md).

When an availability zone is temporarily disabled, the instance group operates as follows:
* Instances in the disabled zone [will not be updated](disable-enable-zone.md#update) during group updates.
* Instances in the disabled zone [will not autoheal](disable-enable-zone.md#autohealing).
* When the group size is increased manually or automatically, [new instances will be created](disable-enable-zone.md#increase-size) only in enabled zones.
* Instances in the disabled zone [can be manually stopped or deleted](disable-enable-zone.md#manual-stop-delete).
* Operations which may create, start, or update instances in the disabled zone [will be completed](disable-enable-zone.md#operation-completion) only after the zone is re-enabled.

## Updating an instance in the group {#update}

In a disabled zone, instances will not be [updated](./deploy/index.md) until the zone is re-enabled. In other zones, instance updates will run normally. The disabled zone’s instances will get the target updates after the availability zone returns to its normal state.

{% note warning %}

To avoid losing all instances in the group during an update, instances from the disabled zone will count toward the `max_unavailable` limit set in the [deployment policy](./policies/deploy-policy.md). Therefore, to update group instances when a zone is disabled, increase the `max_expansion` value.

{% endnote %}

## Autohealing an instance in the group {#autohealing}

In a disabled zone, [autohealing](autohealing.md#healthcheck-cases) will no longer work, but other zones will remain unaffected:
* Instances deemed unhealthy based on their [status in {{ compute-name }}](autohealing.md#auto-healthcheck) will be recovered as normal without counting against any quota.
* Instances deemed unhealthy based on [application health checks](autohealing.md#functional-healthcheck) will be recovered within the `max_unavailable` quota. In the [deployment policy](policies/deploy-policy.md), this quota defines the maximum allowed number of unavailable instances during group updates. If autohealing is on, instances residing in the disabled zone are excluded from the `max_unavailable` quota, and in the other zones, the recovery will run normally.

## Increasing instance group size {#increase-size}

### Autoscaling instance groups {#increase-scalable}

Regardless of the [autoscaling type](scale.md#auto-scale-type), the number of instances in a disabled zone will not change. When a zone is disabled, new instances are created only in the remaining enabled zones, up to the `max_size` limit of the [scaling policy](policies/scale-policy.md#auto-scale-policy).

In groups with _zonal_ autoscaling, instances do not have to be evenly distributed across zones. The remaining enabled zones get new instances based on the load.

In groups with _regional_ autoscaling, instances are always evenly distributed across zones. Disabling a zone may cause imbalance in this distribution.

After the zone is re-enabled, instances are automatically redistributed across all zones based on the group's autoscaling type.

{% note warning %}

If you are using a network or an L7 load balancer in combination with an instance group with autoscaling, before disabling a zone in the load balancer, first, [disable](../../operations/instance-groups/disable-enable-zone.md#disable) this zone for the instance group. Otherwise, the instance group will continue creating instances in a zone which does not receive traffic.

Before enabling a zone in the load balancer, first, [enable](../../operations/instance-groups/disable-enable-zone.md#enable) this zone for the instance group to distribute its instances across the zones.

{% endnote %}

### Fixed-size instance groups {#increase-fixed-size}

In fixed-size groups, instances are always distributed evenly across availability zones. This behavior persists even while a zone is disabled.

Enabled zones will immediately get new instances; the disabled zone will get new instances after reactivation.

## Manually deleting and stopping instances {#manual-stop-delete}

To maintain service health, you can delete instances in the disabled zone using the [DeleteInstances](../../instancegroup/api-ref/InstanceGroup/deleteInstances.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/DeleteInstances](../../instancegroup/api-ref/grpc/InstanceGroup/deleteInstances.md) gRPC API call. 

Also, you can stop instances in the disabled zone using the [StopInstances](../../instancegroup/api-ref/InstanceGroup/stopInstances.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/StopInstances](../../instancegroup/api-ref/grpc/InstanceGroup/stopInstances.md) gRPC API call. 

When the zone is re-enabled, the instance group will restart the stopped instances and create any missing ones. However, if you used `createAnother` in the `DeleteInstances` method, new instances will be created until the zone is enabled.

## Completing instance group operations {#operation-completion}

Operations which may create, start, or update instances in the disabled zone will be completed only after the zone is re-enabled. These operations include creating, updating, and starting an instance group, as well as staged recreation and restart of instances within a group.

Operations which stop or delete instances in the disabled zone will run as normal. These operations include stopping or deleting an instance group as well as stopping and deleting instance within a group.

## Instance group in a temporarily disabled zone during an incident {#zonal-inc-shift}

During a zonal incident, [instance group behavior changes automatically](zonal-inc/multi-zonal.md). More stringent restrictions are imposed on actions you can take with instances in an affected zone, as opposed to when you disable a zone manually, which means disabling the zone will have no impact on the instance group.

{% note tip %}

During an incident, you can disable the affected zone in the instance group. This way, the restrictions on instance creation, startup, and update will continue to apply after the incident is over, so you can gradually reintroduce instances from the affected zone in a controlled manner.

{% endnote %}

### See also {#see-also}

* [{#T}](../../operations/instance-groups/disable-enable-zone.md)
* [Disabling and enabling availability zones in {{ network-load-balancer-full-name }}](../../../network-load-balancer/operations/manage-zone/disable-enable-zone.md)
* [Disabling and enabling availability zones in {{ alb-full-name }}](../../../application-load-balancer/operations/manage-zone/start-and-cancel-shift.md)
* [{#T}](./zonal-inc/overview.md)