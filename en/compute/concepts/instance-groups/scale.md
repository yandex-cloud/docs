# Scaling types

Choose the group scaling type when creating each group. The type determines whether the number of instances in the group will change automatically or manually.

## Manually scaled groups {#fixed-scale}

{{ ig-name }} allows you to create groups with a fixed number of instances. You can manage the size of this group manually based on your current computing needs.

## Automatically scaled groups {#auto-scale}

{{ ig-name }} lets you create automatically scaled instance groups. When creating an instance group, you specify a target load level. The service continuously re-adjusts the number of instances to keep the average load below the target level.

For optimum adjustment sensitivity, {{ ig-name }} lets you set a *stabilization period*: after the number of instances in the group increases, instances aren't deleted until the end of stabilization period, even if the load already dropped substantially.

To determine the necessary number of instances, {{ ig-name }} periodically measures the average load on the group and correlates it with the target level.

Algorithm of service actions outside the stabilization period:

1. Calculate the average CPU load on every instance, except those with the WARMING UP status. The load is measured several times per minute on every instance. The resulting values are averaged for each instance over the load measurement interval you set when creating a group.

   Instances that are warming up are ignored when measurements are taken, because they might demonstrate an abnormally high load (you can set your warm-up interval when creating a group).

2. Calculate the average load on each instance and additionally average it across availability zones.

   For example, a group of 4 instances is located entirely in one zone. One of the instances starts, while the others are under 90%, 75%, and 85% workload. Average load across the zone: (90+75+85) / 3 = 83.4%

1. Obtain the total load: multiply the resulting average load by the total number of instances. In the example, 83.4 × 4 = 333.6%

2. Divide the total load by the target load level per zone to obtain the number of instances needed (the result is rounded up). Say, for example, the target level is 75%. This means that you need 333.6 / 75 = 4.48 ~ 5 instances.

Based on the approximate results, you need to create another instance. {{ ig-name }} starts this process, and begins calculating the average load again.

#### See also {#see-also}

- [{#T}](policies.md#scale-policy).
- [{#T}](../../operations/instance-groups/create-fixed-group.md).
- [{#T}](../../operations/instance-groups/create-autoscaled-group.md).

