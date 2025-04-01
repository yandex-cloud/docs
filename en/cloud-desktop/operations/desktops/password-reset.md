---
title: How to reset a user password for a desktop in {{ cloud-desktop-full-name }}
description: In this tutorial, you will learn how to reset a user password for a desktop in {{ cloud-desktop-full-name }}.
---

# Resetting a desktop user password

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your desktop.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Select the desktop to connect to.
  1. Under **{{ ui-key.yacloud.vdi.section_access }}**, next to the user account, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.vdi.button_reset-password }}**.
  1. Confirm the password reset.
  1. Save a new password from the pop-up window and close it.

- User desktop showcase {#desktop-showcase}

  1. Open the [user desktop showcase]({{ link-cloud-desktop-showcase }}).
  1. If the desktop you want to connect to has the `Stopped` status, run it by clicking ![image](../../../_assets/console-icons/play.svg) and confirm the action.

      Wait for the desktop status to change to `Active`.
  1. Click ![image](../../../_assets/console-icons/lock-open.svg) and confirm the password reset.
  1. Save a new password from the pop-up window and close it.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli/index.yaml) command to reset a [desktop](../../../cloud-desktop/concepts/desktops-and-groups.md) password:

      ```bash
      yc desktops desktop reset-password --help
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

  1. Select the `ID` of the desktop you need.
  1. {% include [cli-reset-password](../../../_includes/cloud-desktop/cli-reset-password.md) %}

- API {#api}

  Use the [resetPassword](../../api-ref/Desktop/resetPassword.md) REST API method for the [Desktop](../../api-ref/Desktop/index.md) resource or the [DesktopService/ResetPassword](../../api-ref/grpc/Desktop/resetPassword.md) gRPC API call.

{% endlist %}