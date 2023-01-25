# Creating a desktop group

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select a folder to create your desktop group in.
  1. In the list of services, select **Cloud Desktop**.
  1. Click **Create desktop group**.
  1. Enter a name and description of the desktop group.
  1. Under **Computing resources**:

      * Choose a [platform](../../../compute/concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.

  1. Under **Network settings**, select a [cloud network](../../../vpc/concepts/network.md) and subnets from the list.
  1. Click **Create**.

{% endlist %}
