# Health checks and autohealing of instances in a group

{{ ig-name }} regularly runs health checks for instances in your instance group. If an instance stopped or an app is taking too long to respond, {{ ig-name }} tries to heal the instance by either restarting it or creating a new one, depending on the [deployment policy](policies/deploy-policy.md).

{% note info %}

If you [pause processes](stopping-pausing.md) (switch them to the `PAUSED` [status](statuses.md#group-statuses)) in an instance group, your instances will not be healed.

{% endnote %}

## Types of health checks {#setting-up-health-checks}

To ensure autohealing, {{ ig-name }} performs two types of health checks:
* [Instance operability check](#auto-healthcheck).
* [Application health check on the instance](#functional-healthcheck).

Do not confuse these checks with those the load balancer performs if an instance group is [integrated with {{ network-load-balancer-full-name }} or {{ alb-full-name }}](balancers.md). The load balancer health check only affects the deployment process: when, at startup, the instance switches to the `OPENING_TRAFFIC` [status](statuses.md), {{ ig-name }} waits until the instance status switches to `HEALTHY` in the load balancer. After that, {{ ig-name }} stops monitoring the instance status in the load balancer. You can also set up instance autohealing for health checks from the load balancer. For more information, see [{#T}](balancers.md#principles-health-checks).

### Instance operability check {#auto-healthcheck}

{{ ig-name }} checks the [instance status](../vm-statuses.md) in {{ compute-name }} every few seconds. If an instance stopped or an error occurred (the VM switched to the `STOPPED`, `ERROR`, or `CRASHED` status), {{ ig-name }} will try to restart the instance and create a new one, if this is allowed by the [deployment policy](#healthcheck-and-deploy).

### Application health check on the instance {#functional-healthcheck}

This check will detect if the app running on your instance has frozen, terminated, or is taking too long to respond. You can [enable the application health check](../../operations/instance-groups/enable-autohealing.md) when creating or editing an instance.

If you enabled this check, {{ ig-name }} will poll the application status on the instance at preset intervals while the instance group is in the `ACTIVE` [status](statuses.md).

#### Recommendations for instance groups with a load balancer {#healthcheck-and-balancer}

If your instance group is integrated with {{ network-load-balancer-name }} or {{ alb-name }}, use less strict settings for checks in {{ ig-name }} than those for the load balancer health checks (to learn more about health checks, see the [{{ network-load-balancer-name }}](../../../network-load-balancer/concepts/health-check.md) or [{{ alb-name }}](../../../application-load-balancer/concepts/backend-group.md#health) documentation). The load balancer allocates the load on the app, while {{ ig-name }} only monitors the app performance.

> For example, if you set the 1-second response timeout in the load balancer, then set 30 seconds in {{ ig-name }}. If the application does not respond for 3 to 5 seconds, it might not be able to handle the current traffic. If it does not respond for more than 30 seconds, it is probably not working at all and you need to heal your instance.


#### Settings for application health checks {#settings}

You can set up health checks for an app running on an instance in the management console or describe it in the group's [YAML specification](specification.md) to provide it through the {{ yandex-cloud }} CLI or API.

{% note info %}

You can configure different health checks in the YAML specification, such as requests to different ports; an instance in the group will have to pass all checks to be considered healthy. The management console only allows you to set up a single health check.

{% endnote %}

You can specify the settings when [creating](../../operations/index.md#ig-create) or [updating](../../operations/index.md#ig-control) a group.

Below, you can find the descriptions of the fields with the settings from the YAML specification and their respective fields in the management console.

```yaml
health_checks_spec:
  health_check_specs:
    - interval: 2s
      timeout: 1s
      unhealthy_threshold: 2
      healthy_threshold: 2
      http_options:
        port: 8081
        path: "/_hz"
    - interval: 2s
      timeout: 1s
      unhealthy_threshold: 2
      healthy_threshold: 2
      tcp_options:
        port: 8080
  max_checking_health_duration: 25s
```

The fields and options in the management console are located under **{{ ui-key.yacloud.compute.groups.create.section_health-check }}** on the instance group creation and editing pages.

| YAML key<br/>Management console field or option | Description |
| --- | --- |
| `health_checks_spec`<br/>**{{ ui-key.yacloud.compute.groups.create.field_enable-health-check }}** | Settings for application health checks If the key is missing in the YAML specification or the option is disabled in the management console, no health checks are run. |
| `health_checks_specs` | List of health checks. If health checks are enabled, the list should contain at least one health check. You can set up multiple health checks in the YAML specification and only one health check in the management console. |
| `interval`<br/>**{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** | Interval between two consecutive health checks, from 1 to 300 seconds. The interval must be at least 1 second longer than the timeout. The default value is `2s`. |
| `timeout`<br/>**{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** | Check timeout, from 1 to 60 seconds: if the instance fails to respond to the health check during this time, it fails the health check. The default value is `1s`. |
| `unhealthy_threshold`<br/>**{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** | Number of consecutive failed health checks after which the instance is considered unhealthy and stopped automatically. Possible values: 0 and from 2 to 10. The default value is 2. The default value is 0. |
| `healthy_threshold`<br/>**{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** | Number of consecutive successful health checks after which the instance is considered healthy. Possible values: 0 and from 2 to 10. The default value is 2. The default value is 0. |
| `http_options`<br/>**{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `HTTP` | Settings for HTTP health checks Health checks are performed over HTTP or TCP. Therefore, the health check description in the YAML specification must contain only one key: either `http_options` or `tcp_options`. |
| `port`<br/>**{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** | Port in the range from 1 to 65535 to send health check requests over HTTP to. |
| `path`<br/>**{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** | Path to send health check requests over HTTP through. |
| `tcp_options`<br/>**{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}**: `TCP` | Settings for TCP health checks Health checks are performed over HTTP or TCP. Therefore, the health check description in the YAML specification must contain only one key: either `http_options` or `tcp_options`. |
| `port`<br/>**{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** | Port in the range from 1 to 65535 to send health check requests over TCP to. |
| `max_checking_health_duration`<br/>**{{ ui-key.yacloud.compute.groups.create.field_max-healthcheck-duration }}** | Time during which a new instance in the group (added to the group or restarted after being stopped) must pass health checks and get healthy. Possible values: 0 and 1+ sec. The default value is 0 (unlimited). |


## Auto-healing specifics {#healthcheck-cases}

### Auto-healing and deployment policies {#healthcheck-and-deploy}

To autoheal instances, {{ ig-name }} may restart them or create new ones. The healing method is defined by the [deployment policies](policies/deploy-policy.md).

* Creating new instances
  {{ ig-name }} will create new instances to replace those that failed the health check, provided that the deployment policy permits expanding the target size of the instance group. You can set the maximum number of instances that can be allocated to expand the target size of the group by using the `max_expansion` parameter, which may take values from `0` to `100`. In this case, {{ ig-name }} will first create a new instance, wait until it passes all checks, and then undeploy the instance that failed the check.

* Restarting the instance
  {{ ig-name }} will restart instances that failed the health check if the deployment policy permits reducing the target size of the instance group. You can use the `max_unavailable` parameter to set the maximum number of instances that can be made unavailable at the same time. The acceptable values range from `0` to `100`. {{ ig-name }} will try not to exceed this value during autohealing.

  This restriction does not apply to instances with the `CRASHED`, `ERROR`, and `STOPPED` [statuses](../vm-statuses.md), because, in these cases, the instance is already unavailable and must be restarted immediately.

If you set both `max_expansion` and `max_unavailable`, {{ ig-name }} will use both autohealing methods.

> For example, let's assume you set `max_expansion = 1` and `max_unavailable = 1`. When one instance fails the check, {{ ig-name }} will be restarting this instance and creating a new one at the same time. The instance that passes all checks successfully will continue running, while the other will be undeployed.

To limit the autohealing and deployment speed, you can also set:
* Maximum number of instances deployed simultaneously, using the `max_creating` parameter. This includes the instances being created and started with the `CREATING` and `STARTING` statuses.

  The acceptable values range from `0` to `100`. `0` means any number of instances within the allowed range.

* Maximum number of instances undeployed simultaneously, using the `max_deleting` parameter. This includes the instances being stopped with the `STOPPING` status, since {{ ig-name }} always stops instances before undeploying them.

  The acceptable values range from `0` to `100`. `0` means any number of instances within the allowed range.

### Changing instance status during autohealing {#healtcheck-and-vm-state}

{{ ig-name }} will not try to heal an instance if it is no longer needed.

> For example, if all 10 instances out of 10 in a group are unavailable and `max_unavailable = 3`, {{ ig-name }} will restart the first three instances. If the remaining seven instances become operable again in the meantime, {{ ig-name }} will not restart them.
>
> If `max_expansion = 3`, {{ ig-name }} will start creating three new instances. The old instances will not be deleted until the new ones are created. If all instances in an instance group become operable again during the creation process, {{ ig-name }} will cancel the creation of new instances.

### Healing while updating instance configurations {#healtcheck-and-vm-update}

Instance healing has a higher priority than instance configuration update.

> Let's assume you have a group of 100 instances with `max_unavailable = 1`. When you update the instance configuration in an instance group, {{ ig-name }} will restart the instances one by one, updating their configuration.
>
> If one of the instances fails the application health check at that point, {{ ig-name }} will put it first in the restart queue.

### Healing on instance group size change {#healthcheck-and-group-size}

When the target size of an instance group is reduced, the instances that failed the check, if any, will be deleted first.

If you increase the target size of the instance group, new instances will be created at the same time as the instances that failed the check, if this is allowed by `max_creating` and `max_expansion`:

> Let's assume two out of four instances in an instance group failed the [application health check](#functional-healthcheck). At that point, the target size of the instance group has increased to six instances. You have two instances to create and another two to heal.
>
> If `max_expansion = 1` and `max_creating` is not set, {{ ig-name }} will start creating three instances in parallel: two under the instance group expansion, and one under the autohealing process.

### Autohealing preemptible instances {#healthcheck-preemptible-vm}

[Preemptible instances](../preemptible-vm.md) can only be autohealed if the computing resources in the availability zone allow for this. If the resources are insufficient, {{ ig-name }} will resume autohealing as soon as the resources become available; this, however, may take a long time.

Preemptible VMs must be terminated within 24 hours of their launch. In this case, there is a risk that the entire instance group will restart at the same time and stop handling the load of running applications. To avoid this, {{ ig-name }} stops preemptible instances after a random interval of 22 to 24 hours, rather than exactly after 24 hours.

#### See also {#see-also}

* [{#T}](../../operations/instance-groups/enable-autohealing.md).