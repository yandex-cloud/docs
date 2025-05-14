---
title: How to get information about a service connection in {{ vpc-full-name }}
description: Follow this guide to get information about a service connection (private endpoint) in {{ vpc-name }}.
---

# Getting information about a service connection

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}



{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. View the description of the CLI command for getting information about a service connection (private endpoint):

      ```bash
      yc vpc private-endpoint get --help
      ```

  1. Get information about a service connection by specifying its name or ID:

     ```bash
     yc vpc private-endpoint get <service_connection_ID>
     ```

     Result:
     ```text
     id: enpd7***************
     folder_id: b1g23***************
     created_at: "2024-08-31T16:23:33.859574Z"
     name: s3-vpc-link
     description: Private Endpoint to the Object Storage
     network_id: enpgi***************
     status: AVAILABLE
     address:
       subnet_id: e2l8b***************
       address: 10.128.0.10
       address_id: e2ldn***************
     dns_options: {}
     object_storage: {}
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about a [service connection](../concepts/private-endpoint.md) through {{ TF }}:

  1. Add the `data` and `output` sections to the Terraform configuration file:

      ```hcl
      data "yandex_vpc_private_endpoint" "my-vpc-data" {
        private_endpoint_id = "<service_connection_ID>"
      }

      output "endpoint-info-network" {
        value = data.yandex_vpc_private_endpoint.my-vpc-info.network_id
      }
      ```

      Where:

      * `data "yandex_vpc_private_endpoint"`: Description of the service connection as a data source:
         * `resource_id`: Service connection ID.
      * `output "ref_description"`: Output variable storing the service connection's network ID (`network_id`):
         * `value`: Returned value.

     You can replace `network_id` with another variable to get the information you need. For more information about the `yandex_vpc_private_endpoint` data source variables, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/vpc_private_endpoint).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      endpoint-info-network = "enpt232s2lp6********"
      ```

- API {#api}

  To get information about a [service connection](../concepts/private-endpoint.md), use the [get](../privatelink/api-ref/PrivateEndpoint/get.md) REST API method for the [PrivateEndpoint](../privatelink/api-ref/PrivateEndpoint/index.md) resource or the [PrivateEndpointService/Get](../privatelink/api-ref/grpc/PrivateEndpoint/get.md) gRPC API call.

{% endlist %}
