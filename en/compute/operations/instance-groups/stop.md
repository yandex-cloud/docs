---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Stop an instance group

If you don't need instances in a group for a while, stop the group. All instances in the group are stopped. If the instance group is very large and it would take a long time to create that many instances afterwards, stopping a group is more effective than deleting it or reducing its size to zero.

{% note info %}

If you stop an single instance in a group instead of the whole group, {{ ig-name }} [automatically restarts](../../concepts/instance-groups/autohealing.md) the instance.

{% endnote %}

Only disks are charged for stopped instances. If you don't want to pay for disk usage, then reduce the instance group size to 0 or [delete the group](delete.md). To avoid losing data, [make snapshots of the disks](../disk-control/create-snapshot.md).

{% list tabs %}

- Management console
  1. Open the folder page in the management console.
  1. Select **{{ compute-full-name }}**.
  1. On the **Virtual machines** page, go to the **Instance groups** tab.
  1. Select the instance group and click ![image](../../../_assets/horizontal-ellipsis.svg), and select **Stop**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. View a description of the stop instance group command in the CLI:

     ```
     $ {{ yc-compute-ig }} stop --help
     ```

  1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select the group `ID` or `NAME` (for example, `first-instance-group`).

  1. Stop an instance group in the default folder:

      ```
      $ {{ yc-compute-ig }} stop first-instance-group
      ```

     {{ ig-name }} begins to stop instances in the group. When all instances are stopped, the group status switches to `STOPPED`.

- API

  You can stop an instance group using the API method [stop](../../api-ref/InstanceGroup/stop.md).

  To request a list of available groups, use the method [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}

