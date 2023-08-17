# Updating a cloud network

After creating a cloud network, you can change its name, description, and tags.

{% list tabs %}

- CLI

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
      | enpavfmgapumnl7cqin8 | test-network-1 |
      | enplom7a98s1t0lhass8 | default        |
      +----------------------+----------------+
      ```

   1. Select the `ID` or `NAME` of the network you need.
   1. Change the parameters of the cloud network by specifying its name:

      ```
      yc vpc network update enpavfmgapumnl7cqin8 --new-name test-network-renamed
      ```

      Result:
      ```
      id: enpavfmgapumnl7cqin8
      folder_id: b1g6ci08ma55klukmdjs
      created_at: "2018-10-23T14:05:32Z"
      name: test-network-renamed
      description: My first network
      labels:
        new_label: test_label
      ```

      You can pass the ID and name as positional arguments, or you can use the `--id` and -`-name` flags:

      ```
      yc vpc network update \
        --id enpavfmgapumnl7cqin8 \
        --new-name test-network-renamed \
        --labels new_label=test_label
      ```

      ```
      yc vpc network update \
        --name test-network-1 \
        --new-name test-network-renamed \
        --labels new_label=test_label
      ```

- API

   To update a [cloud network](../concepts/network.md), use the [update](../api-ref/Network/update.md) REST API method for the [Network](../api-ref/Network/index.md) resource or the [NetworkService/Update](../api-ref/grpc/network_service.md#Update) gRPC API call.

- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

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

      For more information about the parameters of the `yandex_vpc_network` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_network).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the cloud network using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```
      yc vpc network get <cloud network name>
      ```

{% endlist %}

## Examples {#examples}

### Updating a cloud network using its name {#using-name}

You can change a cloud network using its name instead of its ID:

{% list tabs %}

- CLI

   ```
   yc vpc network update test-network-1 \
     --new-name test-network-renamed \
     --labels new_label=test_label
   ```

   Result:
   ```
   id: enpavfmgapumnl7cqin8
   folder_id: b1g6ci08ma55klukmdjs
   created_at: "2018-10-23T14:05:32Z"
   name: test-network-renamed
   description: My first network
   labels:
     new_label: test_label
   ```

{% endlist %}
