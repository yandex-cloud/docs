1. [Get your cloud ready](#before-you-begin).
1. [Create a security group](#create-security-group).
1. [Create a VM for WordPress](#create-vm).
1. [Configure DNS (if you have a domain name)](#configure-dns).
1. [Get credentials for authentication in the web interface](#get-auth-data).
1. [Connect to the WordPress web interface](#connect-wordpress-interface).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

{% include [network-is-exist](../../_tutorials_includes/network-is-exist.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources-wp](../../_tutorials_includes/wordpress/paid-resources-wp.md) %}

## Create a security group {#create-security-group}

To create a [security group](../../../vpc/concepts/security-groups.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Open the **{{ ui-key.yacloud.vpc.network.security-groups.label_title }}** tab.
  1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. Specify the group **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}**: `wordpress`.
  1. Select **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}**.
  1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules using the instructions below the table:

     Traffic<br>direction | Description | Port<br>range | Protocol | Source /<br>destination type | Source /<br>destination
     --- | --- | --- | --- | --- | ---
     Egress | any | All | Any | CIDR | 0.0.0.0/0
     Ingress | ext-http | 80 | TCP | CIDR | 0.0.0.0/0
     Ingress | ext-https | 443 | TCP | CIDR | 0.0.0.0/0

     1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
     1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
     1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** window that opens, specify the port to receive traffic. Do not indicate anything for outgoing traffic.
     1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the required protocol. For outgoing traffic, leave `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` to allow traffic over all protocols.
     1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` for the rule to apply to a range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, enter `0.0.0.0`; in the list after **/**, select `0`.
     1. Click **{{ ui-key.yacloud.common.save }}**. Repeat these steps to create all rules from the table.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Create a VM for WordPress {#create-vm}

To create a VM:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder page](../../../resource-manager/concepts/resources-hierarchy.md#folder) in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `WordPress` and select a public [WordPress](/marketplace/products/yc/wordpress) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../../overview/concepts/geo-scope.md) where your VM will reside. If you are not sure which one to choose, leave the default.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network where you created the `wordpress` security group and the [subnet](../../../vpc/concepts/network.md#subnet) to connect your VM to. If you do not have a subnet, [create](../../../vpc/operations/subnet-create.md) one.
      * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `wordpress` security group.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access data:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username. Do not use `root` or other names reserved for the OS purposes. To perform operations requiring root privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `wordpress`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  It may take a few minutes to create your VM. When the VM status changes to `RUNNING`, you can start configuring your website.

  Once created, the VM is assigned an IP address and a [host name (FQDN)](../../../compute/concepts/network.md#hostname). This data can be used when configuring the DNS and SSH access.

{% endlist %}

## Configure the DNS (if you have a domain name) {#configure-dns}

If you have a registered domain name, use the [{{ dns-full-name }}](../../../dns/) service to manage the domain.

{% include [configure-a-record-and-cname](../../_tutorials_includes/configure-a-record-and-cname.md) %}

## Get credentials for authentication in the web interface {#get-auth-data}

{% include [get-auth-data](get-auth-data.md) %}

## Connect to the WordPress web interface {#connect-wordpress-interface}

To connect to the WordPress web interface, do the following:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [connect-wordpress-interface](connect-wordpress-interface.md) %}

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../../compute/operations/vm-control/vm-delete.md) `wordpress`.
1. [Delete](../../../vpc/operations/address-delete.md) the static public IP address if you reserved one for your VM.
1. [Delete](../../../dns/operations/resource-record-delete.md) the DNS records and [delete](../../../dns/operations/zone-delete.md) the DNS zone if you used {{ dns-name }}.
