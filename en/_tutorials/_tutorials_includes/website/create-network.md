Create a [cloud network](../../../vpc/concepts/network.md) and [subnets](../../../vpc/concepts/network.md#subnet) to deploy your resources in.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to deploy your infrastructure.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter a name for the network. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Keep **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** enabled.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create a cloud network in the default folder:

      ```
      yc vpc network create --name wordpress-network
      ```

  1. Get the list of the cloud networks in the folder:

      ```
      yc vpc network list --folder-id b1g6ci08ma55********
      ```

      Result:

      ```
      +----------------------+-------------------+
      |          ID          |      NAME         |
      +----------------------+-------------------+
      | enpavfmgapum******** | wordpress-network |
      | enplom7a98s1******** | default           |
      +----------------------+-------------------+
      ```

  1. Select `NAME` or `ID` of the cloud network you need. Create a subnet in the `{{ region-id }}-a` availability zone:

      ```
      yc vpc subnet create \
        --network-id enpavfmgapum******** \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      Where:

      * `--network-id`: Cloud network ID. When creating a subnet, specify the cloud network for the subnet and CIDR.
      * `--zone`: Subnet availability zone.
      * `--range`: List of internal IPv4 addresses specified for this subnet, such as `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is /28, and the maximum subnet size is /16. Only IPv4 is supported.

      The subnet naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Similarly, create a subnet in the `{{ region-id }}-d` availability zone.

- API {#api}

  To create a cloud network, use the [create](../../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md) gRPC API call and provide the ID of the folder to host the new network in the `folderId` parameter of your request:

  {% include [get-catalog-id](../../../_includes/get-catalog-id.md) %}

  To create subnets in the `{{ region-id }}-a` and `{{ region-id }}-d` availability zones, use the [create](../../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call, and provide the following in your request:

  * ID of the folder the subnet will reside in, in the `folderId` parameter.
  * ID of the network the subnet will be placed in, in the `networkId` parameter.
  * ID of the availability zone the subnet will be placed in, in the `zoneId` parameter.
  * List of internal IPv4 addresses specified for this subnet, in the `v4CidrBlocks[]` array, e.g., `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, while the maximum subnet size is `/16`. Only IPv4 is supported.

  {% include [get-subnet-id](../../../_includes/vpc/get-subnet-id.md) %}

{% endlist %}