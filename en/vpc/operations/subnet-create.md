# Creating a subnet

[Subnets](../concepts/network.md#subnet) are created in cloud networks. A new subnet is located in one of the availability zones. Resources can be connected to a subnet if they reside in the same availability zone as the subnet itself.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a subnet.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![subnets](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. At the top right, click **{{ ui-key.yacloud.common.create }}**.
   1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** field, specify the subnet name. Naming requirements:

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

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a subnet:

   1. See the description of the CLI command for creating a subnet:

      ```
      yc vpc subnet create --help
      ```

   1. Get a list of cloud networks in the required folder:

      ```
      yc vpc network list --folder-id b1g6ci08ma55klukmdjs
      ```

      Result:

      ```
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpavfmgapumnl7cqin8 | test-network-1 |
      | enplom7a98s1t0lhass8 | default        |
      +----------------------+----------------+
      ```

   1. Select the `NAME` or `ID` of the cloud network you need. Create a subnet in the default folder:

      ```
      yc vpc subnet create \
        --name test-subnet-1 \
        --description "My test subnet" \
        --network-id enplom7a98s1t0lhass8 \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      Where:

      * `--network-id` is the cloud network ID. You can also select a cloud network by specifying its name via the `--network-name` flag. Specify the name of the cloud network to create the subnet in and the CIDR.
      * `--zone` is the availability zone where the subnet is created. If this flag is omitted, the subnet is created in the default availability zone.

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
      | e2l0psbfoloefpjb1rau | test-subnet-1         | ... | [192.168.0.0/24] |
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

      - id: e2l0psbfoloefpjb1rau
        folder_id: b1g6ci08ma55klukmdjs
        created_at: "2018-10-24T12:25:58Z"
        name: test-subnet-1
        description: My test subnet
        network_id: enplom7a98s1t0lhass8
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.0.0/24

      ...
      ```

- API

   To create a subnet, use the [create](../api-ref/Subnet/create.md) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Create](../api-ref/grpc/subnet_service.md#Create) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the subnet parameters:

      * `name`: Name of the subnet. The naming requirements are as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `description`: Description of the subnet.
      * `v4_cidr_blocks`: List of IPv4 addresses to send traffic from or to. For example, `10.0.0.0/22` or `192.168.0.0/16`. Make sure the addresses are unique within the network. Minimum subnet size is /28, maximum subnet size is /16. Only IPv4 is supported.
      * `zone`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `network_id`: ID of the network where the subnet is created.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_vpc_subnet" "lab-subnet-a" {
        name           = "<subnet name>"
        description    = "<subnet description>"
        v4_cidr_blocks = ["<IPv4 address>"]
        zone           = "<availability zone>"
        network_id     = "<network ID>"
      }
      ```

      To add, update, or delete a subnet, use the `yandex_vpc_subnet` resource with the network specified in the `network_id` field (see an [example](#examples)).

      For more information about the parameters of the `yandex_vpc_subnet` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_subnet).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is specified correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

         ```
         yc vpc subnet list
         ```

{% endlist %}

## Examples {#examples}

{% list tabs %}

- CLI

   Create a subnet with a name and description in the selected folder:

   ```
   yc vpc subnet create \
     --name test-subnet-1 \
     --description "My test subnet" \
     --folder-id b1g6ci08ma55klukmdjs \
     --network-id enplom7a98s1t0lhass8 \
     --zone {{ region-id }}-a \
     --range 192.168.0.0/24
   ```

   Create a subnet with DHCP settings:
   ```
   yc vpc subnet create \
     --name test-subnet-1 \
     --description "My test subnet" \
     --folder-id b1g6ci08ma55klukmdjs \
     --network-id enplom7a98s1t0lhass8 \
     --zone {{ region-id }}-a \
     --range 192.168.0.0/24 \
     --domain-name test.domain \
     --domain-name-server 192.168.0.100 \
     --ntp-server 192.168.0.101
   ```

- {{ TF }}

   1. Describe the properties of the `yandex_vpc_subnet` resource in a configuration file:

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

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_subnet).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is specified correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

         ```
         yc vpc subnet list
         ```

{% endlist %}
