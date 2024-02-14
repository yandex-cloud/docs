# Viewing a list of addresses used in a subnet

You can view internal IP addresses that are assigned to cloud resources in your folder.

To view a list of internal addresses used in a subnet:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder with the subnet.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Click the subnet name.
   1. Go to the **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}** tab.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get a list of used addresses:

      ```bash
      yc vpc subnet list-used-addresses --help
      ```

   1. Get a list of addresses in the selected subnet:

      ```bash
      yc vpc subnet list-used-addresses --name <subnet_name>
      ```

      Result:

      ```bash
      +-----------+------------+---------------------------------------+
      |  ADDRESS  | IP VERSION |              REFERENCES               |
      +-----------+------------+---------------------------------------+
      | 10.1.2.1  | IPV4       | vpc.virtualGateway:                   |
      | 10.1.2.2  | IPV4       | vpc.virtualDns:                       |
      | 10.1.2.3  | IPV4       | compute.instance:epdf6lfsaki9******** |
      | 10.1.2.15 | IPV4       | compute.instance:epdb2hmhj935******** |
      | 10.1.2.28 | IPV4       | managedKubernetes.cluster:            |
      +-----------+------------+---------------------------------------+
      ```

- API {#api}

   Use the [listUsedAddresses](../api-ref/Subnet/listUsedAddresses) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/ListUsedAddresses](../api-ref/grpc/subnet_service.md#ListUsedAddresses) gRPC API call and provide the ID of the subnet you want to change in the `subnetId` request parameter.

   {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

   {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}
