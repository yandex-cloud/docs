---
title: How to start, stop, and restart a desktop in {{ cloud-desktop-full-name }}
description: In this tutorial, you will learn how to start, stop, and restart a desktop in {{ cloud-desktop-name }}.
---

# Starting, stopping, and restarting a desktop

## Starting {#start}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the desktop.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Click ![options](../../../_assets/console-icons/ellipsis.svg) next to the desktop you want to start, then select **{{ ui-key.yacloud.vdi.button_start }}**.
  1. Confirm launch.

- User desktop showcase {#desktop-showcase}

  1. Open the [User desktop showcase]({{ link-cloud-desktop-showcase }}).
  1. On the desktop card you want to start, click ![image](../../../_assets/console-icons/play.svg).
  1. Confirm launch.

{% endlist %}

## Restarting {#restart}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the desktop.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Click ![options](../../../_assets/console-icons/ellipsis.svg) next to the desktop you want to restart, then select **{{ ui-key.yacloud.vdi.button_restart }}**.
  1. Confirm restart.

- User desktop showcase {#desktop-showcase}

  1. Open the [User desktop showcase]({{ link-cloud-desktop-showcase }}).
  1. On the desktop card you want to restart, click ![image](../../../_assets/console-icons/arrow-rotate-right.svg).
  1. Confirm restart.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/index.yaml) command restarting a [desktop](../../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop restart --help
      ```

  1. Get a list of desktops in the default folder:

      ```bash
      yc desktops desktop list
      ```

      Result:

      ```bash
      +----------------------+------------------+--------+----------------------+---------------------+
      |          ID          |       NAME       | STATUS |   DESKTOP GROUP ID   |   CREATED (UTC-0)   |
      +----------------------+------------------+--------+----------------------+---------------------+
      | e3vmvhgbgac4******** | my-cloud-desktop | ACTIVE | e3v1rbln45tl******** | 2024-10-09 22:42:28 |
      | e3vio1bc5ppz******** | reserved-desktop | ACTIVE | e3v1rbln45tl******** | 2024-10-09 21:35:17 |
      +----------------------+------------------+--------+----------------------+---------------------+
      ```

  1. Select the `ID` or `NAME` of the desktop you need, e.g., `my-cloud-desktop`.
  1. Restart the desktop:

      ```bash
      yc desktops desktop restart --name <desktop_name>
      ```

      {% include [create-desktop-cli-result](../../../_includes/cloud-desktop/create-desktop-cli-result.md) %}

{% endlist %}

## Stopping {#stop}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the desktop.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Click ![options](../../../_assets/console-icons/ellipsis.svg) next to the desktop you want to stop, then select **{{ ui-key.yacloud.vdi.button_stop }}**.
  1. Confirm stop.

- User desktop showcase {#desktop-showcase}

  1. Open the [User desktop showcase]({{ link-cloud-desktop-showcase }}).
  1. On the desktop card you want to stop, click ![image](../../../_assets/console-icons/power.svg).
  1. Confirm stop.

{% endlist %}
