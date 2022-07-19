# Recover an instance group

You can recover a group if one of its instances becomes unhealthy and the status changes to `FAILED`. For more information about statuses, see the section [{#T}](../../concepts/vm-statuses.md).

To recover an instance group:

{% list tabs %}

- Management console

  1. Open the folder page in the management console.
  1. Select **{{ compute-full-name }}**.
  1. On the **Virtual machines** page, go to the **Instance groups** tab.
  1. Click on the name of the group you want to recover.
  1. Click **Recover** in the upper-right corner of the page.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's recover group command:

     ```
     {{ yc-compute-ig }} recover --help
     ```

  1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select the `ID` or `NAME` of the necessary group (for example, `first-instance-group`).

  1. Recover the instance group in the default folder:

      ```
      {{ yc-compute-ig }} recover --name first-instance-group
      ```

     {{ ig-name }} starts the operation to recover the instance group.


{% endlist %}

