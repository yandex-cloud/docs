# Auto-healing

{{ ig-name }} regularly runs health checks for the instances in your instance group. If an instance has stopped or an app is taking too long to respond, {{ ig-name }} will try to recover the instance: either it will restart it or create a new one, depending on the [deployment policy](policies/deploy-policy.md).

## Types of health checks {#setting-up-health-checks}

For automatic recovery, {{ ig-name }} performs two types of health checks:

* [Instance operability check](#auto-healthcheck).
* [Application health check on the instance](#functional-healthcheck).

Don't confuse these checks with the [network load balancer health check](../../../network-load-balancer/concepts/health-check.md), which doesn't result in automatic instance recovery. It only affects the deployment process: when at startup the instance switches to the [status](statuses.md) `OPENING_TRAFFIC`, {{ ig-name }} waits until the instance status in the load balancer is `HEALTHY`. After that {{ ig-name }} stops monitoring the instance status in the load balancer.

### Instance operability check {#auto-healthcheck}

{{ ig-name }} checks [the instance status ](../vm-statuses.md)  in {{ compute-name }} every few seconds. If the instance has stopped or an error occurred (the statuses `STOPPED`, `ERROR`, `CRASHED`), {{ ig-name }} will try to restart the instance and create a new instance, if this is allowed by the [deployment policy](#healthcheck-and-deploy).

### Application health check on the instance {#functional-healthcheck}

This check will detect if the app running on your instance has frozen, terminated, or is taking too long to respond. You can [enable the application health check](../../operations/instance-groups/enable-autohealing.md) when creating or modifying an instance.

If you enabled this check, {{ ig-name }} will periodically query the status of the application on the instance for as long as the instance group is in the [status](statuses.md) `ACTIVE` status.

#### Recommendations for instance groups with a network load balancer {#healthcheck-and-balancer}

If you [created a group with a network load balancer](../../operations/instance-groups/create-with-balancer.md), then use less strict settings for checks in {{ ig-name }} than for the [load balancer health checks](../../../network-load-balancer/concepts/health-check.md). The load balancer allocates the load on the app, while {{ ig-name }} only monitors the app performance.

> For example, if you set the 1-second response timeout in the network load balancer, then set 30 seconds in {{ ig-name }}. If the application doesn't respond for 3-5 seconds, it might not be able to handle the current traffic. On the other hand, if the application doesn't respond for more than 30 seconds, it probably isn't working at all and you need to recover your instance.

## Automatic recovery process {#healthcheck-cases}

### Recovery process and deployment policies {#healthcheck-and-deploy}

For the purpose of instance recovery, {{ ig-name }} can restart  and create new instances, depending on the deployment policy settings:

* For {{ ig-name }} to create new instances to replace those that failed the health check, set `max_expansion` — the maximum number of instances you can add to the target size of the instance group. Acceptable values: 0 to 100.

    {{ ig-name }} will first create a new instance, wait until it passes all the checks, and then delete the instance that failed the check.

* For {{ ig-name }} to restart the instances that failed the check, set `max_unavailable` — the maximum number of instances that you can make unavailable at the same time. {{ ig-name }} will aim not to exceed this at automatic recovery. Acceptable values: 0 to 100.

    This restriction does not apply to the instances in the [statuses](../vm-statuses.md) `STOPPED`, `ERROR`, and `CRASHED`, because they imply that the instance is already unavailable and must be restarted immediately.

* For {{ ig-name }} to employ all the recovery methods in parallel, set both `max_expansion` and `max_unavailable`.

    > Let's say you specified `max_expansion = 1` and `max_unavailable = 1`. When one instance fails the check, Instance Groups will begin restarting this instance and creating a new one in parallel. The instance that passes all the checks successfully will continue running and the other one will be deleted.

* To limit the speed of recovery and deployment you can also use the following parameters:
    * `max_creating` — Limits the number of instances that are deployed at the same time, meaning the created and started instances in the statuses `CREATING` and `STARTING`.<br>Acceptable values: 0 to 100. The value 0 is any number of instances within the allowed values.
    * `max_deleting` — Limits the number of instances undeployed at the same time, meaning instances in the `STOPPING` status. When deleting an instance, {{ ig-name }} always stops it first, hence this status is used to limit the workload.<br>Acceptable values: 0 to 100. The value 0 is any number of instances within the allowed values.

### Change the instance status at recovery {#healtcheck-and-vm-state}

{{ ig-name }} will not restore the instance if it is no longer needed.

> For example, if all 10 instances in an instance group of 10 are available and `max_unavailable = 3`, {{ ig-name }} will restart the first three instances. If the remaining seven instances become operable again in the meantime, {{ ig-name }} won't restart them.
>
> If `max_expansion = 3`, {{ ig-name }} starts creating three new instances. The old instances are not deleted until the new ones are created. If all instances of the instance group become operable again during the creation process, {{ ig-name }} cancels the creation of new instances.

### Recovery while updating instance configurations {#healtcheck-and-vm-update}

Instance recovery has a higher priority than instance configuration update.

> Let's say you have a group of 100 instances and `max_unavailable = 1`. When you update the instance configuration in an instance group, {{ ig-name }} will restart the instances one by one, updating their configuration.
>
>If one of the instances fails the application health check at that point, {{ ig-name }} makes it the first one in the restart queue.

### Recovery on instance size change {#healthcheck-and-group-size}

When the target size of the instance group is reduced, the instances that failed the check are deleted first (if any).

If you increase the target size of the instance group, new instances will be created in parallel with creation of instances that failed the check, provided that it is allowed by `max_creating` and `max_expansion`:

> Let's say 2 out of 4 instances in an instance group failed the [application health check](#functional-healthcheck). At that point, the target size of the instance group has increased to 6 instances. You have two instances to create and another two to recover.
>
>If `max_expansion = 1` and `max_creating` is not set, then {{ ig-name }} will start creating three instances in parallel: two under the instance group expansion, and one under the recovery process.

### Auto-healing preemptible instances {#healthcheck-preemptible-vm}

[Preemptible](../preemptible-vm.md) instances can only be auto-healed if the computing resources in the availability zone allow for this. If the resources are insufficient, {{ ig-name }} will resume auto-healing as soon as the resources become available, but this may take a long time.

Preemptible VMs must be terminated within 24 hours of their launch. However, in this case, there is a risk that the entire instance group will restart at the same time and stop handling the load of running applications. To avoid this, {{ ig-name }} stops preemptible instances in the group not exactly after 24 hours, but after a random interval from 22 to 24 hours.

#### See also {#see-also}

* [{#T}](../../operations/instance-groups/enable-autohealing.md).

