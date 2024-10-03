---
title: How to get information about an IP address in {{ vpc-full-name }}
---

# Getting information about an IP address

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your [address](../concepts/address.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. The page that will open will display detailed information about all available addresses.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../cli/) command to get information about an [address](../concepts/address.md):

      ```bash
      yc vpc address get --help
      ```

   1. Get information about your address by specifying its name or ID:

      ```bash
      yc vpc address get <address_name>
      ```

      Result:

      ```text
      id: e2lot532vpte********
      folder_id: b1go3el0d8fs********
      created_at: "2024-03-05T09:53:21Z"
      external_ipv4_address:
        address: 84.201.***.***
        zone_id: ru-central1-b
        requirements: {}
      used: true
      type: EXTERNAL
      ip_version: IPV4
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To get information about an [address](../concepts/address.md) using {{ TF }}:
   1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_vpc_address" "my_addr" {
        address_id = "<address_name>"
      }

      output "addr" {
        value = data.yandex_vpc_address.my_addr.external_ipv4_address
      }
      ```

      Where:
      * `data "yandex_vpc_address"`: Description of the address as a data source:
         * `address_id`: Address name or ID.
      * `output "addr"`: Output variable that contains information about the IP address:
         * `value`: Returned value.

      You can replace `external_ipv4_address` with any other parameter to get the information you need. For more information about the `yandex_vpc_address` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_vpc_address).
   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

      ```bash
      terraform output
      ```

      Result:

      ```text
      addr = tolist([
      {
          "address" = "84.201.***.***"
          "ddos_protection_provider" = ""
          "outgoing_smtp_capability" = ""
          "zone_id" = "ru-central1-b"
      },
      ])
      ```

- API {#api}

   To get detailed information about an [address](../concepts/address.md), use the [get](../api-ref/Address/get.md) REST API method for the [Address](../api-ref/Address/index.md) resource or the [AddressService/Get](../api-ref/grpc/address_service.md#Get) gRPC API call.

{% endlist %}
