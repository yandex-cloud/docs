---
title: "How to delete an instance group"
description: "Deleting an instance group is an operation that cannot be canceled or reversed. You cannot restore a deleted group. Along with the group, you delete the {{ network-load-balancer-name }} target group, instances, and disks. To delete an instance group, open the folder page in the management console. Select the {{ compute-full-name }} service. On the Virtual machines page, go to the Instance groups tab.  Select Delete."
---

# Delete an instance group

{% note warning %}

Deleting an instance group is an operation that cannot be canceled or reversed. You cannot restore a deleted group. Along with the group, you delete the {{ network-load-balancer-full-name }} target group, instances, and disks.

{% endnote %}

To delete an instance group:

{% list tabs %}

- Management console

   1. Open the folder page in the [management console]({{ link-console-main }}).
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Click ![image](../../../_assets/horizontal-ellipsis.svg) for the desired group and select the **Delete** option.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI instance group delete command below:

      ```bash
      {{ yc-compute-ig }} delete --help
      ```

   1. Get a list of instance groups in the default folder:

      {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

   1. Select the group `ID` or `NAME` (for example, `first-instance-group`).
   1. Delete the instance group:

      ```bash
      {{ yc-compute-ig }} delete --name first-instance-group
      ```

      {{ ig-name }} will launch the instance deletion process.

- API

   Use the API [delete](../../api-ref/InstanceGroup/delete.md) method.

   To request a list of available groups, use the method [listInstances](../../api-ref/InstanceGroup/listInstances.md).

- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   If you created an instance group using {{ TF }}, you can delete it:
   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Delete resources using the command:

      ```bash
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and instances.

      {% endnote %}

   1. Type the word `yes`, then press **Enter**.

{% endlist %}