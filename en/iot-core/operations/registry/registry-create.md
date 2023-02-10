# Creating a registry

{% list tabs %}

- Management console

   To create a registry:

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your registry.
   1. Select **{{ iot-short-name }}**.
   1. Click **Create registry**.
   1. Under **General information**, add:
      * A **name** for the registry. For example, `my-registry`.
      * (optional) A **description** with further information about the registry.
      * A **password** that you will be using for registry access.<br/>You can use a [password generator](https://passwordsgenerator.net/) to create one.<br/>Make sure to save the password - you will need it later.
      * (optional) To assign a label to the registry, fill in the **Key** and **Value** fields and click **Add label**.
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

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Create a registry:

      ```
      yc iot registry create --name my-registry
      ```

      {% include [name-format](../../../_includes/name-format.md) %}

      Result:

      ```
      id: b91ki3851hab9m0l68je
      folder_id: aoek49ghmknnpj1ll45e
      created_at: "2019-05-28T11:29:42.420Z"
      name: my-registry
      ```

   1. Make sure the registry was created:

      ```
      yc iot registry list
      ```

      Result:
      ```
      +----------------------+-------------+
      |          ID          |    NAME     |
      +----------------------+-------------+
      | b91ki3851hab9m0l68je | my-registry |
      +----------------------+-------------+
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% note info %}

   To add certificates to a registry, [generate](../certificates/create-certificates.md) them in advance.

   {% endnote %}

   To create a device registry:

   1. In the configuration file, describe the parameters of the resource to create:

      * `yandex_iot_core_registry`: Registry parameters:
         * `name`: Registry name.
         * `description`: Registry description.
         * `labels`: Registry labels in `key:value` format.
         * `passwords`: List of registry passwords for authorization using a [username and password](../../concepts/authorization.md#log-pass).
         * `certificates`: List of registry certificates for authorization using [certificates](../../concepts/authorization.md#certs).

      Sample resource structure in the configuration file:

      ```
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
        labels = {
          test-label = "label-test"
        }

        passwords = [
          "<password_1>",
          "<password_2>"
        ]

        certificates = [
          file("<path_to_first_certificate_file>"),
          file("<path_to_second_certificate_file>")
        ]
      }

      output "yandex_iot_core_registry_my_registry" {
        value = "${yandex_iot_core_registry.my_registry.id}"
      }
      ```

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_registry).

   1. Make sure that the configuration files are valid.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm that you want to create the resources.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

         ```bash
         yc iot registry list
         ```

- API

   You can create a registry using the API [create](../../api-ref/Registry/create.md) method.

{% endlist %}