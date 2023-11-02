1. In the [management console]({{ link-console-main }}), select the appropriate [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud) in the list on the left.
1. At the top right, click ![image](../_assets/create.png) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
1. Enter the [folder](../resource-manager/concepts/resources-hierarchy.md#folder) name. The naming requirements are as follows:

   {% include [name-format](name-format.md) %}

1. (Optional) Enter a description of the folder.
1. Select **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. This will create a [network](../vpc/concepts/network.md#network) with subnets in each availability zone. Within this network, a [default security group](../vpc/concepts/security-groups.md#default-security-group) will be created, inside which all network traffic is allowed.
1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.