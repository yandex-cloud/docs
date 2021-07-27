---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating a device

{% list tabs %}

- Management console

   To create a device:
   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a device.
   1. Select **{{ iot-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. Click **Add device**.
   1. Specify **basic parameters** for the device:
      - Enter a device **Name**. For example, `my-device`.
      - (optional) Add a **Description** with additional information about the device.
      - Set a **Password** that you'll use to access the device.<br/>To do this, you can use the [password generator](https://passwordsgenerator.net/).<br/>Don't forget to save your password because you'll need it later.
   1. (optional) Add [aliases](../../concepts/topic.md#aliases):
      1. Click **Add alias**.
      1. Fill in the fields: enter an alias (for example, `events`) and the topic type after `$devices/<deviceID>` (for example, `events`).<br/>You can use the `events` alias instead of the `$devices/<deviceID>/events` topic.
   1. (optional) Add [certificates](../../operations/certificates/create-certificates.md):
      - To add a file:
         1. Choose the **File** method.
         1. Click **Select file**.
         1. Specify the certificate file on your computer and click **Open**.
         1. Click **Add**.
      - To add text:
         1. Choose the **Text** method.
         1. Insert the certificate body in the **Contents** field.
         1. Click **Add**.
   1. Click **Add**.

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

   If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in [management console]({{ link-console-main }}).

{% endlist %}

