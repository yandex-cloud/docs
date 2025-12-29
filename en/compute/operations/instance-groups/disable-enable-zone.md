---
title: How to disable or enable an availability zone for a {{ compute-full-name }} instance group
description: Follow this guide to disable or enable availability zones for an instance group.
---

# Disabling and enabling availability zones for a {{ compute-full-name }} instance group

{% include [disable-enable-zone-intro](../../../_includes/instance-groups/disable-enable-zone-intro.md) %}

For more information on instance group behavior when an availability zone is disabled, see [this page](../../concepts/instance-groups/disable-enable-zone.md).

## Disabling an availability zone {#disable}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the command to disable an availability zone:

      ```bash
      yc compute instance-group disable-zones --help
      ```

  1. Get a list of all instance groups in the default folder:

      ```bash
      yc compute instance-group list
      ```

      Result:

      ```text
      +----------------------+----------------------+--------+------+
      |          ID          |         NAME         | STATUS | SIZE |
      +----------------------+----------------------+--------+------+
      | amc65sbgfqeq******** | test-group           | ACTIVE |    3 |
      | cl1cvs4firjj******** | catsf2nfq0mh******** | ACTIVE |    1 |
      +----------------------+----------------------+--------+------+
      ```

  1. Disable one or more availability zones for the group:

      ```bash
      yc compute instance-group disable-zones \
        --id <instance_group_ID> \
        --zones=<zone_1_ID>,[<zone_2_ID>] \
        --duration=<duration> 
      ```

      Where:
      * `--id`: Instance group ID.
      * `--zones`: Availability zone IDs, e.g., `{{ region-id }}-a`.
      * `--duration`: Duration, from `1m` to `72h`. No value stands for unlimited duration. If zones are provided as a list, they all will be disabled for the specified period.

{% endlist %}

## Enabling an availability zone {#enable}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the command to enable an availability zone:

      ```bash
      yc compute instance-group enable-zones --help
      ```

  1. Get a list of all instance groups in the default folder:

      ```bash
      yc compute instance-group list
      ```

      Result:

      ```text
      +----------------------+----------------------+--------+------+
      |          ID          |         NAME         | STATUS | SIZE |
      +----------------------+----------------------+--------+------+
      | amc65sbgfqeq******** | test-group           | ACTIVE |    3 |
      | cl1cvs4firjj******** | catsf2nfq0mh******** | ACTIVE |    1 |
      +----------------------+----------------------+--------+------+
      ```

  1. Enable one or more availability zones for the group:

      ```bash
      yc compute instance-group enable-zones \
        --id <instance_group_ID> \
        --zones=<zone_1_ID>,[<zone_2_ID>]
      ```

      Where:
      * `--id`: Instance group ID.
      * `--zones`: Availability zone IDs, e.g., `{{ region-id }}-a`.

{% endlist %}

## Viewing the availability zone status and time before activation {#check}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Run the command below and specify the instance group ID:

  ```bash
  yc compute instance-group get \
    --id <instance_group_ID>
  ```

  Result:

  ```text
  id: amc65sbgfqeq********
  ...
  disable_zone_statuses:
    - zone_id: {{ region-id }}-a
    - zone_id: {{ region-id }}-b
      disabled_until: "2025-06-06T04:10:02.679608678Z"
  ```

  Where `disabled_until` indicates the availability zone auto-activation time.

{% endlist %}

### See also {#see-also}

* [{#T}](../../concepts/instance-groups/disable-enable-zone.md)
* [Disabling and enabling availability zones in {{ network-load-balancer-full-name }}](../../../network-load-balancer/operations/manage-zone/disable-enable-zone.md)
* [Disabling and enabling availability zones in {{ alb-full-name }}](../../../application-load-balancer/operations/manage-zone/start-and-cancel-shift.md)
* [{#T}](../../concepts/instance-groups/zonal-inc/overview.md)