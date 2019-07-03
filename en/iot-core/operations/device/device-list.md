# Getting information about a device

Get a list of devices in a registry to find the `ID` or `NAME` of a device, or get detailed information about a device.

## Getting a list of devices in a registry {#device-list}

If you don't know the ID or name of the registry where your device is located, [view the list of existing registries](../registry/registry-list.md#registry-list).

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Get a list of [devices](../../concepts/index.md#device) in a registry:
  
  ```
  $ yc iot device list --registry-name my-registry
  
  +----------------------+-----------+
  |          ID          |   NAME    |
  +----------------------+-----------+
  | b9135goeh1uc1s2i07nm | my-device |
  +----------------------+-----------+
  ```
  
{% endlist %}

## Getting detailed information about a device {#device-get}

To access the device, use the `ID` or `NAME` parameters from the [previous](#device-list) section.

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Get detailed information about a device:
  
  ```
  $ yc iot device get my-device
  
  id: b9135goeh1uc1s2i07nm
  registry_id: b91ki3851hab9m0l68je
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  ```
  
{% endlist %}

