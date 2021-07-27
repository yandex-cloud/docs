---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating a registry

{% list tabs %}

- Management console

   To create a registry:
   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a registry.
   1. Select **{{ iot-name }}**.
   1. Click **Create registry**.
   1. Specify **basic parameters** for the registry:
      - Enter the registry **Name**. For example, `my-registry`.
      - (optional) Add a **Description** with additional information about the registry.
      - Set a **Password** that you'll use to access the registry.<br/>To do this, you can use a [password generator](https://passwordsgenerator.net/).<br/>Don't forget to save your password because you'll need it later.
      - (optional) To assign a label to the registry, fill in the **Key** and **Value** fields and click **Add label**.
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
   1. Click **Create**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create a registry:

     ```
     $ yc iot registry create --name my-registry
     
      id: b91ki3851hab9m0l68je
      folder_id: aoek49ghmknnpj1ll45e
      created_at: "2019-05-28T11:29:42.420Z"
      name: my-registry
     ```

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Make sure the registry was created:

      ```
      $ yc iot registry list
       +----------------------+-------------+
       |          ID          |    NAME     |
       +----------------------+-------------+
       | b91ki3851hab9m0l68je | my-registry |
       +----------------------+-------------+
      ```

- Terraform

   {% include [terraform-definition](../../../solutions/_solutions_includes/terraform-definition.md) %}

   If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% note info %}

   To add certificates to the registry, [create](../certificates/create-certificates.md) them in advance.

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
          "<password 1>",
          "<password 2>"
        ]
      
        certificates = [
          file("<path to the first certificate file>"),
          file("<path to the second certificate file>")
        ]
      }
      
      output "yandex_iot_core_registry_my_registry" {
        value = "${yandex_iot_core_registry.my_registry.id}"
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