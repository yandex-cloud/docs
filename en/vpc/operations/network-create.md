# Creating a cloud network

In addition to the cloud network in the default folder, you can create cloud networks in other folders.

{% list tabs %}

- Management console

   To create a [cloud network](../concepts/network.md):
   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a cloud network.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the top-right corner, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
   1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter a name for the network. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. (Optional) In the **{{ ui-key.yacloud.vpc.networks.create.field_description }}** field, add a network description.
   1. The default option is **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**. If you want to [create](subnet-create.md) the subnets later, disable this option.
   1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a [cloud network](../concepts/network.md):
   1. See the description of the CLI command for creating a cloud network:

      ```
      yc vpc network create --help
      ```

   1. Create a cloud network in the default folder:

      ```
      yc vpc network create \
        --name test-network-1 \
        --description "My test network"
      ```

      The `--name` and `--description` flags are optional: you can create a network without any name or description and access it by ID.

      The network naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Get a list of all cloud networks in the default folder:

      ```
      yc vpc network list
      ```

      Result:
      ```
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpiuvhhd4t80k4n80i8 | test-network-1 |
      | enplom7a98s1t0lhass8 | default        |
      +----------------------+----------------+
      ```

      Get the same list with more details in YAML format:

      ```
      yc vpc network list --format yaml
      ```

      Result:
      ```
      - id: enpiuvhhd4t80k4n80i8
        folder_id: b1g6ci08ma55klukmdjs
        created_at: "2018-10-23T11:12:51Z"
        name: test-network-1
        description: My first network
      - id: enplom7a98s1t0lhass8
        folder_id: b1g6ci08ma55klukmdjs
        created_at: "2018-09-24T08:23:00Z"
        name: default
        description: Auto-created default network
      ```

- API

   To create a [cloud network](../concepts/network.md), use the [create](../api-ref/Network/create.md) REST API method for the [Network](../api-ref/Network/index.md) resource or the [NetworkService/Create](../api-ref/grpc/network_service.md#Create) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of your cloud network:

      * `name`: Name of the cloud network. The requirements are as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `description`: Description of the cloud network.
      * `labels`: Cloud network [labels](../../resource-manager/concepts/labels.md). Set a key-value pair.

      Example of the configuration file structure:

      ```hcl
      resource "yandex_vpc_network" "default" {
        name        = "<cloud network name>"
        description = "<cloud network description>"
        labels = {
          tf-label    = "tf-label-value"
          empty-label = ""
        }
      }
      ```

      For more information about the parameters of the `vpc_network` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_network).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

         ```
         yc vpc network list
         ```

{% endlist %}

## Examples {#examples}

Create a cloud network with a name and description in the selected folder:

{% list tabs %}

- CLI

   ```
   yc vpc network create --name test-network-1 \
     --description "My test network" \
     --folder-id b1gnbfd11bq5g5vnjgr4
   ```

- {{ TF }}

   1. In the configuration file, describe the parameters of the cloud network to create:

      ```hcl
      resource "yandex_vpc_network" "default" {
        name        = "network-1"
        description = "My first network"
      }
      ```

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/vpc_network).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

         ```
         yc vpc network list
         ```

{% endlist %}
