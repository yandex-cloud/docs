# Updating an instance group

After creating an instance group, you can:

* [Change the name and description](#change-name).
* [Change computing resources](#change-compute-resources).
* [Increase the disk size](#change-disk-size).

## Changing the name and description {#change-name}

To change the name and description of an instance group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open the folder with the appropriate instance group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. Select the group to update.
   1. In the upper-right corner of the page, click **{{ ui-key.yacloud.compute.groups.button_action-edit }}**.
   1. Fill in the **{{ ui-key.yacloud.compute.groups.create.field_name }}** and **{{ ui-key.yacloud.compute.groups.create.field_description }}** fields.
   1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the update group command in the CLI:

      ```
      {{ yc-compute-ig }} update --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the `ID` of the instance group.
   1. Specify the name and description in the YAML file that was used to create the group (for example, `specification.yaml`). If the YAML file was not saved, [get information](get-info.md) about the instance group and create a new file. For more information, see [{#T}](create-fixed-group.md).
   1. Update the instance group in the default folder:

      ```
      {{ yc-compute-ig }} update --name first-instance-group --file specification.yaml
      ```

      {{ ig-name }} will launch the instance group update process.

- API

   You can change the name and description of an instance group by using the [update](../../api-ref/InstanceGroup/update.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Update](../../api-ref/grpc/instance_group_service.md#Update) gRPC API call.

   To request the list of available instance groups, use the [listInstances](../../api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances) gRPC API call.

{% endlist %}

## Updating computing resources {#change-compute-resources}

After creating an instance group, you can change:

* Guaranteed vCPU share.
* Number of vCPUs and the amount of RAM.

{% include [include](../../../_includes/instance-groups/update-stopped-group-disclaimer.md) %}

To change the computing resources of an instance group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open the folder with the appropriate instance group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. Select the group to update.
   1. In the upper-right corner of the page, click **{{ ui-key.yacloud.compute.groups.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**:
      * Click ![image](../../../_assets/horizontal-ellipsis.svg) in the top-right corner and select **{{ ui-key.yacloud.common.delete }}** to delete the current instance template.
      * Click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** to create a new template with required instance parameters.
      * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
   1. Click **{{ ui-key.yacloud.common.save }}** on the **{{ ui-key.yacloud.compute.group.edit.label_title }}** page.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the update group command in the CLI:

      ```
      {{ yc-compute-ig }} update --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the `ID` of the instance group.
   1. Specify the required instance parameters in the `resources_spec` key in the YAML file that was used to create the group (for example, `specification.yaml`). If the YAML file was not saved, [get information](get-info.md) about the instance group and create a new file. For more information, see [{#T}](create-fixed-group.md).
   1. Update the instance group in the default folder:

      ```
      {{ yc-compute-ig }} update --name first-instance-group --file specification.yaml
      ```

      {{ ig-name }} will launch the instance group update process.

- API

   You can change the computing resources by using the [update](../../api-ref/InstanceGroup/update.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Update](../../api-ref/grpc/instance_group_service.md#Update) gRPC API call.

   To request the list of available instance groups, use the [listInstances](../../api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances) gRPC API call.

{% endlist %}

## Increasing disk size {#change-disk-size}

{% include [include](../../../_includes/instance-groups/update-stopped-group-disclaimer.md) %}

To increase the disk size of an instance group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open the folder with the appropriate instance group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. Select the group to update.
   1. In the upper-right corner of the page, click **{{ ui-key.yacloud.compute.groups.button_action-edit }}**.
   1. In the top-right corner of the **{{ ui-key.yacloud.compute.groups.create.section_instance }}** section, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_disk }}**, specify the disk size.
   1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
   1. Click **{{ ui-key.yacloud.common.save }}** on the **{{ ui-key.yacloud.compute.group.edit.label_title }}** page.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the update group command in the CLI:

      ```
      {{ yc-compute-ig }} update --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the `ID` of the instance group.
   1. Specify the required storage size in the `boot_disk_spec` key in the YAML file that was used to create the group (for example, `specification.yaml`). If the YAML file was not saved, [get information](get-info.md) about the instance group and create a new file. For more information, see [{#T}](create-fixed-group.md).
   1. Update the instance group in the default folder:

      ```
      {{ yc-compute-ig }} update --name first-instance-group --file specification.yaml
      ```

      {{ ig-name }} will launch the instance group update process.

- API

   You can change the disk size by using the [update](../../api-ref/InstanceGroup/update.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Update](../../api-ref/grpc/instance_group_service.md#Update) gRPC API call.

   To request the list of available instance groups, use the [listInstances](../../api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances) gRPC API call.

{% endlist %}

