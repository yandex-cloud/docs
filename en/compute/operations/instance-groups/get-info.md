# Getting information about an instance group

After creating an instance group, you can get basic information about the group.

User-defined [metadata](../../concepts/vm-metadata.md) that was passed during group creation or update can only be obtained using the CLI or API.

To get information about an instance group:

{% list tabs %}

- Management console
  1. Open the folder page in the management console.
  1. Select **{{ compute-full-name }}**.
  1. On the **Virtual machines** page, go to the **Instance groups** tab.
  1. Click on the name of the group you need.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's get instance group info command:

      ```
      $ {{ yc-compute-ig }} get --help
      ```

  1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select the group `ID` or `NAME` (for example, `first-instance-group`).

  1. Get information about the instance group:

      ```
      $ {{ yc-compute-ig }} get --name first-instance-group
      ```

- API

  Use the [get](../../api-ref/InstanceGroup/get.md).

  To request a list of available groups, use the method [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}

