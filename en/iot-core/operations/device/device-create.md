# Creating a device

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. [View the list of registries](../registry/registry-list.md#registry-list) where you can create a device or [create a new registry](../registry/registry-create.md).

  1. Create a device:

      ```
      $ yc iot device create --registry-name my-registry --name my-device
      
      id: b9135goeh1uc1s2i07nm
      registry_id: b91ki3851hab9m0l68je
      created_at: "2019-05-28T16:08:30.938Z"
      name: my-device
      ```

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Make sure the device was created:

      ```
      $ yc iot device list --registry-name  my-registry
      +----------------------+-----------+
      |          ID          |   NAME    |
      +----------------------+-----------+
      | b9135goeh1uc1s2i07nm | my-device |
      +----------------------+-----------+
      ```

- Terraform

   {% include [terraform-definition](../../../solutions/_solutions_includes/terraform-definition.md) %}

   If you don't have Terraform, [install it and configure the Yandex.Cloud provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% note info %}

   To add certificates to the device, [create](../certificates/create-certificates.md) them in advance.

   {% endnote %}

   To create a device:

   1. [View the list of registries](../registry/registry-list.md#registry-list) where you can create a device or [create a new registry](../registry/registry-create.md).

   1. In the configuration file, describe the parameters of the resource to create:
      * `yandex_iot_core_device`: Device parameters:
        * `registry_id`: ID of the registry to create a device in.
        * `name`: Device name.
        * `description`: Device description.
        * `aliases`: Topic aliases. For more information, see [Creating an alias](../device/alias/alias-create.md)
        * `passwords`: List of passwords for authorization using a [username and password](../../concepts/authorization.md#log-pass).
        * `certificates`: List of certificates for authorization using [certificates](../../concepts/authorization.md#certs).

      Sample resource structure in the configuration file:

      ```
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<registry ID>"
        name        = "test-device"
        description = "test device for terraform provider documentation"
      
        aliases = {
          "some-alias1/subtopic" = "$devices/{id}/events/somesubtopic",
          "some-alias2/subtopic" = "$devices/{id}/events/aaa/bbb",
        }
      
        passwords = [
          "<password>",
        ]
      
        certificates = [
          file("<path to the certificate file>")
        ]
      }
      ```

      For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

   2. Make sure that the configuration files are correct.
      1. In the command line, go to the directory where you created the configuration file.
      2. Run the check using the command:

         ```
         $ terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

   3. Deploy the cloud resources.
      1. If the configuration doesn't contain any errors, run the command:

         ```
         $ terraform apply
         ```
      2. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}

