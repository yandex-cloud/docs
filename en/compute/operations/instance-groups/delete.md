---
title: How to delete an instance group
description: Deleting an instance group is permanent and cannot be undone, so you cannot recover a deleted instance group. Along with the group, you also delete the {{ network-load-balancer-name }} target group, VM instances, and disks. To delete an instance group, open the folder page in the management console. Select {{ compute-full-name }}. On the **Virtual machines** page, go to the **Instance groups** tab. Select **Delete**.
---

# Deleting an instance group

{% note warning %}

You cannot undo the deletion of an instance group or recover it. Along with the group, you also delete the {{ network-load-balancer-name }} or {{ alb-name }} target group, VM instances, and disks. You cannot delete an instance group if it is a target group for a load balancer ({{ network-load-balancer-name }}) or a backend group ({{ alb-name }}).

{% endnote %}

To delete an instance group:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), open the folder containing the instance group you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. In the line with the instance group, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.groups.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting an instance group:

     ```bash
     {{ yc-compute-ig }} delete --help
     ```

  1. Get a list of instance groups in the default folder:

     {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Select `ID` or `NAME` of the group in question, e.g., `first-instance-group`.
  1. Delete the instance group:

     ```bash
     {{ yc-compute-ig }} delete --name first-instance-group
     ```

     {{ ig-name }} will initiate instance group deletion.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete an instance group created using {{ TF }}, follow these steps:
  1. In the command line, go to the directory with the {{ TF }} configuration file.
  1. Delete the resources using this command:

     ```bash
     terraform destroy
     ```

     {% note alert %}

     {{ TF }} will delete all the resources you created in the current configuration, such as clusters, networks, subnets, and VMs.

     {% endnote %}

  1. Type `yes` and press **Enter**.

- API {#api}

  Use the [delete](../../instancegroup/api-ref/InstanceGroup/delete.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Delete](../../instancegroup/api-ref/grpc/InstanceGroup/delete.md) gRPC API call.

  To request a list of available instance groups, use the [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) REST API method or the [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md) gRPC API call.

{% endlist %}