---
title: Fault tolerance testing in {{ yandex-cloud }}
description: Exercise guide for cases when a cloud availability zone fails
keywords:
  - testing
  - availability zone fault
  - chaos engineering
  - fault tolerance
  - load testing
---

# Guide for fault tolerance testing in {{ yandex-cloud }}

This guide describes the practical component of the fault tolerance testing recommendations presented in [Recommendations on fault tolerance in {{ yandex-cloud }}](./fault-tolerance.md). It is assumed that the principles behind the subject infrastructure are aligned with the principles discussed in the article.

## Goals of testing {#goals}

This guide describes a cloud [availability zone](../overview/concepts/geo-scope.md) failure exercise methodology allowing you to:

* Study the system's behavior during failure.
* Evaluate the system’s fault tolerance when one of the [availability zones](../overview/concepts/geo-scope.md) fails.
* Identify hidden dependencies and vulnerabilities.
* Collect information on the symptoms of outage.
* Check the system's ability to recover quickly.

The failure research is limited to the case of a `complete failure` of an [availability zone](../overview/concepts/geo-scope.md). Partial failures fall outside the scope of this guide due to their diversity.

## Pre-test preparation {#preparation}

### Test environment {#environment}

1. Alignment with production environment:
   
   {% note warning %}
       
     We do not recommend using your production environment for testing; do a test environment exercise first.

   {% endnote %}
   
   * Your test environment should be closely similar to the production environment in terms of configuration.
   * The test load should simulate the production load. Use load testing tools to simulate the production load, e.g., [Yandex Load Testing](../load-testing/concepts/index.md).
   * We recommend using [Infrastructure as Code](https://yandex.cloud/ru/blog/cloud-control-tools#iac) to automate the setup of test environments.

1. Follow these best practices to optimize costs when deploying resources in the test environment:
   * Use NRD disks instead of [SSD-IO](../compute/concepts/disk.md#disks-types).
   * Use [preemptible VMs](../compute/concepts/preemptible-vm.md).
   * Create your resources dynamically only for the duration of the test.
   * Free up resources automatically after the tests are over.
   * Use components without SLA to reduce costs.

### Requirements for tests {#requirements}

1. Use a monitoring system for assessment of test results. 
1. Save your test results for retrospective analysis.
1. Perform testing on a regular basis.
1. Use [Yandex Cloud CLI](../cli/quickstart.md) `0.154.0` or higher for testing.

### Testing tools {#tools}

This document addresses fault tolerance testing with the help of a separate [availability zone](../overview/concepts/geo-scope.md) load balancing deactivation tools for [{{ network-load-balancer-name }}](../network-load-balancer/operations/manage-zone/disable-enable-zone.md) and [{{ alb-name }}](../application-load-balancer/operations/manage-zone/start-and-cancel-shift.md). 

We recommend using [VPC security groups](../vpc/concepts/security-groups.md) as an additional isolation tool for the disabled zone.
**Important note**: When using [VPC security groups](../vpc/concepts/security-groups.md), consider the following specifics:
- Only allowing rules are supported in security groups, so to block traffic you need a separate set of rules allowing traffic between zones, which you will need to delete when you initiate blocking.
- By deleting the allowing rules from a security group you block new network connections without terminating already established ones.

## Testing methodology {#method}

### Preparation steps {#test-prep}

1. Prepare the environment for testing if needed. 
1. Select the availability zone to disable, i.e., to shift traffic away from, e.g., `ru-central1-b`.
1. Determine the test duration. You can disable a load balancer zone either permanently or for a specified period, from 1 minute to 72 hours, e.g., 30 minutes.
1. Get the list of load balancers that will participate in the testing:

   ```
   yc load-balancer nlb list
   ```

### Initiating the test {#test-run}

1. Disable delivery of traffic to the selected [availability zone](../overview/concepts/geo-scope.md) for each load balancer from the list. Use the `disable-zones` command to disable traffic balancing to the selected zone. To disable balancing of traffic from a separate [NLB](../network-load-balancer/concepts/index.md) in the `ru-central1-b` availability zone for `30 minutes`, run the following command:

   ```
   yc load-balancer nlb disable-zones enpmq******** --zones=ru-central1-b --duration 30m
   ```

   The command result should be as follows (note the `disable_zone_statuses` section):

   ```
    id: enpmq********
    ...
    disable_zone_statuses:
      - zone_id: ru-central1-b
        disabled_until: "2025-07-17T15:30:18.176751322Z"
   ```

   You can use this command to disable several availability zones at once if you list them separated by commas.

   If you run the command again, the blocking period will be reset to 30 minutes from the current time.

   If you do not specify the `--duration` parameter in the command, traffic balancing to the selected zones will be blocked indefinitely.

   {% note warning %}

    The `disable-zones` command only disables traffic balancing to the selected availability zone and only for the specified load balancer. This command does not impact network traffic within the zone or between the availability zones in any other cloud services. If you need to block traffic on such a broad scale, you can use [VPC security groups](../vpc/concepts/security-groups) on the corresponding cloud resource network interfaces.

   {% endnote %}

### State assessment {#test-check}

1. To get information about the blocking state of resources behind a specific NLB, run this command:

   ```
   yc load-balancer nlb get enpmq********
   ```

   The command result should be as follows:

   ```
    id: enpmq********
    folder_id: b1g********
    created_at: "2025-07-17T13:42:24Z"
    name: ...
    region_id: ru-central1
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
      - zone_id: ru-central1-b
        disabled_until: "2025-07-17T15:30:18.176751322Z"
   ```

1. Check that traffic has stopped entering the selected zone. You can do this in the [monitoring](../monitoring/index.yaml) service by plotting total traffic on your virtual machines' interfaces grouped by availability zone. 

   > Currently, you cannot have zone-by-zone traffic distribution plotted through one simple request to the monitoring service. To get this done:
   > 1. Create a chart in the monitoring service.
   > 1. Create lists of VM IDs for zone `ru-central1-a`, e.g., using this command:
   >    ```
   >    yc compute instance list --jq '[.[] | select(.zone_id=="ru-central1-a") | .id ] | join("|")'`
   >    ```
   >    The command output will be a single-line list of VM IDs separated by `|`. For example: `fhm**********uv5|fhm**********aab|fhm**********ui1|...`. 
   > 1. Add a query to the monitoring chart: 
   >    ```
   >    alias(series_sum("network_received_packets"{folderId = "b1g**********", service = "compute", resource_type = "vm", resource_id = "<List of VM IDs you got in the previous step separated by |>"}), "ru-central1-a")`
   >    ```
   > 1. Repeat steps 2 and 3 for zones `ru-central1-b` and `ru-central1-d`.
   > 1. Run the queries.
 
### Completing the test {#test-fin}

1. Run the `enable-zones` command to resume traffic balancing in the previously disabled availability zone:

   ```
   yc load-balancer nlb enable-zones enpmq******** --zones=ru-central1-b
   ```

1. Check that traffic has started flowing to the selected zone.

   > Remember that there is time limit for re-disabling balancing after it is re-enabled. You have to wait for 2 minutes before you can disable balancing after it was re-enabled.

### {{ alb-name }} {#alb}

The syntax and semantics of balancing disable/enable commands for the selected availability zone in [{{ alb-name }}](../application-load-balancer/index.yaml) are the same as in [{{ network-load-balancer-name }}](../network-load-balancer/index.yaml). 

## Conclusion {#conclusion}

We recommend you to perform fault tolerance testing on a regular basis, document the results, and continuously improve your processes based on the experience you gain.

