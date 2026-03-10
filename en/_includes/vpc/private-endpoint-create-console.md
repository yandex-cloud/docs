1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to set up a service connection.
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.vpc.switch_private-endpoints }}**.
1. Click **{{ ui-key.yacloud.vpc.private-endpoint.label_create-private-endpoint }}**.
1. In the **{{ ui-key.yacloud.vpc.private-endpoint.field_name }}** field, enter a name for the service connection. Make sure to follow these naming requirements:

     {% include [name-format](../../_includes/name-format.md) %}

1. Optionally, in the **{{ ui-key.yacloud.vpc.private-endpoint.field_description }}** field, add a description.
1. Optionally, add [labels](../../storage/concepts/tags.md):

   1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
   1. Enter a label in `key: value` format.
   1. Press **Enter**.

1. Under **{{ ui-key.yacloud.vpc.private-endpoint.label_network-section }}**:

   1. In the **{{ ui-key.yacloud.vpc.private-endpoint.field_network }}** field, specify a network for the new service connection.
   1. To assign a random private IP address, select `{{ ui-key.yacloud.vpc.private-endpoint.label_address-type_auto }}` in the **{{ ui-key.yacloud.vpc.private-endpoint.field_address-type }}** field.
   1. To reserve a list of IP addresses:
   
      1. In the **{{ ui-key.yacloud.vpc.private-endpoint.field_address-id }}** field, select `{{ ui-key.yacloud.vpc.private-endpoint.label_address-type_list }}`.
      1. Click **Reserve**.
      1. In the window that opens:

         * Specify a name and description for the IP address.
         * Select a [subnet](../../vpc/concepts/network.md#subnet).
         * Assign an internal IPv4 address, e.g., `172.16.0.3`.
         * Enable **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}** for the address to be immune from deletion until you disable protection.
         * Add labels.
         * Click **{{ ui-key.yacloud.common.create }}**.
         * Repeat these steps to reserve additional IP addresses.

   1. In the **{{ ui-key.yacloud.vpc.private-endpoint.field_service }}** field, select **{{ ui-key.yacloud.vpc.private-endpoint.label_endpoint-service_object-storage }}**.
   1. Optionally, enable **{{ ui-key.yacloud.vpc.private-endpoint.label_dns-field-text }}** to automatically create an additional DNS A record for the service's public [FQDN](../../vpc/concepts/address.md#fqdn). The record will contain the internal IP address allocated to the service connection.

      {% include [private-endpoint-create-dns](private-endpoint-create-dns.md) %}

1. Click **{{ ui-key.yacloud.common.create }}**.