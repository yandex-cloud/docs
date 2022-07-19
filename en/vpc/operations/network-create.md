# Creating a cloud network

In addition to the cloud network in the default folder, you can create cloud networks in other folders.

{% list tabs %}

- Management console

   To create a [cloud network](../concepts/network.md):
   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a cloud network.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click **Create network**.
   1. Enter the network name:

      {% include [name-format](../../_includes/name-format.md) %}

   1. (optional) Add a network description.
   1. The default option is [Create subnets](subnet-create.md). If you need to create subnets later, disable the option.
   1. Click **Create network**.

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
      yc vpc network create --name test-network-1 \
          --description "My test network"
      ```

      {% include [name-format](../../_includes/name-format.md) %}

      The `--name` and `--description` flags are optional: you can create a network without any name or description and access it by ID.

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

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of your cloud network:

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

      Where:
      * `name`: Name of the cloud network. Name format:

         {% include [name-format](../../_includes/name-format.md) %}

      * `description`: Description of the cloud network.
      * `labels`: Cloud network [labels](https://cloud.yandex.ru/docs/overview/concepts/services#labels). Set a key-value pair.

      For more information about the parameters of the `vpc_network` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/vpc_network).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

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

      For more information about the resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/vpc_network).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc vpc network list
         ```

{% endlist %}
