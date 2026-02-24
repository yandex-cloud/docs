# Fault tolerance testing in the {{ yandex-cloud }} infrastructure based on {{ alb-full-name }}

This guide covers the practical aspects of the fault tolerance testing routine outlined in [Recommendations on fault tolerance in {{ yandex-cloud }}](../../architecture/fault-tolerance.md), for the {{ yandex-cloud }} infrastructure based on L7 [{{ alb-name }}](../../application-load-balancer/concepts/application-load-balancer.md). It is assumed that the principles behind the subject infrastructure are aligned with the principles discussed in the article.

## Goals of testing {#goals}

{% include [testing-goals](../_tutorials_includes/testing-zone-failure-for-alb/testing-goals.md) %}

## Pre-test preparation {#preparation}

### Test environment {#environment}

{% include [testing-environment](../_tutorials_includes/testing-zone-failure-for-alb/testing-environment.md) %}

### Testing recommendations {#recommendations}

{% include [testing-requirements](../_tutorials_includes/testing-zone-failure-for-alb/testing-requirements.md) %}

### Testing tools {#tools}

This guide describes fault tolerance tests implemented using tools that disable load balancing in a particular [availability zone](../../overview/concepts/geo-scope.md) for [{{ alb-name }}](../../application-load-balancer/operations/manage-zone/start-and-cancel-shift.md).

{% include [testing-tools-vpc-sgs](../_tutorials_includes/testing-zone-failure-for-alb/testing-tools-vpc-sgs.md) %}

## Testing methodology {#method}

### Preparation steps {#test-prep}

1. {% include [test-prep1](../_tutorials_includes/testing-zone-failure-for-alb/test-prep1.md) %}
1. {% include [test-prep2](../_tutorials_includes/testing-zone-failure-for-alb/test-prep2.md) %}
1. {% include [test-prep3](../_tutorials_includes/testing-zone-failure-for-alb/test-prep3.md) %}
1. {% include [test-prep4](../_tutorials_includes/testing-zone-failure-for-alb/test-prep4.md) %}

    ```
    yc alb load-balancer list
    ```

### Initiating the test {#test-run}

{% include [test-run-part1](../_tutorials_includes/testing-zone-failure-for-alb/test-run-part1.md) %}

```
yc alb load-balancer disable-zones <load_balancer_name_or_ID> \
  --zones={{ region-id }}-b \
  --duration 30m
```

Approximate result of executing the command (pay attention to `allocation_policy.locations`):

```
...
allocation_policy:
  locations:
    - zone_id: {{ region-id }}-a
      subnet_id: e9bnvnn56fs4********
    - zone_id: {{ region-id }}-b
      subnet_id: e2lqsms4cdl3********
      zonal_shift_active: true
      zonal_traffic_disabled: true
    - zone_id: {{ region-id }}-d
      subnet_id: fl8dmq91iruu********
...
```

{% include [test-run-part2](../_tutorials_includes/testing-zone-failure-for-alb/test-run-part2.md) %}

### State assessment {#test-check}

1. To get the resource blocking state info for an individual load balancer:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with your load balancer.
      1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}** and select the load balancer.
      1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, next to the availability zone, view its status.

          If the zonal shift duration has been set, you will see the end time next to the zone.

    {% endlist %}

1. {% include [test-check](../_tutorials_includes/testing-zone-failure-for-alb/test-check.md) %}

### Completing the test {#test-fin}

1. {% include [test-fin-part1](../_tutorials_includes/testing-zone-failure-for-alb/test-fin-part1.md) %}

   ```
   yc alb load-balancer enable-zones <load_balancer_name_or_ID> \
     --zones={{ region-id }}-b
   ```
1. {% include [test-fin-part2](../_tutorials_includes/testing-zone-failure-for-alb/test-fin-part2.md) %}

## Conclusion {#conclusion}

{% include [conclusion](../_tutorials_includes/testing-zone-failure-for-alb/conclusion.md) %}