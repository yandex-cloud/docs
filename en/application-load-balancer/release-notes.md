# {{ alb-full-name }} release notes

## Q2 2024 {#q2-2024}

* Added validation of internal IPv4 addresses when creating or updating a load balancer.
* Fixed the validation issue when creating and updating a target group that could place a backend without a specified weight in a group of backends with specified weights.

## Q1 2024 {#q1-2024}

* Improved stability of data processing and transmission (data plane) within the service.
* Implemented integration with [{{ sws-full-name }}](../smartwebsecurity/):
   * Connecting a [virtual host](./concepts/http-router.md#virtual-host) to a [security profile](../smartwebsecurity/concepts/profiles.md) (management console, CLI, {{ TF }}, API).
   * Sending {{ sws-name }} event logs to a {{ cloud-logging-full-name }} [log group](../logging/concepts/log-group.md).
   * Sending {{ sws-name }} metrics to [{{ monitoring-full-name }}](../monitoring/).
* Changed behavior of the [load balancer](./concepts/application-load-balancer.md) with `Stream` [backend groups](./concepts/backend-group.md): now connections to a backend will be closed if the backend fails a [health check](./concepts/backend-group.md#health-checks).
* Optimized the process of working with the list of operations with service resources.
* Added the ability to search for a load balancer in the management console by internal IP address.
* Added the ability to granularly place load balancer nodes in different availability zones using the management console.
* Improved the {{ TF }} provider performance: eliminated the validation error when changing a balancer listener's type from `TLS` to `Stream` and vice versa.
