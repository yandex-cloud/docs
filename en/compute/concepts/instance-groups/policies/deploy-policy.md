# Deployment policy

When creating an instance group, you can choose how the instances will be deployed in the group.

The deployment policy is a set of restrictions defined in the `deploy_policy` key in the YAML file. Each restriction is set in its own key as a `key-value` pair.

Example of a YAML file entry:

```
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
| `max_creating` | Maximum number of instances started at the same time.<br>Valid values are from 0 to 100. Value 0: Any number of instances within the allowed range. |
| `max_deleting` | Maximum number of instances stopped at the same time.<br>Valid values are from 0 to 100. Value 0: Any number of instances within the allowed range. |
| `max_unavailable` | The maximum number of instances in the `RUNNING` state that can be removed to reduce the target size of the group.<br>Valid values are from 0 to 100. |
| `max_expansion` | The maximum number of instances that can be additionally allocated to expand the target size of the group. If the `max_unavailable` key is not specified or is zero, then the `max_expansion` key value must be non-zero.<br>Valid values are from 0 to 100. |
| `startup_duration` | Startup duration of an instance in the group. The instance starts receiving traffic only after the startup time expires and all the health checks are passed.<br>Valid values are from 0 to 100. |

## Strategies for stopping instances {#strategy}

{{ ig-name }} supports two strategies for stopping instances when updating or [automatically scaling](../scale.md#auto-scale) a group: `PROACTIVE` and `OPPORTUNISTIC`.

If a proactive strategy is selected, {{ ig-name }} selects which instances to stop on its own.

With an opportunistic strategy, {{ ig-name }} doesn't stop the instances, but waits until at least one of the following conditions are met:
* The user [stopped](../../../operations/vm-control/vm-stop-and-start.md#stop) an instance in {{ compute-name }}.
* The application or user stopped the instance internally.
* The instance failed the application [health check](../autohealing.md#functional-healthcheck).

For example, you created an instance group with automatic scaling based on the [custom metric](../scale.md#custom-metrics) of the number of jobs in the queue. {{ ig-name }} creates an instance group that executes the jobs from the queue. As soon as the queue runs out of jobs, {{ ig-name }} must reduce the group size from the actual size to the target size according to the [scaling policy](scale-policy.md).
* If you selected proactive stop, {{ ig-name }} changes the target group size and decreases the actual number of instances in the group to the target amount.
* Under the opportunistic strategy, {{ ig-name }} changes the target group size, but does not stop the instances until they are stopped by themselves or by the user.

Example of a YAML file entry:

```
...
deploy_policy:
    strategy: OPPORTUNISTIC
...
```

Where:

| Key | Value |
| ----- | ----- |
| `strategy` | Strategy for stopping instances in a group.<br>Possible values:<br>- `PROACTIVE`: {{ ig-name }} selects which instances to stop on its own.<br>- `OPPORTUNISTIC`: {{ ig-name }} waits until the instances stop by themselves or by the user.<br>Default: `PROACTIVE`. |