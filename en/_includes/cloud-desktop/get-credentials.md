{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your desktop.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Select the desktop you want to connect to.
  1. Under **{{ ui-key.yacloud.vdi.section_access }}**, next to the user account, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.vdi.button_reset-password }}**.
  1. Confirm the password reset.
  1. Save the new password from the pop-up window that appears and close the window.
  1. At the top right, click ![image](../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.vdi.button_download-rdp }}**.

- User desktop showcase {#desktop-showcase}

  1. Open the [User desktop showcase]({{ link-cloud-desktop-showcase }}).
  1. Sign in with your [Yandex ID](https://yandex.com/support/id/index.html) or using [Single Sign-On (SSO)](../../organization/concepts/add-federation.md).
  1. If the desktop you want to connect to has the `Stopped` status, run it by clicking ![image](../../_assets/console-icons/play.svg) and then confirming the action.

      Wait for the desktop status to change to `Active`.
  1. Click ![image](../../_assets/console-icons/lock-open.svg) and confirm the password reset.
  1. Save the new password from the pop-up window that appears and close the window.
  1. Click ![image](../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.vdi.button_download-rdp }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/index.yaml) command for getting RDP file data:

      ```bash
      yc desktops desktop get-rdp-file --help
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
  1. [Reset](../../cloud-desktop/operations/desktops/password-reset.md) the desktop user password.


  1. Request the data:

      ```bash
      yc desktops desktop get-rdp-file --name <desktop_name>
      ```

      Result:

      ```text
      full address:s:my-cloud-desktop
      gatewayhostname:s:rdg.vdi.cloud.yandex.net:3839
      gatewaycredentialssource:i:5
      gatewayusagemethod:i:1
      gatewayprofileusagemethod:i:1
      gatewayaccesstoken:s:ver=1;desktopUserToken=0174a9f2-...V6DQ
      networkautodetect:i:0
      bandwidthautodetect:i:1
      connection type:i:6
      username:s:.\alice-little
      domain:s:
      bitmapcachesize:i:32000
      smart sizing:i:1
      audiocapturemode:i:1
      audiomode:i:0
      authentication level:i:0
      ```

  1. Save the received data to an `.rdp` file.

- API {#api}

  Use the [getRdpFile](../../cloud-desktop/api-ref/Desktop/getRdpFile.md) REST API method for the [Desktop](../../cloud-desktop/api-ref/Desktop/index.md) resource or the [DesktopService/GetRdpFile](../../cloud-desktop/api-ref/grpc/Desktop/getRdpFile.md) gRPC API call.

  To reset the password, use the [resetPassword](../../cloud-desktop/api-ref/Desktop/resetPassword.md) REST API method for the [Desktop](../../cloud-desktop/api-ref/Desktop/index.md) resource or the [DesktopService/ResetPassword](../../cloud-desktop/api-ref/grpc/Desktop/resetPassword.md) gRPC API call.

{% endlist %}
