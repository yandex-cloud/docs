1. In the [management console]({{ link-console-main }}), select the folder where you want to connect a VM to {{ backup-name }}.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** and then select the VM.
1. Under **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**, add a security group to the VM [network interface](../../../compute/concepts/network.md):

    * In the top-right corner of the section, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
    * In the window that opens, select the previously created security group in the **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** field.
    * Click **{{ ui-key.yacloud.common.save }}**.

1. If the VM does not have a [public IP address](../../../vpc/concepts/address.md#public-addresses), then under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) in the top-right corner of the relevant network interface section and select **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**. In the window that opens:

    * In the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, select `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}` to get an IP address automatically or `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}` to choose a reserved address from the list.
    * Optionally, if you selected `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}` in the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, enable **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_ddos-protection-provider }}**. For more information, see [{#T}](../../../vpc/ddos-protection/index.md).
    * If you selected `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}` in the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, choose the IP address you want to assign to your VM. The IP address and the VM must be in the same [availability zone](../../../overview/concepts/geo-scope.md).
    * Click **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

    Instead of assigning a public IP address to your VM, you can associate the subnet hosting this VM with a [route table](../../../vpc/concepts/routing.md#rt-vm) allowing internet access via a [NAT gateway](../../../vpc/concepts/gateways.md) or a custom router.