---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Getting a list of instances in a group

After creating an instance group, you can get a list of instances in the group.

To get a list of instances:

{% list tabs %}

- Management console
  1. Open the folder page in the management console.
  1. Select **{{ compute-full-name }}**.
  1. On the **Virtual machines** page, go to the **Instance groups** tab.
  1. Click on the name of the group you need.
  1. On the **Overview** page, go to the **List of VMs** tab.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's get instance list command:

      ```
      $ {{ yc-compute-ig }} list-instances --help
      ```

  1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select the group `ID` or `NAME` (for example, `first-instance-group`).

  1. Get information about the instance group:

      ```
      $ {{ yc-compute-ig }} list-instances --name first-instance-group
      ```

- API

  Use the [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}

