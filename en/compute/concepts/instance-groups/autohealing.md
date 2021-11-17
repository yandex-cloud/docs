# Auto-healing

{{ ig-name }} runs regular health checks for instances in your group. If an instance stopped or an app is taking too long to respond, {{ ig-name }} tries to heal the instance: it either restarts it or creates a new one, depending on the [deployment policy](policies/deploy-policy.md).

{% note info %}

If for an instance group, [processes are paused](stopping-pausing.md) ([status](statuses.md#group-statuses) is `PAUSED`), instances aren't healed.

{% endnote %}

## Types of health checks {#setting-up-health-checks}

To ensure auto-healing, {{ ig-name }} performs two types of health checks:

* [Instance operability check](#auto-healthcheck).
* [Application health check on the instance](#functional-healthcheck).

Don't confuse these checks with the [network load balancer health check](../../../network-load-balancer/concepts/health-check.md), which doesn't auto-heal the instance. It only affects the deployment process: when at startup the instance switches to the [status](statuses.md) `OPENING_TRAFFIC`, {{ ig-name }} waits until the instance status in the load balancer is `HEALTHY`. After that {{ ig-name }} stops monitoring the instance status in the load balancer.

### Instance operability check {#auto-healthcheck}

{{ ig-name }} checks the [instance status](../vm-statuses.md) in {{ compute-name }} every few seconds. If the instance has stopped or an error occurred (the statuses `STOPPED`, `ERROR`, and `CRASHED`), {{ ig-name }} will try to restart the instance and create a new one, provided that this is allowed by the [deployment policy](#healthcheck-and-deploy).

### Application health check on the instance {#functional-healthcheck}

This check will detect if the app running on your instance has frozen, terminated, or is taking too long to respond. You can [enable the application health check](../../operations/instance-groups/enable-autohealing.md) when creating or editing an instance.

If you enabled this check, {{ ig-name }} will poll the application status on the instance at preset intervals while the instance group is in the [status](statuses.md) `ACTIVE`.

#### Recommendations for instance groups with a load balancer {#healthcheck-and-balancer}

If you [created an instance group with a network load balancer](../../operations/instance-groups/create-with-balancer.md), use less strict settings for checks in {{ ig-name }} than for the [load balancer health checks](../../../network-load-balancer/concepts/health-check.md). The load balancer allocates the load on the app, while {{ ig-name }} only monitors the app performance.

> For example, if you set a 1-second response timeout in the network load balancer, then set 30 seconds in {{ ig-name }}. If the application doesn't respond for 3-5 seconds, it might not be able to handle the current traffic. On the other hand, if the application doesn't respond for more than 30 seconds, it probably isn't working at all and you need to heal your instance.

## Auto-healing specifics {#healthcheck-cases}

### Auto-healing and deployment policies {#healthcheck-and-deploy}

To auto-heal instances, {{ ig-name }} may restart instances or create new ones. The healing method is set in the [deployment policies](policies/deploy-policy.md).

* Creating new instances
{{ ig-name }} will create new instances to replace any that fail their health checks, provided the deployment policy permits expanding the target group size. You can set the maximum number of instances that can be allocated to expand the target size of the group by using the `max_expansion` parameter. Acceptable values: from `0` to `100`. In this case, {{ ig-name }} will first create a new instance, wait until it passes all the checks, and then undeploy the instance that failed the check.

* Restarting an instance
{{ ig-name }} will restart instances that failed their health check if the deployment policy permits reducing the target group size. You can use  the `max_unavailable` parameter to set the maximum number of instances that can be made unavailable at the same time. Acceptable values: from `0` to `100`. {{ ig-name }} will try not to exceed this value during auto-healing.

  This restriction does not apply to instances with the [statuses](../vm-statuses.md) `CRASHED`, `ERROR`, and `STOPPED`, because in these cases the instance is already unavailable and must be restarted immediately.

If you set both `max_expansion` and `max_unavailable`, {{ ig-name }} will use both auto-healing methods.

> For example, you set `max_expansion = 1` and `max_unavailable = 1`. When one instance fails the check, {{ ig-name }} begins restarting this instance and creating a new one at the same time. The instance that passes all the checks successfully continues running and the other instance is undeployed.

To limit the speed of auto-healing and deployment, you can also set:

* The maximum number of instances that are deployed at the same time using the `max_creating` parameter. This includes the created and started instances with the statuses `CREATING` and `STARTING`.

  Acceptable values: from `0` to `100`. Value `0`: Any number of instances within the allowed range.

* The maximum number of instances that are undeployed at the same time, using the `max_deleting` parameter. This includes the instances being stopped with the `STOPPING` status, since {{ ig-name }} always stops instances before undeploying them.

  Acceptable values: from `0` to `100`. Value `0`: Any number of instances within the allowed range.

### Changing instance status during auto-healing {#healtcheck-and-vm-state}

{{ ig-name }} won't try to heal an instance if it is no longer needed.

> For example, if all 10 instances in a group of 10 are unavailable and `max_unavailable = 3`, {{ ig-name }} restarts the first three instances. If the remaining seven instances become operable again in the meantime, {{ ig-name }} won't restart them.
>
> If `max_expansion = 3`, {{ ig-name }} starts creating three new instances. The old instances are not deleted until the new ones are created. If all instances of the instance group become operable again during the creation process, {{ ig-name }} cancels the creation of new instances.

### Healing while updating instance configurations {#healtcheck-and-vm-update}

Instance healing has a higher priority than instance configuration update.

> Let's say you have a group of 100 instances and `max_unavailable = 1`. When you update the instance configuration in an instance group, {{ ig-name }} will restart the instances one by one, updating their configuration.
>
> If one of the instances fails the application health check at that point, {{ ig-name }} makes it the first one in the restart queue.

### Healing on instance group size change {#healthcheck-and-group-size}

When the target size of the instance group is reduced, the instances that failed the check are deleted first (if any).

If you increase the target size of the instance group, new instances will be created in parallel with creation of instances that failed the check, provided that it is allowed by `max_creating` and `max_expansion`:

> Let's say 2 out of 4 instances in an instance group failed the [application health check](#functional-healthcheck). At that point, the target size of the instance group has increased to 6 instances. You have two instances to create and another two to heal.
>
> If `max_expansion = 1` and `max_creating` is not set, then {{ ig-name }} will start creating three instances in parallel: two under the instance group expansion, and one under the auto-healing process.

### Auto-healing preemptible instances {#healthcheck-preemptible-vm}

[Preemptible](../preemptible-vm.md) instances can only be auto-healed if the computing resources in the availability zone allow for this. If the resources are insufficient, {{ ig-name }} will resume auto-healing as soon as the resources become available, but this may take a long time.

Preemptible VMs must be terminated within 24 hours of their launch. In this case, there is a risk that the entire instance group will restart at the same time and stop handling the load of running applications. To avoid this, {{ ig-name }} stops preemptible instances in the group not exactly after 24 hours, but after a random interval from 22 to 24 hours.

#### See also {#see-also}

* [{#T}](../../operations/instance-groups/enable-autohealing.md).
