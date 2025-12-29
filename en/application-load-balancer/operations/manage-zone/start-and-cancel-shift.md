---
title: How to enable and disable an availability zone and initiate zonal shift on an L7 {{ alb-full-name }}
description: Follow this guide to disable/enable availability zones and test traffic redistribution on the L7 load balancer.
---

# Enabling and disabling an availability zone

{% include [about-zonal-shift](../../../_includes/application-load-balancer/about-zonal-shift.md) %}

## Disabling an availability zone {#disable-zones}

{% include [disable-zone-ig-nlb-alb](../../../_includes/instance-groups/disable-zone-ig-nlb-alb.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the command description:

      ```bash
      yc application-load-balancer load-balancer disable-zones --help
      ```

  1. To start redistributing traffic, disable the availability zone and specify the deactivation time:

      ```bash
      yc application-load-balancer load-balancer disable-zones \
        <load_balancer_name_or_ID> \
        --zones <availability_zones>
        --duration <deactivation_time>
      ```

      Where:

      * `<load_balancer_name_or_ID>`: Load balancer ID or name.
      * `--zones`: Availability zones to disable, separated by commas.
      * `--duration`: Time from `1m` to `72h` when the zone will be disabled.
      
         After the specified time elapses, the zone will automatically return to its initial state (enabled) for the CLI and API. These settings will be applied without your intervention.
         
         If this parameter is not specified, the zone will remain disabled until you [enable](#enable-zones) it manually.
  
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

  To disable an availability zone, use the [DisableZones](../../api-ref/LoadBalancer/disableZones.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/DisableZones](../../api-ref/grpc/LoadBalancer/disableZones.md) gRPC API call.

{% endlist %}

## Viewing the availability zone activation time {#view-zone-status}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) with your load balancer.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}** and then select the load balancer you need.
  1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, next to the availability zone, view its status.

      If you set the deactivation duration, you will see the end time next to the zone.

{% endlist %}

## Enabling an availability zone {#enable-zones}

{% include [enable-zone-ig-nlb-alb](../../../_includes/instance-groups/enable-zone-ig-nlb-alb.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the command to enable an availability zone:

      ```bash
      yc application-load-balancer load-balancer enable-zones --help
      ```

  1. Enable an availability zone:

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

  To enable an availability zone, use the [EnableZones](../../api-ref/LoadBalancer/enableZones.md) REST API method for the [LoadBalancer](../../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/EnableZones](../../api-ref/grpc/LoadBalancer/enableZones.md) gRPC API call.

{% endlist %}

{% note info %}

Previously, the `start-zonal-shift` and `cancel-zonal-shift` CLI commands and the `StartZonalShift` and `CancelZonalShift` API methods were used to enable and disable availability zones. They are now deprecated and will soon be removed.

{% endnote %}

### See also {#see-also}

* [Disabling and enabling availability zones for a {{ compute-full-name }} instance group](../../../compute/operations/instance-groups/disable-enable-zone.md)
* [Disabling and enabling availability zones in {{ network-load-balancer-full-name }}](../../../network-load-balancer/operations/manage-zone/disable-enable-zone.md)