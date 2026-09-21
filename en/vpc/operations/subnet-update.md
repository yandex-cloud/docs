---
title: Updating a subnet
description: Follow this guide to update a subnet.
---

# Updating a subnet

After creating a [subnet](../concepts/network.md#subnet), you can update its name, description, and DHCP settings.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the subnet you want to update.
  1. [Navigate]({{ link-console-main }}/link/vpc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. In the subnet row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit as appropriate.
  1. Click **{{ ui-key.yacloud.vpc.subnetworks.update.button_update }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating subnet settings:

      ```bash
      yc vpc subnet update --help
      ```

  1. Get a list of all subnets in the default folder:

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```text
      +----------------------+-----------------------+----------------------+
      |          ID          |         NAME          |         ...          |
      +----------------------+-----------------------+----------------------+
      ...
      | e2l2prrbkbim******** |     test-subnet-1     |         ...          |
      ...
      +----------------------+-----------------------+----------------------+
      ```

  1. Select the `ID` or `NAME` of the subnet you need.
  1. Change the subnet parameters, e.g.:

      ```bash
      yc vpc subnet update e2l2prrbkbim******** \
        --new-name test-subnet-renamed \
        --labels new_label=test_label
      ```

      Result:

      ```text
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
	     network_id     = yandex_vpc_network.lab-net.id
     }
     ...
     ```

     For more on the properties of the `yandex_vpc_subnet` resource in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/vpc_subnet).

  1. Apply the configuration:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the subnet update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc vpc subnet get <subnet_name>
     ```

- API {#api}

  To change the [subnet](../concepts/network.md#subnet), use the [update](../api-ref/Subnet/update.md) REST API method for the [Subnet](../api-ref/Subnet/index.md) resource or the [SubnetService/Update](../api-ref/grpc/Subnet/update.md) gRPC API call, and provide the following in the request:

  * ID of the subnet you want to update in the `subnetId` request parameter.

    {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * New subnet settings if needed:

    * Name in the `name` parameter.
    * Description in the `description` parameter.
    * Network labels in the `labels` parameter.
    * Route table ID in the `routeTableId` parameter.
    * DHCP settings in the `dhcpOptions` parameter.

  * List of settings to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Examples {#examples}

### Updating a subnet using its name parameter {#using-name-flag}

{% list tabs group=instructions %}

- CLI {#cli}

  You can change a subnet by using its name instead of its ID:

  ```bash
  yc vpc subnet update test-subnet-1 \
    --new-name test-subnet-renamed \
    --labels new_label=test_label
  ```

  Result:

  ```text
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

  You can provide the subnet ID and name not only as positional arguments, but also using the `--id` and `--name` parameters:

  ```bash
  yc vpc subnet update \
    --id e2l2prrbkbim******** \
    --new-name test-subnet-renamed \
    --labels new_label=test_label
  ```

  ```bash
  yc vpc subnet update \
    --name test-subnet-1 \
    --new-name test-subnet-renamed \
    --labels new_label=test_label
  ```

{% endlist %}

