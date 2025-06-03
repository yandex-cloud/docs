{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to connect a VM.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click the VM name.
  1. Under **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**, add a security group to the VM [network interface](../../../compute/concepts/network.md):

     * In the top-right corner of the section, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
     * In the window that opens, add the previously created security group in the **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** field.
     * Click **{{ ui-key.yacloud.common.save }}**.

  1. If the VM does not have a [public IP address](../../../vpc/concepts/address.md#public-addresses), then under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) in the top-right corner of the relevant network interface section and select **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**. In the window that opens:

      * In the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, select `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}` to get an IP address automatically or `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}` to choose a reserved address from the list.
      * Optionally, if you selected `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}` in the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, enable **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_ddos-protection-provider }}**. For more information, see [{#T}](../../../vpc/ddos-protection/index.md).
      * If you selected `{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_list }}` in the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, choose the IP address you want to assign to your VM. The IP address and the VM must be in the same availability zone.
      * Click **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. View the description of the VM [network interface](../../../compute/concepts/network.md) update command:

      ```bash
      yc compute instance update-network-interface --help
      ```

  1. Add the previously created security group to the VM network interface:

      ```bash
      yc compute instance update-network-interface \
        --id <VM_ID> \
        --network-interface-index <network_interface_number> \
        --security-group-id <security_group_ID>
      ```

      Where:

      * `--id`: VM ID.
      * `--network-interface-index`: Network interface number, e.g., `0`.
      * `--security-group-id`: Security group ID.

      Result:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      updateNetworkInterfaced_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:d9:8c:31:a4
          subnet_id: e2lb1da2dd9v********
          primary_v4_address:
            address: 10.129.**.**
            one_to_one_nat:
              address: 158.160.**.**
              ip_version: IPV4
          security_group_ids:
            - enpqtbh6ulo3********
      ...
      ```

  1. View the description of the command for assigning a public IP address to a VM:

      ```bash
      yc compute instance add-one-to-one-nat --help
      ```

  1. If your VM has no [public IP address](../../../vpc/concepts/address.md#public-addresses), assign one:

      ```bash
      yc compute instance add-one-to-one-nat \
        --id <VM_ID> \
        --network-interface-index <network_interface_number>
      ```

      Where:

      * `--id`: VM ID.
      * `--network-interface-index`: Network interface number, e.g., `0`.

      Result:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      updateNetworkInterfaced_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:d9:8c:31:a4
          subnet_id: e2lb1da2dd9v********
          primary_v4_address:
            address: 10.129.**.**
            one_to_one_nat:
              address: 158.160.**.**
              ip_version: IPV4
          security_group_ids:
            - enpqtbh6ulo3********
      ...
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  1. Open the configuration file and change the VM [network interface](../../../compute/concepts/network.md) properties in the section with the description of the `yandex_compute_instance` resource.

      ```hcl
      resource "yandex_compute_instance" "my-vm" {
      ...
        network_interface {
          ...
          security_group_ids = "<security_group_ID>"
          nat                = true
          ...
        }
      ...
      }
      ```

      Where:

      * `yandex_compute_instance`: VM description.
      * `network_interface`: VM network interface settings.
      * `security_group_ids`: List of security group IDs.
      * `nat`: Specifies if a VM will have an assigned public IP address.

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will change all required resources. You can check the resources’ update in the [management console]({{ link-console-main }}).

  For more information about `yandex_compute_instance` properties, see [this {{ TF }} article]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  To add a security group to the VM [network interface](../../../compute/concepts/network.md), use the [updateNetworkInterface](../../../compute/api-ref/Instance/updateNetworkInterface.md) REST API method for the [Instance](../../../compute/api-ref/Instance/index.md) resource or the [InstanceService/UpdateNetworkInterface](../../../compute/api-ref/grpc/Instance/updateNetworkInterface.md) gRPC API call.

  To assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to a VM, use the [addOneToOneNat](../../../compute/api-ref/Instance/addOneToOneNat.md) REST API method for the [Instance](../../../compute/api-ref/Instance/index.md) resource or the [InstanceService/AddOneToOneNat](../../../compute/api-ref/grpc/Instance/addOneToOneNat.md) gRPC API call.

{% endlist %}

For more information, see [{#T}](../../../compute/operations/vm-control/vm-change-security-groups-set.md) and [{#T}](../../../compute/operations/vm-control/vm-attach-public-ip.md).