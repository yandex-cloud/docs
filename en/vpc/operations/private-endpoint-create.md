---
title: How to create a service connection in {{ vpc-full-name }}
description: Follow this guide to create a service connection (private endpoint) in {{ vpc-name }}.
---

# Creating a service connection

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}


{% include [private-endpoint-create-roles](../../_includes/vpc/private-endpoint-create-roles.md) %}

To create a [service connection](../concepts/private-endpoint.md):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [private-endpoint-create-cli](../../_includes/vpc/private-endpoint-create-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, describe the resources you want to create:

     ```hcl
     resource "yandex_vpc_private_endpoint" "my-vpc-endpoint" {
       name        = "<service_connection_name>"
       description = "<service_connection_description>"
       network_id  = "<cloud_network_ID>"
       
       # Service connection to Object Storage
       object_storage {}

       # Creating additional DNS resource records 
       dns_options {
         private_dns_records_enabled = <true_or_false>
       }

       endpoint_address {
         subnet_id = "<subnet_ID>"
       }
     }
     ```

     Where:
     * `name`: Service connection name. This is an optional parameter.
     * `description`: Service connection description. This is an optional parameter.
     * `network_id`: Name of the [cloud network](../../vpc/concepts/network.md#network) the service connection will be created in. This is a required parameter.
     * `object_storage`: Service connection to {{ objstorage-short-name }}. Other service connection types are not available yet.
     * `dns_options`: Section with parameters for creating DNS records:
         * `private_dns_records_enabled`: Parameter to create additional DNS resource records to override the public FQDN of the service to which the connection is created. This is an optional parameter.

             {% include [private-endpoint-create-dns](../../_includes/vpc/private-endpoint-create-dns.md) %}

     * `endpoint_address`: Section with parameters of the service connection's internal IP address:
         * `subnet_id`: ID of the subnet to provide an IP address for the service connection. If no subnet ID is provided, a random internal IP address will be assigned from the range of one of the subnets in the cloud network. This is an optional parameter.

        {% note info %}

        To create a service connection, you should have at least one subnet in your network.

        {% endnote %}

     For more information about `yandex_vpc_private_endpoint` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/vpc_private_endpoint).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc vpc private-endpoint list
     ```

- API {#api}

  To create a [service connection](../concepts/private-endpoint.md), use the [create](../privatelink/api-ref/PrivateEndpoint/create.md) REST API method for the [PrivateEndpoint](../privatelink/api-ref/PrivateEndpoint/index.md) resource or the [PrivateEndpointService/Create](../privatelink/api-ref/grpc/PrivateEndpoint/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](private-endpoint-get-info.md)
* [{#T}](private-endpoint-delete.md)
