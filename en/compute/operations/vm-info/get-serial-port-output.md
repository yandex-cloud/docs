# Getting serial port's output

You can get the information that the VM outputs to the serial port. This can be useful for troubleshooting.

{% list tabs %}

- Management console
  1. Select the folder the VM belongs to.
  1. Select **{{ compute-name }}**.
  1. Click on the line with the VM you need.
  1. Go to the **Serial port** tab.
  1. To use the **Ctrl** + **F** keyboard shortcut to search, enable **Raw mode** in the upper-right corner.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the command to get serial port output:

      ```
      yc compute instance get-serial-port-output --help
      ```

   1. Select a VM, for example, `first-instance`:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Get the serial port output. The serial port's output is usually long, so it should be written to a file:

      ```
      yc compute instance get-serial-port-output first-instance > output.txt
      ```

- API

   To get the serial port output, use the [getSerialPortOutput](../../api-ref/Instance/getSerialPortOutput.md) method for the [Instance](../../api-ref/Instance/index.md) resource.

{% endlist %}
