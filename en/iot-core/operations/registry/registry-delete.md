# Deleting a registry

{% note important %}

You can only delete an empty registry. Don't forget to [delete devices from the registry](../device/device-delete.md) before performing the operation.

{% endnote %}

To access a [registry](../../concepts/index.md#registry), use its ID or name. For information about how to get the registry ID or name, see [#T](registry-list.md).

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  1. Delete the registry:
  
      ```
      $ yc iot registry delete my-registry
      ```
  
  1. Make sure the registry was deleted:
  
      ```
      $ yc iot registry list
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+    
      ```
  
{% endlist %}

