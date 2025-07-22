---
title: Fault tolerance testing in {{ yandex-cloud }}
description: Cloud zone failure exercise guide
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

This guide describes a cloud zone failure exercise methodology allowing you to:

* Study the system's failure behavior.
* Evaluate the system's capacity to remain operational if one availability zone is lost.
* Identify hidden dependencies and vulnerabilities.
* Collect information on failure symptoms.
* Check the system's ability to recover quickly.

The failure research is limited to the case of complete availability zone failure. Partial failures fall outside the scope of this article due to their diversity.

## Pre-test preparation {#preparation}

### Test environment {#test-environment}

1. Alignment with production environment:
   
   {% note warning %}
       
     We do not recommend testing directly in the production environment – do a test environment exercise first.

   {% endnote %}
   
   * The test environment should be as close as possible to the production environment.
   * The test load should simulate the production load. Use load testing tools to simulate the production load, e.g., [Yandex Load Testing](/services/load-testing).
   * We recommend using [Infrastructure as Code](https://yandex.cloud/ru/blog/cloud-control-tools#iac) to automate the creation of test environments.

1. For test environment cost optimization, we recommend the following:
   * Use NRD disks instead of SSD-IO.
   * Use preemptible VMs.
   * Create your environments dynamically only for the duration of the test.
   * Free up resources automatically after the tests are over.
   * Use components without SLA to reduce costs.

### Requirements for tests {#requirements}

1. Use a monitoring system for assessment of test results. 
1. Save your test results for retrospective analysis.
1. Perform testing on a regular basis.
1. [Yandex Cloud CLI](https://yandex.cloud/ru/docs/cli/quickstart) 0.154.0 or higher.

### Testing tools {#testing-tools}

This document addresses testing with the help of availability zone load balancing deactivation tools for [{{ network-load-balancer-name }}](https://yandex.cloud/ru/docs/network-load-balancer/operations/manage-zone/disable-enable-zone) and [{{ alb-name }}](https://yandex.cloud/ru/docs/application-load-balancer/operations/manage-zone/start-and-cancel-shift). 

We recommend using [VPC security groups](https://yandex.cloud/ru/docs/vpc/concepts/security-groups) as an additional isolation tool for the disabled zone.
**Important note**: When using [VPC security groups](https://yandex.cloud/ru/docs/vpc/concepts/security-groups), consider the following:
- Only allowing rules are supported in security groups, so to block traffic you need a separate set of rules allowing traffic between zones, which will be deleted when you initiate blocking. 
- By deleting the allowing rules from a security group you block new network connections without terminating already established ones.

## Testing methodology {#methodology}

### Preparing {#test-prep}

1. Prepare the environment for testing if needed. 
1. Select the availability zone to shift traffic away from, e.g., `ru-central1-b`.
1. Determine the test duration. You can disable a load balancer zone either permanently or for a specified period, from 1 minute to 72 hours, e.g., 30 minutes.
1. Get the list of load balancers that will participate in the testing:

   ```
   yc load-balancer nlb list
   ```

### Initiating the test {#test-run} 

1. Disable delivery of traffic to the selected availability zone for each selected load balancer. Use the disable-zones command to disable traffic balancing to the selected zone.

   ```
   yc load-balancer nlb enpmq******** disable-zones --zone-ids=ru-central1-b --duration 30m
   ```

   Response example (note the `disable_zone_statuses` section):

   ```
   id: enpmq********
   ...
   disable_zone_statuses:
       - zone_id: ru-central1-b
       disabled_until: "2025-06-07T04:10:02.679608678Z"
   ```

   This command supports disabling several zones in one go.

   When the command is re-executed, the blocking period will again be reset to 30 minutes from the current time.

   If you do not specify the `--duration` parameter, traffic balancing to the availability zone will be blocked indefinitely.

   {% note warning %}

    The `disable-zones` command disables only traffic balancing to the selected zone and only for the specified load balancer. This command does not impact network traffic within the zone or between the availability zones. If you need to block such traffic, use [VPC security groups](https://yandex.cloud/ru/docs/vpc/concepts/security-groups).

   {% endnote %}

### Traffic monitoring {#test-check}

1. Get the blocking status information:

   ```
   yc load-balancer nlb get enpmq********
   ```

   Response example:

   ```
   allow_zonal_shift: true
   zonal_shift_resource_type: PRIVATE
   disable_zone_statuses:   
     - zone_id: ru-central1-b     
     disabled_until: "2025-06-07T04:10:02.679608678Z"
   ```

1. Check that traffic has stopped entering the selected zone. You can do this in the [monitoring](../monitoring/) service by plotting total traffic on your virtual machines' interfaces grouped by availability zone. 

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

1. Execute the `enable-zones` command to re-enable traffic balancing to the selected zone:

   ```
   yc load-balancer nlb enpmq******** enable-zones --zone-ids=ru-central1-b
   ```

1. Check that data has started entering the selected zone.

   > Remember that there is time limit for re-disabling balancing after it is re-enabled. You can disable balancing again after it was re-enabled not earlier than after 2 minutes. 

### {{ alb-name }} {#alb}

The syntax and semantics of balancing disable/enable commands for {{ alb-name }} are the same as in {{ network-load-balancer-name }} commands. 

## Conclusion {#conclusion}

We recommend you to perform fault tolerance testing on a regular basis, document the results, and continuously improve your processes based on the experience you gain.