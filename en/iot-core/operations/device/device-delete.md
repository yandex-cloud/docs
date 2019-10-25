# Deleting a device

To access a [device](../../concepts/index.md#device), use its ID or name. For information about how to get the ID or name of a device, see [{#T}](device-list.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete the device:

      ```
      $ yc iot device delete my-device
      ```

  1. Make sure the device was deleted:

      ```
      $ yc iot device list --registry-name my-registry
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

{% endlist %}

