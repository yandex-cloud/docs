# Updating a cloud network

After creating a cloud network, you can change its name, description, and labels.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating cloud network parameters:

      ```
      yc vpc network update --help
      ```

  1. Get a list of all networks in the default folder:

      ```
      yc vpc network list
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

  1. Select the `ID` or `NAME` of the network you need.
  1. Change the parameters of the cloud network by specifying its name:

      ```
      yc vpc network update enpavfmgapum******** --new-name test-network-renamed
      ```

      Result:
      ```
      id: enpavfmgapum********
      folder_id: b1g6ci08ma55********
      created_at: "2018-10-23T14:05:32Z"
      name: test-network-renamed
      description: My first network
      labels:
        new_label: test_label
      ```
     
      You can provide the ID and name not only as positional arguments but also using the `--id` and `--name` flags:

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

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  1. Open the {{ TF }} configuration file and edit the fragment with the cloud network description:

     ```hcl
     ...
     resource "yandex_vpc_network" "default" {
       name        = "network-1"
	   description = "My first network"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
     ...
     ```

     For more information about the `yandex_vpc_network` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_network).

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
  
     The terminal will display a list of resources with their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:

     ```
     terraform apply
     ```
     
  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the cloud network update using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

     ```
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

  ```
  yc vpc network update test-network-1 \
    --new-name test-network-renamed \
    --labels new_label=test_label
  ```

  Result:
  ```
  id: enpavfmgapum********
  folder_id: b1g6ci08ma55********
  created_at: "2018-10-23T14:05:32Z"
  name: test-network-renamed
  description: My first network
  labels:
    new_label: test_label
  ```

{% endlist %}
