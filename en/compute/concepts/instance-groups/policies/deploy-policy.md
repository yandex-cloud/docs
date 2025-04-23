# Deployment policy

When creating an instance group, you can choose how the instances will be deployed in the group.

The deployment policy is a set of restrictions defined in the `deploy_policy` key in the YAML file. Each restriction is set in a separate key as a `key:value` pair.

Here is how a YAML file entry may look like:

```yaml
...
deploy_policy:
    max_creating: 10
    max_deleting: 10
    max_unavailable: 10
    max_expansion: 0
    startup_duration: 30s
...
```

Where:

Key | Value
----- | -----
`max_creating` | Maximum number of isntances started simultaneously.<br>Acceptable values: 0 to 100. 0 means any number of instances within the allowed range.
`max_deleting` | Maximum number of instances stopped simultaneously.<br>Acceptable values: 0 to 100. 0 means any number of instances within the allowed range.
`max_unavailable` | Maximum number of instances in the `RUNNING` status by which the group's target size can be reduced.<br>Acceptable values: 0 to 100.
`max_expansion` | Maximum number of instances by which the group's target size can be exceeded^1^. If the `max_unavailable` key is not specified or is zero, a non-zero value must be specified for the `max_expansion` key.<br>Acceptable values: 0 to 100.
`startup_duration` | Startup duration of an instance in the group. The instance starts receiving traffic only after the startup time expires and all the health checks are passed.<br>The acceptable values range from 0 to 3,600 seconds.

^1^ Subsequently, when bringing the number of instances in the group to the target value, instances created under the `max_expansion` quota can remain in the group, while those that existed in the group before may be deleted.

## Strategies for stopping instances {#strategy}

{{ ig-name }} supports two strategies for stopping instances when updating or [automatically scaling](../scale.md#auto-scale) a group: automatic (`PROACTIVE`) and manual (`OPPORTUNISTIC`).

If you use the proactive strategy, {{ ig-name }} will select which instances to stop by itself.

With the opportunistic strategy, {{ ig-name }} does not stop the instances but waits until at least one of the following conditions is met:
* User [stops](../../../operations/vm-control/vm-stop-and-start.md#stop) an instance in {{ compute-name }}.
* Application or user stops the instance internally.
* The instance fails the application [health check](../autohealing.md#functional-healthcheck).

For example, you created an instance group with automatic scaling based on the [custom metric](../scale.md#custom-metrics) of the number of jobs in the queue. {{ ig-name }} creates an instance group that executes the jobs from the queue. As soon as there are no more jobs, {{ ig-name }} must reduce the group size from the actual size to the target one according to the [scaling policy](scale-policy.md).
  * If you selected the proactive stop, {{ ig-name }} will change the target group size and decrease the actual number of instances in the group to the target amount.
  * If you use the opportunistic strategy, {{ ig-name }} will change the target group size but will not stop the instances until they stop by themselves or are stopped by the user.

Here is how a YAML file entry may look like:

```yaml
...
deploy_policy:
    strategy: OPPORTUNISTIC
...
```

Where:

Key | Value
----- | -----
`strategy` | Strategy for stopping instances in a group.<br>The possible values are:<ul><li>`PROACTIVE`: {{ ig-name }} selects which instances to stop.</li><li>`OPPORTUNISTIC`: {{ ig-name }} waits for the instances to stop on their own or for the user to stop them.</li></ul> The default value is `PROACTIVE`.

## Minimum instance update actions {#minimal-action}

By default, when updating an instance, {{ ig-name }} decides whether to restart or recreate them based on the [rules](../../instance-groups/deploy/instance.md). However, you can also set the minimum instance update action yourself. It will be executed even if the rules do not require that. This may be needed for cleaning up RAM or disks at an instance's update or redeploying the instance.

Please note that the update rules take priority over the minimum actions. For example, if instance restart is selected as the minimum action, the instance may be also deleted if so required by the rules.

You can manage your minimum instance update actions using the [CLI](../../../../cli/quickstart.md) and [API](../../../api-ref/).

Here is how a YAML file entry may look like:

```yaml
...
deploy_policy:
    minimal_action: RESTART
...
```

Where:

Key | Value
----- | -----
`minimal_action` | Minimum instance update action. The possible values are:<ul><li>`LIVE_UPDATE`: Update the instance without stopping it.</li><li>`RESTART`: Update and restart the instance.</li><li>`RECREATE`: Update and recreate the instance.</li></ul> The default value is `LIVE_UPDATE`.

## Use cases {#examples}

* [{#T}](../../../tutorials/autoscale-monitoring.md)

#### See also {#see-also}

* [{#T}](healing-policy.md)
* [{#T}](scale-policy.md)
* [{#T}](allocation-policy.md)