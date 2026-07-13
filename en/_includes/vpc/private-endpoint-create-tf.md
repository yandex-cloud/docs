{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

{% include [terraform-install](../../_includes/terraform-install.md) %}

1. In the {{ TF }} configuration file, describe the resources you want to create:

   ```hcl
   resource "yandex_vpc_private_endpoint" "my-vpc-endpoint" {
     name        = "<service_connection_name>"
     description = "<service_connection_description>"
     network_id  = "<cloud_network_ID>"
     service_type = "yandex.cloud.storage"

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
   * `service_type`: [Service connection type](../../vpc/concepts/private-endpoint.md#pe-services). In our example, it is `yandex.cloud.storage` for {{ objstorage-short-name }}.
   * `dns_options`: Section with parameters for creating DNS records:
       * `private_dns_records_enabled`: Parameter to create additional DNS resource records to override the public FQDN of the service to which the connection is created. This is an optional parameter.

           {% include [private-endpoint-create-dns](../../_includes/vpc/private-endpoint-create-dns.md) %}

   * `endpoint_address`: Section with parameters of the service connection's internal IP address:
       * `subnet_id`: ID of the subnet to provide an IP address for the service connection. If no subnet ID is provided, a random internal IP address will be assigned from the range of one of the cloud network's subnets. This is an optional parameter.

      {% note info %}

      To create a service connection, you should have at least one subnet in your network.

      {% endnote %}

   For more on the properties of the `yandex_vpc_private_endpoint` resource, see [this provider guide]({{ tf-provider-resources-link }}/vpc_private_endpoint).

1. Create the resources:

   {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

   ```bash
   yc vpc private-endpoint list
   ```