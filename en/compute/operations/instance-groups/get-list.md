# Get a list of instance groups

To get a list of instance groups:

{% list tabs %}

- Management console
  1. Open the folder page in the management console.
  1. Select **{{ compute-full-name }}**.
  1. On the **Virtual machines** page, go to the **Instance groups** tab.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's use instance group command:

      ```
      $ {{ yc-compute-ig }} --help
      ```

  1. Get a list of instance groups in the default folder:

      {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

- API

  Use the [list](../../api-ref/InstanceGroup/list.md).

  To request a list of available groups, use the [listInstances](../../api-ref/InstanceGroup/listInstances.md) method.

{% endlist %}

