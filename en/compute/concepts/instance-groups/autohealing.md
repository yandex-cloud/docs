# Automatic recovery

{{ ig-name }} automatically identifies and corrects unhealthy instances in a group to ensure their optimal performance. However, keep in mind that the state of an instance does not indicate how an application works. You may need to restart the instance if the application freezes, crashes, or runs out of memory (RAM).

Groups that enable automatic instance recovery are automatically fault-tolerant, meaning that {{ ig-name }} restarts an instance if the application fails.

### Setting up health checks {#setting-up-health-checks}

To enable automatic recovery of instances in a group, you need to describe how and how often to perform health checks (not to be confused with [health checks](../../../load-balancer/concepts/health-check.md) for {{ load-balancer-full-name }}). {{ ig-name }} sends requests and gets application health data in response.

When creating or updating a group, you can set:

- Protocol and port to be used for performing health checks.
- Check interval.
- Response timeout.
- Required number of repeated checks.

#### See also {#see-also}

- [{#T}](../../operations/instance-groups/enable-autohealing.md).

