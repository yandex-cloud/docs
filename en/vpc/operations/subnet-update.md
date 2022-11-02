# Updating a subnet

After creating a subnet, you can change its name, description, and DCHP settings.

{% list tabs %}

- Management console

   To update a [subnet](../concepts/network.md#subnet):
   1. In the [management console]({{ link-console-main }}), change to the folder where you need to update a subnet.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click on the name of the subnet's cloud network.
   1. Click ![image](../../_assets/options.svg) in the line of the subnet to edit.
   1. In the menu that opens, click **Edit**.
   1. Configure as appropriate.
   1. Click **Save changes**.

- CLI

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
      | e2l2prrbkbimvjuuhht2 |     test-subnet-1     |         ...          |
      ...
      +----------------------+-----------------------+----------------------+
      ```

   1. Select the `ID` or `NAME` of the subnet.
   1. Change the subnet parameters, for example:

      ```
      yc vpc subnet update e2l2prrbkbimvjuuhht2 \
          --new-name test-subnet-renamed \
          --labels new_label=test_label
      ```

      Result:

      ```
      id: e2l2prrbkbimvjuuhht2
      folder_id: b1g6ci08ma55klukmdjs
      created_at: "2018-10-24T13:54:10Z"
      name: test-subnet-renamed
      description: My test subnet
      labels:
        new_label: test_label
      network_id: enplom7a98s1t0lhass8
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
      - 192.168.0.0/24
      ```

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

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

      For more information about the parameters of the `yandex_vpc_subnet` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/vpc_subnet).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the subnet using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```
      yc vpc subnet get <subnet name>
      ```

## Examples {#examples}

### Changing a subnet using the name flag {#using-name-flag}

You can change a subnet by using its name instead of its ID:

```
yc vpc subnet update test-subnet-1 \
    --new-name test-subnet-renamed \
    --labels new_label=test_label
```

Result:

```
id: e2l2prrbkbimvjuuhht2
folder_id: b1g6ci08ma55klukmdjs
created_at: "2018-10-24T13:54:10Z"
name: test-subnet-renamed
description: My test subnet
labels:
  new_label: test_label
network_id: enplom7a98s1t0lhass8
zone_id: {{ region-id }}-a
v4_cidr_blocks:
- 192.168.0.0/24
```

You can pass the subnet ID and name as positional arguments, or you can use the `--id` and `--name` flags:

```
yc vpc network update --id enpavfmgapumnl7cqin8 \
--new-name test-network-renamed \
--labels new_label=test_label
```
```
yc vpc network update --name test-network-1 \
--new-name test-network-renamed \
--labels new_label=test_label
```
{% endlist %}
