# Getting the serial port output

You can get the output from a VM serial port and use it, e.g., for troubleshooting.

To access the output data, you need the `compute.operator` or `{{ roles-viewer }}` [role](../../security/index.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. Select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click the line with the VM in question.
  1. Go to the **{{ ui-key.yacloud.compute.instance.switch_service-console }}** tab.
  1. To use the **CTRL** + **F** shortcut to search, enable **{{ ui-key.yacloud.compute.instance.service-console.raw-mode }}** in the top-right corner.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the command for getting the serial port output:

      ```
      yc compute instance get-serial-port-output --help
      ```

  1. Select a VM, e.g., `first-instance`:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Get its serial port output. Since the serial port output is usually lengthy, we recommend writing it to a file:

      ```
      yc compute instance get-serial-port-output first-instance > output.txt
      ```

- API {#api}

  To get the serial port output, use the [getSerialPortOutput](../../api-ref/Instance/getSerialPortOutput.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/GetSerialPortOutput](../../api-ref/grpc/Instance/getSerialPortOutput.md) gRPC API call.

{% endlist %}
