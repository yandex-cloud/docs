Create a [cloud network](../../../vpc/concepts/network.md#network) and [subnets](../../../vpc/concepts/network.md#subnet) for your new cloud infrastructure:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter a name for the network: `nextcloud-network`.
  1. Make sure the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option is enabled and click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

{% endlist %}