1. In the [management console]({{ link-console-main }}), select a cloud and click ![Create icon](../_assets/create.png) **Create folder**.
1. Enter the folder name. Naming requirements:

   {% include [name-format](name-format.md) %}

1. (Optional) Enter a description of the folder.
1. Select the **Create a default network** option. A [network](../vpc/concepts/network.md#network) is created with subnets in each availability zone. A [default security group](../vpc/concepts/security-groups.md#default-security-group), where all network traffic is allowed inside, will also be created in this network.
1. Click **Create**.
