1. In the [management console]({{ link-console-main }}), in the top panel, click ![image](../_assets/console-icons/chevron-down.svg) and select the [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud).
1. To the right of the cloud name, click ![image](../_assets/console-icons/ellipsis.svg).
1. Select **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}** ![image](../_assets/console-icons/plus.svg).

   ![create-folder1](../_assets/resource-manager/create-folder-1.png)

1. Give your [folder](../resource-manager/concepts/resources-hierarchy.md#folder) a name. The naming requirements are as follows:

    {% include [name-format](name-format.md) %}

1. Optionally, specify the description for your folder.
1. Select **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. This will create a [network](../vpc/concepts/network.md#network) with subnets in each availability zone. Within this network, you will also have a [default security group](../vpc/concepts/security-groups.md#default-security-group), within which all network traffic will be allowed.
1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

   ![create-folder2](../_assets/resource-manager/create-folder-2.png)
