{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the line with the VM, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.

     To delete multiple VMs, select them from the list and click **{{ ui-key.yacloud.common.delete }}** at the bottom of the screen.

  1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for deleting a VM:

     ```bash
     yc compute instance delete --help
     ```

  1. Get a list of VMs in the default folder:

     {% include [compute-instance-list](../../compute/_includes_service/compute-instance-list.md) %}

  1. Select `ID` or `NAME` of the VM, e.g., `first-instance`.
  1. Delete the VM:

     ```bash
     yc compute instance delete first-instance
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  To delete a VM created using {{ TF }}, follow these steps:
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

  Use the [delete](../../compute/api-ref/Instance/delete.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Delete](../../compute/api-ref/grpc/Instance/delete.md) gRPC API call.

{% endlist %}
