---
title: How to disable/enable availability zones for a {{ network-load-balancer-full-name }}
description: Follow this guide to disable/enable availability zones for a network load balancer.
---


# Enabling and disabling availability zones

{% include [about-zone-disable](../../../_includes/network-load-balancer/about-zone-disable.md) %}

You can enable and disable availability zones one by one or as a comma-separated list.


## Disabling availability zones {#disable-zone}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the availability zone disable command for a network load balancer:

        ```bash
        yc load-balancer network-load-balancer disable-zones --help
        ```

  1. Get a list of all network load balancers in the default folder:

        ```bash
        yc load-balancer network-load-balancer list
        ```

        Result:

        ```text
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      |          ID          |     NAME    |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      | ds70q425egoe******** | my-balancer | ru-central1 | EXTERNAL |              1 | enpakget56sr********   | ACTIVE |
      |                      |             |             |          |                | enpakf7vhj2l********   |        |
      | fw7fh46bnsge******** | my-nlb2     | ru-central1 | EXTERNAL |              1 | sn5u68knmswe********   | ACTIVE |
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      ```

  1. Disable one or more availability zones using the following command:

      ```bash
      yc load-balancer network-load-balancer disable-zones \
        <load_balancer_name_or_ID> \
        --zones=<zone_1_ID>,[<zone_2_ID>] \
        --duration=<duration>
      ```

      Where:
      
      * `--zones`: Availability zone IDs.
      * `--duration`: Duration, from `1m` to `72h`. No value stands for unlimited duration. If zones are provided as a list, they all will be disabled for the specified period.

{% endlist %}

{% note info %}

You cannot run the zone disable command more often than once every two minutes.

{% endnote %}


### Examples {#examples}

#### Disabling two availability zones {#two-zones-off}

{% list tabs group=instructions %}

- CLI {#cli}

  To disable two zones for a load balancer, list them separated by commas:

  ```bash
  yc load-balancer network-load-balancer disable-zones ds70q425egoe******** \
    --zones=ru-central1-b,ru-central1-d
  ```

  Result:

  ```text
  id: ds70q425egoe********
  ...
  disable_zone_statuses:
    - zone_id: ru-central1-b
    - zone_id: ru-central1-d
  ```

{% endlist %}

#### Disabling an availability zone for 30 minutes {#zone-off-30min}

{% list tabs group=instructions %}

- CLI {#cli}

  To disable a single availability zone for 30 minutes, use the `--duration` parameter:

  ```bash
  yc load-balancer network-load-balancer disable-zones ds70q425egoe******** \
    --zones=ru-central1-b \
    --duration=30m
  ```

  Result:

  ```text
  id: ds70q425egoe********
  ...
  disable_zone_statuses:
    - zone_id: ru-central1-b
      disabled_until: "2025-06-06T04:10:02.679608678Z"
  ```

  You can extend the zone lock by running the above command with the `--duration` parameter once again for the same zone.

{% endlist %}


## Enabling availability zones {#enable-zone}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the availability zone enable command for a network load balancer:

      ```bash
      yc load-balancer network-load-balancer enable-zones --help
      ```

  1. Get a list of all network load balancers in the default folder:

      ```bash
      yc load-balancer network-load-balancer list
      ```

      Result:

      ```text
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      |          ID          |     NAME    |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      | ds70q425egoe******** | my-balancer | ru-central1 | EXTERNAL |              1 | enpakget56sr********   | ACTIVE |
      |                      |             |             |          |                | enpakf7vhj2l********   |        |
      | fw7fh46bnsge******** | my-nlb2     | ru-central1 | EXTERNAL |              1 | sn5u68knmswe********   | ACTIVE |
      +----------------------+-------------+-------------+----------+----------------+------------------------+--------+
      ```

  1. Enable one or more availability zones:

      ```bash
      yc load-balancer network-load-balancer enable-zones \
        <load_balancer_name_or_ID> \
        --zones=<zone_1_ID>,[<zone_2_ID>]
      ```

     Result:

      ```text
      id: ds70q425egoe********
      ...
      allow_zonal_shift: false
      disable_zone_statuses:
      ```

{% endlist %}


## Check availability zone lock settings {#check-shift}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To check if there are any disabled zones and whether a lock period is set, run the following command:

    ```bash
    yc load-balancer network-load-balancer get \
      <load_balancer_name_or_ID>
    ```

    Result:

    ```text
    id: ds70q425egoe********
    ...
    disable_zone_statuses:
      - zone_id: ru-central1-b
      - zone_id: ru-central1-d
        disabled_until: "2025-06-06T04:10:02.679608678Z"
    ```
      
{% endlist %}
