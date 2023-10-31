# Enable protection from DDoS attacks

DDoS protection activates when a virtual machine is [created](../../compute/quickstart/quick-create-linux) and public IPs are [reserved](get-static-ip.md).

Protected addresses are allocated from a separate pool; therefore, you cannot enable and disable protection for a previously reserved address.

## Enabling DDoS protection when creating a virtual machine {#enable-on-vm-creation}
{% list tabs %}

- Management console

   When configuring the network on a new virtual machine, select the automatically assigned public IP address or select an address from the list of reserved addresses.

   Once you select an address, select the **{{ ui-key.yacloud.component.compute.network-select.field_ddos-protection-provider }}** option.

{% endlist %}

## Enabling DDoS protection when reserving IP addresses {#enable-on-reservation}

{% list tabs %}

- Management console

   To reserve a protected static IP address:

   1. In the [management console]({{ link-console-main }}), change to the folder where you need to reserve an address.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Click **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
   1. Select the availability zone where you want to reserve the address.
   1. Select **{{ ui-key.yacloud.vpc.addresses.popup-create_field_ddos-protection-provider }}**.
   1. Click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

- {{ TF }}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   1. Open the {{ TF }} configuration file and edit the fragment with the static public IP description by adding the `ddos_protection_provider` field:

      ```hcl
      resource "yandex_vpc_address" "addr" {
        name = "exampleAddress"
        external_ipv4_address {
          zone_id                  = "{{ region-id }}-a"
          ddos_protection_provider = "qrator"
        }
      }
      ```

      Where `ddos_protection_provider` is a parameter that enables DDoS protection. Available values: `qrator`.

      For more information about the `yandex_vpc_address` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_address).

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check if DDoS protection is active in the [management console]({{ link-console-main }}) or with the following [CLI](../../cli/quickstart.md) command:

      ```
      yc vpc address list
      ```

{% endlist %}
