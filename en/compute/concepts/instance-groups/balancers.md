# Integrating an instance group with {{ network-load-balancer-name }} or {{ alb-name }}

Using [{{ network-load-balancer-full-name }}](/services/network-load-balancer) and [{{ alb-full-name }}](/services/application-load-balancer), you can evenly distribute the workload across {{ compute-full-name }} VM instances. An [instance group](index.md) can be integrated with these services: {{ compute-name }} will automatically create a {{ network-load-balancer-name }} or {{ alb-name }} target group from this instance group and perform monitoring so that unhealthy instances are not added to the group.


## How integration works {#principles}

### Creating a target group {#principles-creation}

In {{ yandex-cloud }} load balancing services, a _target group_ is a set of resources where your network applications are running. The load balancer the target group is linked to distributes incoming requests across its resources. To learn more about target groups, see the [{{ network-load-balancer-name }}](../../../network-load-balancer/concepts/target-resources.md) and [{{ alb-name }}](../../../application-load-balancer/concepts/target-group.md) documentation.

Target groups usually include {{ compute-name }} VM instances. This allows you to set up an instance group so that a {{ network-load-balancer-name }} or {{ alb-name }} target group could be created automatically from it. The target group created this way will be associated with the instance group:

* When an instance is added to the instance group or restarted after being stopped, it is added to the target group.
* When an instance is stopped or removed from the instance group, it is removed from the target group.

To make sure the target group starts receiving traffic, link it to a load balancer. {{ compute-name }} does not do that automatically.

* The {{ network-load-balancer-name }} target group should be [linked to the load balancer](../../../network-load-balancer/operations/target-group-attach.md) directly.
* The {{ alb-name }} target group should be linked to a [backend group](../../../application-load-balancer/concepts/backend-group.md) and the backend group, to the load balancer, either directly or via an [HTTP router](../../../application-load-balancer/concepts/http-router.md), depending on the load balancing type. For more information, see our [guides for managing {{ alb-name }} resources](../../../application-load-balancer/operations/index.md).


### Health checks from load balancers {#principles-health-checks}

Once a target group is linked to a load balancer, it sends _health checks_ to the group instances to find out which of them are healthy and which are not when distributing traffic. To learn more about health checks, see the [{{ network-load-balancer-name }}](../../../network-load-balancer/concepts/health-check.md) and [{{ alb-name }}](../../../application-load-balancer/concepts/backend-group.md#health-checks) documentation.

An instance added to the instance group or restarted after being stopped gets into the target group and is assigned the [`OPENING_TRAFFIC` status in the instance group](statuses.md#vm-statuses), and the load balancer starts sending health checks to it. If the instance passes the required number of health checks (the healthy threshold set in the health check settings), the load balancer considers it healthy and the instance starts receiving traffic from the load balancer and switches to the `RUNNING_ACTUAL` status.

By default, the instance may be in the `OPENING_TRAFFIC` status for an unlimited time until it gets healthy. You can limit this time in the [integration settings](#settings) (the `max_opening_traffic_duration` field). In this case, {{ compute-name }} will automatically recover the instance that is not receiving any traffic for too long since it has been added to the group or started. For more information about instance recovery, see [{#T}](autohealing.md#healthcheck-cases).


## Settings {#settings} 

You can integrate an instance group with {{ network-load-balancer-name }} or {{ alb-name }} in the management console or describe the integration in the group's [YAML specification](specification.md) to provide the specification through the {{ yandex-cloud }} CLI or API. You can specify the settings when [creating](../../operations/index.md#ig-create) or [updating](../../operations/index.md#ig-control) a group.

An instance group can only be integrated with one of the services: either {{ network-load-balancer-name }} or {{ alb-name }}. You cannot set up integration of an instance group with both services at the same time.

Below, you can find the descriptions of the fields with the settings from the YAML specification and their respective fields in the management console.

### Settings for integration with {{ network-load-balancer-name }} {#settings-nlb}

```yaml
load_balancer_spec:
  target_group_spec:
    name: "ig-tg"
    description: "Instance group as target group"
    labels:
      foo: "baz"
      bar: "baz"
  max_opening_traffic_duration: 30s
```

The fields and options in the management console are located under **{{ ui-key.yacloud.compute.groups.create.section_ylb }}** on the instance group creation and editing pages.

| YAML key<br/>Management console field or option | Description |
| --- | --- |
| `load_balancer_spec`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** | Settings for instance group integration with {{ network-load-balancer-name }}. If the key is missing in the YAML specification or the option is disabled in the management console, the group will not be integrated with {{ network-load-balancer-name }}. |
| `target_group_spec` | Parameters of a [{{ network-load-balancer-name }} target group](../../../network-load-balancer/concepts/target-resources.md) being created from the instance group. |
| `name`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-name }}** | Name of the target group. |
| `description`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-description }}** | Description of the target group. |
| `labels` | Target group [labels](../../../resource-manager/concepts/labels.md) in `<label_name>: <label_value>` format. |
| `max_opening_traffic_duration`<br/>**{{ ui-key.yacloud.compute.groups.create.field_nlb-pre-checks-timeout }}** | Time during which a new instance in the group must pass the health check from the load balancer. Possible values: 0 and 1+ sec. The default value is 0 (unlimited). For more information, see [{#T}](#principles-health-checks). |

### Settings for integration with {{ alb-name }} {#settings-alb}

```yaml
application_load_balancer_spec:
  target_group_spec:
    name: "ig-tg"
    description: "Instance group as target group"
    labels:
      foo: "baz"
      bar: "baz"
  max_opening_traffic_duration: 30s
```

The fields and options in the management console are located under **{{ ui-key.yacloud.compute.groups.create.section_alb }}** on the instance group creation and editing pages.

| YAML key<br/>Management console field or option | Description |
| --- | --- |
| `application_load_balancer_spec`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** | Settings for instance group integration with {{ alb-name }}. If the key is missing in the YAML specification or the option is disabled in the management console, the group will not be integrated with {{ alb-name }}. |
| `target_group_spec` | Parameters of a [{{ alb-name }} target group](../../../application-load-balancer/concepts/target-group.md) being created from the instance group. |
| `name`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-name }}** | Name of the target group. |
| `description`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-description }}** | Description of the target group. |
| `labels` | Target group [labels](../../../resource-manager/concepts/labels.md) in `<label_name>: <label_value>` format. |
| `max_opening_traffic_duration`<br/>**{{ ui-key.yacloud.compute.groups.create.field_alb-pre-checks-timeout }}** | Time during which a new instance in the group must pass the health check from the load balancer. Possible values: 0 and 1+ sec. The default value is 0 (unlimited). For more information, see [{#T}](#principles-health-checks). |