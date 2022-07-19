# Update an instance group

After creating an instance group, you can:

* [Changing the name and description](#change-name).
* [To change computing resources](#change-compute-resources).
* [Increasing the disk size](#change-disk-size).

## Changing the name and description {#change-name}

To change the name and description of an instance group:

{% list tabs %}

- Management console

   1. Open the folder page in the [management console]({{ link-console-main }}).
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Click on the name of the group you want to update.
   1. Click **Change** in the upper-right corner of the page.
   1. Enter the appropriate name and description for the group.
   1. Click **Save**.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the update group command in the CLI:

      ```
      {{ yc-compute-ig }} update --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the group `ID` or `NAME` (for example, `first-instance-group`).
   1. Specify the name and description in the YAML file that was used to create the group (for example, `specification.yaml`). If the YAML file wasn't saved, [get information](get-info.md) about the instance group and create a new file. For more information, see [{#T}](create-fixed-group.md).
   1. Update the instance group in the default folder:

      ```
      {{ yc-compute-ig }} update --name first-instance-group --file specification.yaml
      ```

      {{ ig-name }} will launch the instance group update process.

- API

   You can change a group name and description using the API [update](../../api-ref/InstanceGroup/update.md) method.

   To request a list of available groups, use the method [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}

## Updating computing resources {#change-compute-resources}

After creating an instance group, you can change:

* The guaranteed vCPU share.
* The number of vCPUs and amount of RAM.

{% include [include](../../../_includes/instance-groups/update-stopped-group-disclaimer.md) %}

To change the computing resources of an instance group:

{% list tabs %}

- Management console

   1. Open the folder page in the [management console]({{ link-console-main }}).
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Click on the name of the group you want to update.
   1. Click **Change** in the upper-right corner of the page.
   1. Delete the current instance template and create a new one with the appropriate instance parameters.
   1. Click **Save**.
   1. Click **Save** on the **Changing an instance group page**.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the update group command in the CLI:

      ```
      {{ yc-compute-ig }} update --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the group `ID` or `NAME` (for example, `first-instance-group`).
   1. Specify the necessary instance parameters in the `resources_spec` key in the YAML file that was used to create the group (for example, `specification.yaml`). If the YAML file wasn't saved, [get information](get-info.md) about the instance group and create a new file. For more information, see [{#T}](create-fixed-group.md).
   1. Update the instance group in the default folder:

      ```
      {{ yc-compute-ig }} update --name first-instance-group --file specification.yaml
      ```

      {{ ig-name }} will launch the instance group update process.

- API

   You can change the computing resources using the [update](../../api-ref/InstanceGroup/update.md).

   To request a list of available groups, use the method [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}

## Increasing a disk's size {#change-disk-size}

{% include [include](../../../_includes/instance-groups/update-stopped-group-disclaimer.md) %}

To increase the disk size of an instance group:

{% list tabs %}

- Management console

   1. Open the folder page in the [management console]({{ link-console-main }}).
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Click on the name of the group you want to update.
   1. Click **Change** in the upper-right corner of the page.
   1. Click ![image](../../../_assets/horizontal-ellipsis.svg) in the top right-hand corner of the **Virtual machine template** section and select **Edit**.
   1. Under **Disks**, specify the disk size:
   1. Click **Save**.
   1. Click **Save** on the **Changing an instance group page**.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the update group command in the CLI:

      ```
      {{ yc-compute-ig }} update --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the group `ID` or `NAME` (for example, `first-instance-group`).
   1. Specify the required storage size in the `boot_disk_spec` key in the YAML file that was used to create the group (for example, `specification.yaml`). If the YAML file wasn't saved, [get information](get-info.md) about the instance group and create a new file. For more information, see [{#T}](create-fixed-group.md).
   1. Update the instance group in the default folder:

      ```
      {{ yc-compute-ig }} update --name first-instance-group --file specification.yaml
      ```

      {{ ig-name }} will launch the instance group update process.

- API

   You can change the disk size using the [update](../../api-ref/InstanceGroup/update.md).

   To request a list of available groups, use the method [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}

