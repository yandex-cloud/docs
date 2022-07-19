---
title: "How to delete an instance group"
description: "Deleting a group of virtual machines is an irreversible and irreversible operation, it is impossible to restore a deleted group. Together with the group, the Network Load Balancer target group, virtual machines and disks are deleted. To delete a group of virtual machines, open the catalog page in the management console. Select the Yandex Compute service Cloud. On the Virtual Machines page, go to the Virtual Machine Groups tab. Select Delete."
---

# Delete an instance group

{% note warning %}

Deleting an instance group is an operation that cannot be canceled or reversed. You cannot restore a deleted group. Along with the group, you delete the {{ network-load-balancer-name }} target group, instances, and disks.

{% endnote %}

To delete an instance group:

{% list tabs %}

- Management console

   1. Open the folder page in the [management console]({{ link-console-main }}).
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Click ![image](../../../_assets/horizontal-ellipsis.svg) for the desired group and select the **Delete** option.
   1. Confirm the action.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete instance group command:

      ```
      {{ yc-compute-ig }} delete --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the group `ID` or `NAME` (for example, `first-instance-group`).
   1. Delete the instance group:

      ```
      {{ yc-compute-ig }} delete --name first-instance-group
      ```

      {{ ig-name }} will launch the virtual machine deletion process.

- API

   Use the API [delete](../../api-ref/InstanceGroup/delete.md) method.

   To request a list of available groups, use the method [listInstances](../../api-ref/InstanceGroup/listInstances.md).

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   If you created an instance group using {{ TF }}, you can delete it:

   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Delete resources using the command:

      ```
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

   1. Confirm the deletion of resources.



{% endlist %}
