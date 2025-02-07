---
title: Create a subnet
description: Follow this guide to create a subnet.
---

# Creating a subnet


[Subnets](../concepts/network.md#subnet) are created in cloud networks. A new subnet is located in one of the availability zones. Resources can be connected to a subnet if they reside in the same availability zone as the subnet itself.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a subnet.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. At the top right, click **{{ ui-key.yacloud.common.create }}**.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** field, specify the subnet name. The naming requirements are as follows:

     {% include [name-format](../../_includes/name-format.md) %}

  1. (Optional) In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_description }}** field, add a description.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** field, select an availability zone from the drop-down list.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** field, specify a cloud network. Make sure to create it in advance.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** field, enter the subnet IP address and mask. 
     For more information about subnet IP address ranges, see [Cloud networks and subnets](../concepts/network.md). 
     If you need to enter more CIDRs, click **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
  1. (Optional) Set **{{ ui-key.yacloud.vpc.subnetworks.create.section_dhcp-options }}**. To do this:
      1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_domain-name }}** field, specify a DNS domain to search for unqualified names.
      1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_domain-name-servers }}** field, click **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-domain-name-server }}** and enter the address of your DNS server. You can specify multiple DNS servers.
      1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_ntp-servers }}** field, click **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-ntp-server }}** and enter the address of your NTP server. You can specify multiple NTP servers.

  1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a subnet:

  1. See the description of the CLI command for creating a subnet:

      ```
      yc vpc subnet create --help
      ```

  1. Get a list of cloud networks in the required folder:

      ```
      yc vpc network list --folder-id b1g6ci08ma55********
      ```

      Result:

      ```
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpavfmgapum******** | test-network-1 |
      | enplom7a98s1******** | default        |
      +----------------------+----------------+
      ```

  1. Select `NAME` or `ID` of the cloud network you need. Create a subnet in the default folder:

      ```
      yc vpc subnet create \
        --name test-subnet-1 \
        --description "My test subnet" \
        --network-id enplom7a98s1******** \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      Where:

      * `--network-id`: Cloud network ID. You can also select a cloud network by specifying its name via the `--network-name` flag. Specify the name of the cloud network to create the subnet in and the CIDR.
      * `--zone`: Availability zone to create the subnet in. If this flag is not set, the subnet is created in the default availability zone.
      * `--range`: List of internal IPv4 addresses specified for this subnet. such as `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is /28, the maximum subnet size is /16. Only IPv4 is supported.

      The subnet naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

      ```
      yc vpc subnet create \
        --name test-subnet-1 \
        --description "My test subnet" \
        --network-name test-network-1 \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      The `--name` and `--description` flags are optional: you can create a subnet without any name or description and access it by ID.

  1. Get a list of all subnets in the default folder:

      ```
      yc vpc subnet list
      ```

      Result:

      ```
      +----------------------+-----------------------+------------------------+
      |          ID          |         NAME          | ... |       RANGE      |
      +----------------------+-----------------------+------------------------+
      ...
      | e2l0psbfoloe******** | test-subnet-1         | ... | [192.168.0.0/24] |
      ...
      +----------------------+-----------------------+-----+------------------+
      ```

      Get the same list with more details in YAML format:

      ```
      yc vpc subnet list --format yaml
      ```

      Result:
      
      ```
      ...

      - id: e2l0psbfoloe********
        folder_id: b1g6ci08ma55********
        created_at: "2018-10-24T12:25:58Z"
        name: test-subnet-1
        description: My test subnet
        network_id: enplom7a98s1********
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.0.0/24

      ...
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the subnet parameters:

     * `name`: Subnet name. The name should match the following format:

        {% include [name-format](../../_includes/name-format.md) %}

     * `description`: Subnet description.
     * `v4_cidr_blocks`: List of IPv4 addresses to deal with outgoing and incoming traffic. such as `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, the maximum subnet size is `/16`. Only IPv4 is supported.
     * `zone`: [Availability zone](../../overview/concepts/geo-scope.md).
     * `network_id`: ID of the network you are creating the subnet in.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_vpc_subnet" "lab-subnet-a" {
       name           = "<subnet_name>"
	   description    = "<subnet_description>"
       v4_cidr_blocks = ["<IPv4_address>"]
       zone           = "<availability_zone>"
       network_id     = "<network_ID>"
     }
     ```

     To add, update, or delete a subnet, use the `yandex_vpc_subnet` resource indicating the network in the `network_id` field (see an [example](#examples)).

     For more information about the `yandex_vpc_subnet` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/vpc_subnet).

  1. Make sure the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If the configuration is correct, the terminal will display a list of resources to create and their parameters. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or these [CLI](../../cli/quickstart.md) commands:

        ```
        yc vpc subnet list
        ```

- API {#api}

  To create a subnet, use the [create](../api-ref/Subnet/create.md) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Create](../api-ref/grpc/Subnet/create.md) gRPC API call, and provide the following in the request:

    * ID of the folder the subnet will reside in, in the `folderId` parameter.
    * ID of the network the subnet will be placed in, in the `networkId` parameter.
    * ID of the availability zone the subnet will be placed in, in the `zoneId` parameter.
    * List of internal IPv4 addresses specified for this subnet, in the `v4CidrBlocks[]` array. such as `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. The minimum subnet size is `/28`, the maximum subnet size is `/16`. Only IPv4 is supported.

  {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

## Examples {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

  Create a subnet with a name and description in the selected folder:

    ```
    yc vpc subnet create \
      --name test-subnet-1 \
      --description "My test subnet" \
      --folder-id b1g6ci08ma55******** \
      --network-id enplom7a98s1******** \
      --zone {{ region-id }}-a \
      --range 192.168.0.0/24
    ```

    Create a subnet with DHCP settings:
    ```
    yc vpc subnet create \
      --name test-subnet-1 \
      --description "My test subnet" \
      --folder-id b1g6ci08ma55******** \
      --network-id enplom7a98s1******** \
      --zone {{ region-id }}-a \
      --range 192.168.0.0/24 \
      --domain-name test.domain \
      --domain-name-server 192.168.0.100 \
      --ntp-server 192.168.0.101
    ```

- {{ TF }} {#tf}

  1. Describe the parameters of the `yandex_vpc_subnet` resource in the configuration file:

     ```hcl
     resource "yandex_vpc_network" "lab-net" {
       name        = "network-1"
       description = "My first network"
     }

     resource "yandex_vpc_subnet" "lab-subnet-a" {
       name           = "subnet-1"
       description    = "My first subnet"
       v4_cidr_blocks = ["10.2.0.0/16"]
       zone           = "{{ region-id }}-a"
       network_id     = "${yandex_vpc_network.lab-net.id}"
     }
     ```

     For more information about resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/vpc_subnet).

  1. Make sure the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If the configuration is correct, the terminal will display a list of resources to create and their parameters. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or these [CLI](../../cli/quickstart.md) commands:

        ```
        yc vpc subnet list
        ```

{% endlist %}
