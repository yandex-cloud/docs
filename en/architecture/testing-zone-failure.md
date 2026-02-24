---
title: Fault tolerance testing in the {{ yandex-cloud }} infrastructure based on {{ network-load-balancer-full-name }}
description: Guide on single availability zone failure exercises in a {{ network-load-balancer-full-name }}-based cloud infrastructure.
keywords:
  - testing
  - availability zone fault
  - chaos engineering
  - fault tolerance
  - load testing
---

# Fault tolerance testing in the {{ yandex-cloud }} infrastructure based on {{ network-load-balancer-full-name }}

This guide covers the practical aspects of the fault tolerance testing routine outlined in [Recommendations on fault tolerance in {{ yandex-cloud }}](./fault-tolerance.md), for the {{ yandex-cloud }} infrastructure based on [{{ network-load-balancer-full-name }}](../network-load-balancer/concepts/index.md). It is assumed that the principles behind the subject infrastructure are aligned with the principles discussed in the article.

## Goals of testing {#goals}

{% include [testing-goals](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/testing-goals.md) %}

## Pre-test preparation {#preparation}

### Test environment {#environment}

{% include [testing-environment](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/testing-environment.md) %}

### Testing recommendations {#recommendations}

{% include [testing-requirements](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/testing-requirements.md) %}

### Testing tools {#tools}

This guide describes fault tolerance tests implemented using tools that disable load balancing in a particular [availability zone](../overview/concepts/geo-scope.md) for [{{ network-load-balancer-name }}](../network-load-balancer/operations/manage-zone/disable-enable-zone.md). 

{% include [testing-tools-vpc-sgs](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/testing-tools-vpc-sgs.md) %}

## Testing methodology {#method}

### Preparation steps {#test-prep}

1. {% include [test-prep1](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-prep1.md) %}
1. {% include [test-prep2](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-prep2.md) %}
1. {% include [test-prep3](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-prep3.md) %}
1. {% include [test-prep4](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-prep4.md) %}

    ```
    yc load-balancer nlb list
    ```

### Initiating the test {#test-run}

{% include [test-run-part1](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-run-part1.md) %}

```
yc load-balancer nlb disable-zones <load_balancer_name_or_ID> \
  --zones={{ region-id }}-b \
  --duration 30m
```

Approximate result of executing the command (pay attention to `disable_zone_statuses`):

```
id: enpmq********
...
disable_zone_statuses:
  - zone_id: {{ region-id }}-b
    disabled_until: "2025-07-17T15:30:18.176751322Z"
```

{% include [test-run-part2](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-run-part2.md) %}

### State assessment {#test-check}

1. To get the resource blocking state info for an individual load balancer, run the following command:

   ```
   yc load-balancer nlb get <load_balancer_name_or_ID>
   ```

   Approximate result of executing the command:

   ```
    id: enpmq********
    folder_id: b1g********
    created_at: "2025-07-17T13:42:24Z"
    name: ...
    region_id: {{ region-id }}
    status: ACTIVE
    type: EXTERNAL
    listeners:
      - name: ...
        ...
    attached_target_groups:
      - target_group_id: enpn********
        health_checks:
          - name: ...
            ...
    disable_zone_statuses:
      - zone_id: {{ region-id }}-b
        disabled_until: "2025-07-17T15:30:18.176751322Z"
   ```
1. {% include [test-check](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-check.md) %}
 
### Completing the test {#test-fin}

1. {% include [test-fin-part1](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-fin-part1.md) %}

   ```
   yc load-balancer nlb enable-zones <load_balancer_name_or_ID> \
     --zones={{ region-id }}-b
   ```
1. {% include [test-fin-part2](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/test-fin-part2.md) %}

## Conclusion {#conclusion}

{% include [conclusion](../_tutorials/_tutorials_includes/testing-zone-failure-for-alb/conclusion.md) %}