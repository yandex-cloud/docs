# Updating a device

You can update the [name](device-update.md#update-name) or [description](device-update.md#update-description) of a device.

To access a device, use its unique ID or name. For information on retrieving the unique device ID or name, see [{#T}](device-list.md).

## Updating device names {#update-name}

{% list tabs %}

- Management console

   To update the name of a device:

   1. In the [management console]({{ link-console-main }}), select the folder to update the device name in.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. To the right of the name of the device you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. Edit the **Name** field.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Change the device name:

   ```
   yc iot device update my-device --new-name test-device
   ```

   Result:
   ```
   id: b9135goeh1uc1s2i07nm
   registry_id: b91ki3851hab9m0l68je
   created_at: "2019-05-28T16:08:30.938Z"
   name: test-device
   ```

{% endlist %}

## Updating device descriptions {#update-description}

{% list tabs %}

- Management console

   To update the description of a device:

   1. In the [management console]({{ link-console-main }}), select the folder to update the device description in.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. To the right of the name of the device you need, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Edit** from the drop-down list.
   1. Edit the **Description** field.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Change the device description:

   ```
   yc iot device update my-device --description "My first device."
   ```

   Result:

   ```
   id: b9135goeh1uc1s2i07nm
   registry_id: b91ki3851hab9m0l68je
   created_at: "2019-05-28T16:08:30.938Z"
   name: my-device
   description: My first device.
   ```

{% endlist %}
