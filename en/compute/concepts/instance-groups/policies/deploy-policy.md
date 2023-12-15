# Deployment policy

When creating an instance group, you can choose how the instances will be deployed in the group.

The deployment policy is a set of restrictions defined in the `deploy_policy` key in the YAML file. Each restriction is set in its own key as a `key-value` pair.

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

| Key | Value |
| ----- | ----- |
| `max_creating` | Maximum number of instances being started at the same time.<br>Valid values range from 0 to 100. 0 means any number of instances within the allowed range. |
| `max_deleting` | Maximum number of instances being stopped at the same time.<br>Valid values range from 0 to 100. 0 means any number of instances within the allowed range. |
| `max_unavailable` | Maximum number of instances in the `RUNNING` status that can be removed to reduce the target size of the group.<br>Valid values range from 0 to 100. |
| `max_expansion` | Maximum number of instances that can be additionally allocated to expand the target size of the group. If the `max_unavailable` key is not specified or is zero, the `max_expansion` key value must not be zero.<br>Valid values range from 0 to 100. |
| `startup_duration` | Startup duration of an instance in the group. The instance starts receiving traffic only after the startup time expires and all health checks are passed.<br>Valid values range from 0 to 100. |

## Strategies for stopping instances {#strategy}

{{ ig-name }} supports two strategies for stopping instances when updating or [automatically scaling](../scale.md#auto-scale) a group: `PROACTIVE` and `OPPORTUNISTIC`.

If you use the proactive strategy, {{ ig-name }} will select which instances to stop on its own.

With the opportunistic strategy, {{ ig-name }}, rather than stopping the instances, will wait until at least one of the following conditions are met:
* User [stops](../../../operations/vm-control/vm-stop-and-start.md#stop) an instance in {{ compute-name }}.
* Application or user stops the instance internally.
* Instance fails the application [health check](../autohealing.md#functional-healthcheck).

For example, let's assume you created an instance group with automatic scaling based on the [custom metric](../scale.md#custom-metrics) of the number of jobs in the queue. {{ ig-name }} will create an instance group to run the jobs from the queue. As soon as there are no more jobs, {{ ig-name }} must reduce the group size from the actual size to the target one according to the [scaling policy](scale-policy.md).
  * If you selected proactive stop, {{ ig-name }} will change the target group size and decrease the actual number of instances in the group to the target amount.
  * Under the opportunistic strategy, {{ ig-name }} will change the target group size, but will not stop the instances until they are stopped by themselves or by the user.

Here is how a YAML file entry may look like:

```yaml
...
deploy_policy:
    strategy: OPPORTUNISTIC
...
```

Where:

| Key | Value |
| ----- | ----- |
| `strategy` | Strategy for stopping instances in a group.<br>Possible values include:<ul><li>`PROACTIVE`: {{ ig-name }} selects which instances to stop on its own.</li><li>`OPPORTUNISTIC`: {{ ig-name }} waits for the instances to stop on their own or until the user stops them.</li></ul> The default value is `PROACTIVE`. |

## Minimum actions to perform for an instance's update {#minimal-action}

By default, when updating an instance, {{ ig-name }} decides whether to restart or recreate them based on the [rules](../../instance-groups/deploy/instance.md). However, you can also set the minimum action to perform for updating an instance yourself. It will be executed even if the rules do not require that. This may be needed for cleaning up RAM or disks at an instance's update or redeploying the instance.

Please note that the update rules take priority over the minimum actions you set. For example, if you select an instance's restart as the minimum action, the instance may also be deleted if this is required by the rules.

You can manage minimum actions to perform for an instance's update using the [CLI](../../../../cli/quickstart.md) and [API](../../../api-ref/).

Here is how a YAML file entry may look like:

```yaml
...
deploy_policy:
    minimal_action: RESTART
...
```

Where:

| Key | Value |
| ----- | ----- |
| `minimal_action` | Minimum action to perform for an instance's update. The possible values include:<ul><li>`LIVE_UPDATE`: Update an instance without stopping it.</li><li>`RESTART`: Update an instance by restarting it.</li><li>`RECREATE`: Update an instance by recreating it.</li></ul> The default value is `LIVE_UPDATE`. |

#### See also {#see-also}

* [{#T}](healing-policy.md)
* [{#T}](scale-policy.md)
* [{#T}](allocation-policy.md)
