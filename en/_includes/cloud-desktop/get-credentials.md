{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your desktop.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
   1. In the left-hand panel, select ![image](../../_assets/cloud-desktop/desktops.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
   1. Select the desktop to connect to.
   1. Under **{{ ui-key.yacloud.vdi.section_access }}**, click ![image](../../_assets/options.svg) next to the user account and select **{{ ui-key.yacloud.vdi.button_reset-password }}**.
   1. Confirm the password reset.
   1. Save a new password from the pop-up window and close it.
   1. At the top right, click ![image](../../_assets/cloud-desktop/download.svg) **{{ ui-key.yacloud.vdi.button_download-rdp }}**.

- User desktop showcase

   1. Open the [User desktop showcase]({{ link-cloud-desktop-showcase }}).
   1. Authenticate using [Yandex ID](https://yandex.com/support/id/index.html) or [Single Sign-On (SSO)](../../organization/concepts/add-federation.md).
   1. If the desktop you want to connect to is in the `Stopped` status, run it by clicking ![image](../../_assets/cloud-desktop/play.svg) and confirm the action.

      Wait for the desktop status to change to `Active`.
   1. Click ![image](../../_assets/cloud-desktop/reset.svg) and confirm the password reset.
   1. Save a new password from the pop-up window and close it.
   1. Click ![image](../../_assets/cloud-desktop/download.svg) **{{ ui-key.yacloud.vdi.button_download-rdp }}**.

{% endlist %}
