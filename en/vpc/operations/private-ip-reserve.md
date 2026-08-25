---
title: Reserving an internal IP address
description: Follow this guide to reserve an internal IP address.
---

# Reserving an internal IP address

You can reserve an [internal IP address](../concepts/address.md#internal-addresses) and use it for data transfer between cloud resources.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to reserve an IP address.
   1. [Navigate]({{ link-console-main }}/link/vpc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Select the subnet where you want to reserve the address.
   1. Navigate to the ![addresses](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}** tab.
   1. Click **{{ ui-key.yacloud.vpc.Subnetwork.SubnetUsedAddressesList.button_create_sPV4s }}**.  
   1. In the window that opens:
       * Enter a name and description for the internal address.
       * In the **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** field, enter the address you would like to reserve.
       * Optionally, enable **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**.
       * Optionally, specify [labels](../../resource-manager/concepts/labels.md).
   1. Click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command for reserving an address:

      ```bash
      yc vpc address create --help
      ```

   1. Reserve an internal IP address by specifying the subnet ID:

      ```bash
      yc vpc address create \
        --name <address_name> \
        --internal-ipv4 subnet=<subnet_ID>,address=<IP_address>
      ```

      Where:

      * `--name`: Internal IP address name.
      * `--internal-ipv4`: Internal IPv4 address description:
        * `subnet`: ID of the subnet the address is reserved in.
        * `address`: Specific IP address to reserve. If not specified, the address will be assigned automatically.

      To protect the address from deletion, add the `--deletion-protection` flag.

      Result:

      ```text
      id: e9b6un9gkso6********
      folder_id: b1g7gvsi89m3********
      created_at: "2024-05-08T07:55:49Z"
      name: my-internal-address
      internal_ipv4_address:
        address: 192.168.0.10
        subnet_id: e2lghukd9iqo********
      reserved: true
      type: INTERNAL
      ip_version: IPV4
      ```

      The internal IP address has been reserved.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, specify the properties of the resources you want to create:

     * `name`: Internal IP address name. The name format is as follows:

          {% include [name-format](../../_includes/name-format.md) %}

     * `folder_id`: Folder ID.
     * `internal_ipv4_address`: Internal IPv4 address description:
        * `subnet_id`: ID of the subnet the address is reserved in.
        * `address` (optional): Specific IP address to reserve. If not specified, the address will be assigned automatically.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_vpc_address" "internal_addr" {
       name = "<address_name>"
       folder_id = "<folder_ID>"
       internal_ipv4_address {
         subnet_id = "<subnet_ID>"
       }
     }
     ```

     For more information about `yandex_vpc_address` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/vpc_address).

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     This will create all the resources you need in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc vpc address list
     ```

- API {#api}

  To reserve an internal IP address, use the [create](../api-ref/Address/create.md) REST API method for the [Address](../api-ref/Address/index.md) resource or the [AddressService/Create](../api-ref/grpc/Address/create.md) gRPC API call, and provide in the request the `internalIpv4AddressSpec` parameter for the REST API or `internal_ipv4_address_spec` for the gRPC API with the following fields:

    * ID of the folder for the address in the `folderId` field for the REST API or `folder_id` for the gRPC API.
    * Internal IP address name in the `name` field. The name format is as follows:

      {% include [name-format](../../_includes/name-format.md) %}

    * Subnet ID in the `subnetId` field for the REST API or `subnet_id` for the gRPC API.
    * Optionally, specific IP address to reserve in the `address` field. If not specified, the address will be assigned automatically.

  To protect the address from deletion, provide in the request the `deletionProtection` parameter for the REST API or `deletion_protection` for the gRPC API, set to `true`.

{% endlist %}

