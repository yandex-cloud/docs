# Updating a cloud network

After creating a cloud network, you can change its name, description, and labels.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you need to update a [cloud network](../concepts/network.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row of the subnet you need and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit as appropriate.
  1. Click **{{ ui-key.yacloud.vpc.subnetworks.update.button_update }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating [cloud network](../concepts/network.md) parameters:

      ```bash
      yc vpc network update --help
      ```

  1. Get a list of all networks in the default folder:

      ```bash
      yc vpc network list
      ```

      Result:
      ```text
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpavfmgapum******** | test-network-1 |
      | enplom7a98s1******** | default        |
      +----------------------+----------------+
      ```

  1. Select the `ID` or `NAME` of the network you need.
  1. Change the parameters of the cloud network by specifying its name:

      ```bash
      yc vpc network update enpavfmgapum******** --new-name test-network-renamed
      ```

      Result:
      ```text
      id: enpavfmgapum********
      folder_id: b1g6ci08ma55********
      created_at: "2018-10-23T14:05:32Z"
      name: test-network-renamed
      description: My first network
      labels:
        new_label: test_label
      ```
     
      You can provide the ID and name not only as positional arguments, but also using the `--id` and `--name` parameters:

      ```bash
      yc vpc network update \
        --id enpavfmgapum******** \
        --new-name test-network-renamed \
        --labels new_label=test_label
      ```

      ```bash
      yc vpc network update \
        --name test-network-1 \
        --new-name test-network-renamed \
        --labels new_label=test_label
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  1. Open the {{ TF }} configuration file and edit the fragment with the [cloud network](../concepts/network.md) description:

     ```hcl
     # Example of a cloud network description
     resource "yandex_vpc_network" "default" {
       name        = "network-1"
       description = "My first network"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
     ```

     For more information about `yandex_vpc_network` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/vpc_network).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the cloud network update using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

     ```bash
     yc vpc network get <network_name>
     ```

- API {#api}

  To update a [cloud network](../concepts/network.md), use the [update](../api-ref/Network/update.md) REST API method for the [Network](../api-ref/Network/index.md) resource or the [NetworkService/Update](../api-ref/grpc/Network/update.md) gRPC API call, and provide the following in the request:

  * ID of the cloud network you want to update, in the `networkId` parameter.

    {% include [get-network-id](../../_includes/vpc/get-network-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * New network settings, if required:

    * Name in the `name` parameter.
    * Description in the `description` parameter.
    * Network labels in the `labels` parameter.

  * List of settings to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Examples {#examples}

### Updating a cloud network using its name {#using-name}

You can update a cloud network using its name instead of its ID:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc network update test-network-1 \
    --new-name test-network-renamed \
    --labels new_label=test_label
  ```

  Result:
  ```text
  id: enpavfmgapum********
  folder_id: b1g6ci08ma55********
  created_at: "2018-10-23T14:05:32Z"
  name: test-network-renamed
  description: My first network
  labels:
    new_label: test_label
  ```

{% endlist %}
