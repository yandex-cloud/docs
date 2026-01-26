---
title: How to enable and disable a zonal shift and start shifting traffic to other zones on an L7 {{ alb-full-name }}
description: Follow this guide to disable/enable a zonal shift and test traffic redistribution on an L7 load balancer.
---

# Enabling and disabling a zonal shift

{% include [about-zonal-shift](../../../_includes/application-load-balancer/about-zonal-shift.md) %}

## Enabling a zonal shift {#disable-zones}

{% include [disable-zone-ig-nlb-alb](../../../_includes/instance-groups/disable-zone-ig-nlb-alb.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder containing your [L7 load balancer](../../concepts/application-load-balancer.md).
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Select your L7 load balancer.
  1. On the **{{ ui-key.yacloud.common.overview }}** page, under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, click **{{ ui-key.yacloud.alb.section_allocation-settings_button }}**.
  1. Enable a zonal shift for one or more zones.
  1. Optionally, to set auto-off time for the zonal shift, activate **{{ ui-key.yacloud.components.BalancerAllocationDialog.AllocationForm.form_timezone_0_6LoEf }}** and specify a value from `1m` to `72h`. If no time is set, the zonal shift will be on until you disable it manually.

  1. Click **{{ ui-key.yacloud.common.save }}**.

    Your load balancer will start shifting traffic away from inactive availability zones to other zones.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the command description:

      ```bash
      yc application-load-balancer load-balancer disable-zones --help
      ```

  1. To start redistributing traffic, enable a zonal shift and specify its duration:

      ```bash
      yc application-load-balancer load-balancer disable-zones \
        <load_balancer_name_or_ID> \
        --zones <availability_zones>
        --duration <zonal_shift_duration>
      ```

      Where:

      * `<load_balancer_name_or_ID>`: Load balancer ID or name.
      * `--zones`: Availability zones to shift traffic away from, separated by commas.
      * `--duration`: Zonal shift duration from `1m` to `72h`.
      
         After this time, the zone will automatically recover. If this parameter is not set, the zonal shift will be on until you [disable](#enable-zones) it manually.
  
      Here is an example:

      ```bash
      yc application-load-balancer load-balancer disable-zones \
        my-balancer \
        --zones {{ region-id }}-a \
        --duration 1h
      ```

      Result:

      ```text
      id: ds70q425egoe********
      name: my-balancer
      ...
      allocation_policy:
        locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e2lptlobccu6********
            zonal_shift_active: true
            zonal_traffic_disabled: true
          - zone_id: {{ region-id }}-b
            subnet_id: e9bo5ir5prfi********
      ...
      ```

- API {#api}

  To enable a zonal shift, use the [DisableZones](../../api-ref/LoadBalancer/disableZones.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/DisableZones](../../api-ref/grpc/LoadBalancer/disableZones.md) gRPC API call.

{% endlist %}

## Viewing zonal shift off time {#view-zone-status}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) with your load balancer.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}** and select the load balancer.
  1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, next to the availability zone, view its status.

      If the zonal shift duration has been set, you will see the end time next to the zone.

{% endlist %}

## Disabling a zonal shift {#enable-zones}

{% include [enable-zone-ig-nlb-alb](../../../_includes/instance-groups/enable-zone-ig-nlb-alb.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder containing your [L7 load balancer](../../concepts/application-load-balancer.md).
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Select your L7 load balancer.
  1. On the **{{ ui-key.yacloud.common.overview }}** page, under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, click **{{ ui-key.yacloud.alb.section_allocation-settings_button }}**.
  1. Disable the zonal shift.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the command for disabling a zonal shift:

      ```bash
      yc application-load-balancer load-balancer enable-zones --help
      ```

  1. Disable a zonal shift:

      ```bash
      yc application-load-balancer load-balancer enable-zones \
        <load_balancer_name_or_ID> \
        --zones <availability_zones>
      ```

      Here is an example:

      ```bash
      yc application-load-balancer load-balancer enable-zones \
        my-balancer \
        --zones {{ region-id }}-a
      ```
      
      Result:

      ```text
      id: ds70q425egoe********
      name: my-balancer
      ...
      allocation_policy:
        locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e9bo5ir5prfi********
          - zone_id: {{ region-id }}-b
            subnet_id: e2lptlobccu6******** 
      ...
      ```

- API {#api}

  To disable a zonal shift, use the [EnableZones](../../api-ref/LoadBalancer/enableZones.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/EnableZones](../../api-ref/grpc/LoadBalancer/enableZones.md) gRPC API call.

{% endlist %}

{% note info %}

Previously, the `start-zonal-shift` and `cancel-zonal-shift` CLI commands and the `StartZonalShift` and `CancelZonalShift` API methods were used to enable and disable zonal shifts. They are now deprecated and will soon be removed.

{% endnote %}

### See also {#see-also}

* [Disabling and enabling zonal shifts for a {{ compute-full-name }} instance group](../../../compute/operations/instance-groups/disable-enable-zone.md)
* [Disabling and enabling zonal shifts in {{ network-load-balancer-full-name }}](../../../network-load-balancer/operations/manage-zone/disable-enable-zone.md)