# Creating a cloud network

In addition to the cloud network in the default folder, you can create cloud networks in other folders.

{% list tabs group=instructions %}

- Management console {#console}

  To create a [cloud network](../concepts/network.md):
  1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a cloud network.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter a name for the network. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}
	  
  1. (Optional) In the **{{ ui-key.yacloud.vpc.networks.create.field_description }}** field, add a network description.
  1. The default option is **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**. If you want to [create](subnet-create.md) subnets later, disable this option.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a [cloud network](../concepts/network.md):
  1. View the description of the CLI command for creating a cloud network:

      ```
      yc vpc network create --help
      ```

  1. Create a cloud network in the default folder:

      ```
      yc vpc network create \
        --name test-network-1 \
        --description "My test network"
      ```

      The `--name` and `--description` parameters are optional: you can create a network without any name and description and access it by ID.

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
      | enpiuvhhd4t8******** | test-network-1 |
      | enplom7a98s1******** | default        |
      +----------------------+----------------+
      ```

      Get the same list with more details in YAML format:

      ```
      yc vpc network list --format yaml
      ```

      Result:
      ```
      - id: enpiuvhhd4t8********
        folder_id: b1g6ci08ma55********
        created_at: "2018-10-23T11:12:51Z"
        name: test-network-1
        description: My first network
      - id: enplom7a98s1********
        folder_id: b1g6ci08ma55********
        created_at: "2018-09-24T08:23:00Z"
        name: default
        description: Auto-created default network
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the parameters of your [cloud network](../concepts/network.md):

     * `name`: Name of the cloud network. The naming requirements are as follows:

        {% include [name-format](../../_includes/name-format.md) %}

     * `description`: Cloud network description.
     * `labels`: Cloud network [labels](../../resource-manager/concepts/labels.md). Specify a key-value pair.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_vpc_network" "default" {
       name        = "<network_name>"
	   description = "<network_description>"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
     ```

     For more information about the `vpc_network` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/vpc_network).

  1. Make sure the configuration files are correct.

     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or these [CLI](../../cli/quickstart.md) commands:

        ```
        yc vpc network list
        ```

- API {#api}

  To create a [cloud network](../concepts/network.md), use the [create](../api-ref/Network/create.md) REST API method for the [Network](../api-ref/Network/index.md) resource or the [NetworkService/Create](../api-ref/grpc/Network/create.md) gRPC API call, and provide the following in the request:

    * ID of the folder the network will reside in, in the `folderId` parameter.
    * Name of the new network in the `name` parameter. The name must be 3 to 63 characters long, the last character cannot be a hyphen.
    * New network description in the `description` parameter. The description may be up to 256 characters long.

  The `name` and `description` parameters are optional: you can create a network without any name and description and access it by ID.

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

## Examples {#examples}

Create a cloud network with a name and description in the selected folder:

{% list tabs group=instructions %}

- CLI {#cli}

  ```
  yc vpc network create --name test-network-1 \
    --description "My test network" \
    --folder-id b1gnbfd11bq5********
  ```

- {{ TF }} {#tf}

  1. In the configuration file, describe the parameters of the cloud network to create:

     ```hcl
     resource "yandex_vpc_network" "default" {
       name        = "network-1"
	   description = "My first network"
     }
     ```

     For more information about resource properties in {{ TF }}, see the [relevant {{ TF }} documentation]({{ tf-provider-resources-link }}/vpc_network).

  1. Make sure the configuration files are correct.

     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or these [CLI](../../cli/quickstart.md) commands:

        ```
        yc vpc network list
        ```

{% endlist %}
