# Creating a device

{% list tabs %}

- Management console

   To create a device:

   1. In the [management console]({{ link-console-main }}), select a folder where you wish to create a device.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. Click **Add device**.
   1. Under **General information**, add:
      * **Name** of the device. For example, `my-device`.
      * (optional) A **description** with further information about the device.
      * A **password** that you will be using for device access.<br/>You can use a [password generator](https://passwordsgenerator.net/) to create one.<br/>Make sure to save the password - you will need it later.
   1. (optional) Add [aliases](../../concepts/topic/usage.md#aliases):
      1. Click **Add alias**.
      1. Complete the fields: enter an alias (such as, `events`) and topic type after `$devices/<deviceID>` (such as, `events`).<br/>You can use the `events` alias to replace `$devices/<deviceID>/events`.
   1. (optional) Add [certificates](../../operations/certificates/create-certificates.md):
      * To add a file:
         1. Choose the **File** method.
         1. Click **Select file**.
         1. Specify the certificate file on your computer and click **Open**.
         1. Click **Add**.
      * To add text:
         1. Choose the **Text** method.
         1. Insert the certificate body in the **Contents** field.
         1. Click **Add**.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. [Review a list of the registries](../registry/registry-list.md#registry-list) where you can create a device or [create a new registry](../registry/registry-create.md).

   1. Create a device:

      ```
      yc iot device create --registry-name my-registry --name my-device
      ```

      {% include [name-format](../../../_includes/name-format.md) %}

      Result:
      ```
      id: b9135goeh1uc1s2i07nm
      registry_id: b91ki3851hab9m0l68je
      created_at: "2019-05-28T16:08:30.938Z"
      name: my-device
      ```

   1. Make sure the device was created:

      ```
      yc iot device list --registry-name  my-registry
      ```

      Result:
      ```
      +----------------------+-----------+
      |          ID          |   NAME    |
      +----------------------+-----------+
      | b9135goeh1uc1s2i07nm | my-device |
      +----------------------+-----------+
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% note info %}

   To add certificates to a device, [generate](../certificates/create-certificates.md) them in advance.

   {% endnote %}

   To create a device:

   1. [Review a list of the registries](../registry/registry-list.md#registry-list) where you can create a device or [create a new registry](../registry/registry-create.md).

   1. In the configuration file, describe the parameters of the resource to create:

      * `yandex_iot_core_device`: Device parameters:
        * `registry_id`: ID of the registry to create a device in.
        * `name`: Device name.
        * `description`: Device description.
        * `aliases`: Topic aliases. For more detail, please see [Creating an alias](../device/alias/alias-create.md)
        * `passwords`: List of passwords for authorization using a [username and password](../../concepts/authorization.md#log-pass).
        * `certificates`: List of certificates for authorization using [certificates](../../concepts/authorization.md#certs).

      Example configuration file structure:

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
          file("<path to certificate file>")
        ]
      }
      ```

      For more information about the resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).

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
      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}
