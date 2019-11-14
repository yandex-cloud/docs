# Updating a device

You can update the [name](device-update.md#update-name) and [description](device-update.md#update-description) of a device.

To access a device, use its ID or name. For information about how to get the ID or name of a device, see [{#T}](device-list.md).

## Updating the name of a device {#update-name}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Change the device name:

  ```
  $ yc iot device update my-device --new-name test-device

  id: b9135goeh1uc1s2i07nm
  registry_id: b91ki3851hab9m0l68je
  created_at: "2019-05-28T16:08:30.938Z"
  name: test-device
  ```

{% endlist %}

## Updating the description of a device {#update-description}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Change the device description:

  ```
  $ yc iot device update my-device --description "My first device."

  id: b9135goeh1uc1s2i07nm
  registry_id: b91ki3851hab9m0l68je
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  description: My first device.
  ```

{% endlist %}

