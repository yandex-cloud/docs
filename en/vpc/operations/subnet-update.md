# Updating a subnet

After creating a [subnet](../concepts/network.md#subnet), you can change its name, description, and DHCP settings.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), change to the folder where you need to update a subnet.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the subnet you need and select **{{ ui-key.yacloud.common.edit }}**.
   1. Configure as appropriate.
   1. Click **{{ ui-key.yacloud.vpc.subnetworks.update.button_update }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI command for updating subnet parameters:

      ```
      yc vpc subnet update --help
      ```

   1. Get a list of all subnets in the default folder:

      ```
      yc vpc subnet list
      ```

      Result:

      ```
      +----------------------+-----------------------+----------------------+
      |          ID          |         NAME          |         ...          |
      +----------------------+-----------------------+----------------------+
      ...
      | e2l2prrbkbim******** |     test-subnet-1     |         ...          |
      ...
      +----------------------+-----------------------+----------------------+
      ```

   1. Select the `ID` or `NAME` of the subnet.
   1. Change the subnet parameters, for example:

      ```
      yc vpc subnet update e2l2prrbkbim******** \
        --new-name test-subnet-renamed \
        --labels new_label=test_label
      ```

      Result:

      ```
      id: e2l2prrbkbim********
      folder_id: b1g6ci08ma55********
      created_at: "2018-10-24T13:54:10Z"
      name: test-subnet-renamed
      description: My test subnet
      labels:
        new_label: test_label
      network_id: enplom7a98s1********
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
      - 192.168.0.0/24
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   1. Open the {{ TF }} configuration file and edit the fragment with the subnet description:

      ```hcl
      ...
      resource "yandex_vpc_subnet" "lab-subnet-a" {
        name           = "subnet-1"
        description    = "My first subnet"
        v4_cidr_blocks = ["10.2.0.0/16"]
        zone           = "{{ region-id }}-a"
        network_id     = "${yandex_vpc_network.lab-net.id}"
      }
      ...
      ```

      For more information about the parameters of the `yandex_vpc_subnet` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_subnet).

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the subnet update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```
      yc vpc subnet get <subnet_name>
      ```

- API {#api}

   To change the [subnet](../concepts/network.md#subnet), use the [update](../api-ref/Subnet/update.md) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Update](../api-ref/grpc/Subnet/update.md) gRPC API call, and provide the following in the request:

   * ID of the subnet to be changed, in the `subnetId` parameter.

      {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

      {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

   * New subnet settings if needed:

      * Name, in the `name` parameter.
      * Description, in the `description` parameter.
      * Network labels, in the `labels` parameter.
      * Route table ID, in the `routeTableId` parameter.
      * DHCP options, in the `dhcpOptions` parameter.

   * List of settings to update, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Examples {#examples}

### Changing a subnet using the name flag {#using-name-flag}

{% list tabs group=instructions %}

- CLI {#cli}

   You can change a subnet by using its name instead of its ID:

   ```
   yc vpc subnet update test-subnet-1 \
     --new-name test-subnet-renamed \
     --labels new_label=test_label
   ```

   Result:

   ```
   id: e2l2prrbkbim********
   folder_id: b1g6ci08ma55********
   created_at: "2018-10-24T13:54:10Z"
   name: test-subnet-renamed
   description: My test subnet
   labels:
     new_label: test_label
   network_id: enplom7a98s1********
   zone_id: {{ region-id }}-a
   v4_cidr_blocks:
   - 192.168.0.0/24
   ```

   You can provide the subnet ID and name not only as positional arguments but also using the `--id` and `--name` flags:

   ```
   yc vpc network update \
     --id enpavfmgapum******** \
     --new-name test-network-renamed \
     --labels new_label=test_label
   ```

   ```
   yc vpc network update \
     --name test-network-1 \
     --new-name test-network-renamed \
     --labels new_label=test_label
   ```

{% endlist %}
