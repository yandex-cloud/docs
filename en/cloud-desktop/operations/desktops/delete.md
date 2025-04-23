---
title: How to delete a desktop in {{ cloud-desktop-full-name }}
description: In this tutorial, you will learn how to delete a desktop in {{ cloud-desktop-full-name }}.
---

# Deleting a desktop

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the desktop.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the desktop you want to delete, then select **{{ ui-key.yacloud.common.delete }}**.

      {% note tip %}

      To delete multiple desktops, select them in the list and click **{{ ui-key.yacloud.common.delete }}** at the bottom of the screen.

      {% endnote %}

  1. Confirm the deletion.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/index.yaml) command for deleting a [desktop](../../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops desktop delete --help
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

  1. Select the desktop `ID` or `NAME`, e.g., `my-cloud-desktop`.
  1. Delete the desktop:

      ```bash
      yc desktops desktop delete <desktop_name_or_ID>
      ```

- API {#api}

  Use the [delete](../../api-ref/Desktop/delete.md) REST API method for the [Desktop](../../api-ref/Desktop/index.md) resource or the [DesktopService/Delete](../../api-ref/grpc/Desktop/delete.md) gRPC API call.

{% endlist %}
