---
title: How to delete a service connection in {{ vpc-full-name }}
description: Follow this guide to delete a service connection (private endpoint) in {{ vpc-name }}.
---

# Deleting a service connection

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}



{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. View the description of the CLI command for deleting a [service connection](../concepts/private-endpoint.md) (private endpoint):

      ```bash
      yc vpc private-endpoint delete --help
      ```

  1. Get a list of all service connections:

     ```bash
     yc vpc private-endpoint list
     ```

     Result:
     
     ```text
     +----------------------+-------------+--------------------------------+
     |          ID          |    NAME     |          DESCRIPTION           |
     +----------------------+-------------+--------------------------------+
     | enpd7rq************* | s3-vpc-link | Private Endpoint to the Object |
     |                      |             | Storage                        |
     +----------------------+-------------+--------------------------------+
     ``` 

  1. Select the `ID` or `NAME` of the service connection.
  1. Delete the service connection:

     ```bash
     yc vpc private-endpoint delete <connection_ID>
     ```


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a [service connection](../concepts/private-endpoint.md) created with {{ TF }}:
  1. Open the {{ TF }} configuration file and delete the section describing the `yandex_vpc_private_endpoint` resource:

     ```hcl
     resource "yandex_vpc_private_endpoint" "vpc-endpoint" {
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

  {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the updates in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

  ```bash
  yc vpc private-endpoint list
  ```

- API {#api}

  To delete a [service connection](../concepts/private-endpoint.md), use the [delete](../privatelink/api-ref/PrivateEndpoint/delete.md) REST API method for the [PrivateEndpoint](../privatelink/api-ref/PrivateEndpoint/index.md) resource or the [PrivateEndpointService/Delete](../privatelink/api-ref/grpc/PrivateEndpoint/delete.md) gRPC API call.



{% endlist %}
