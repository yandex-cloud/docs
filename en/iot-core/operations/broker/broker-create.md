# Creating a broker

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a broker.
   1. Select **{{ iot-short-name }}**.
   1. On the left-hand panel, select **Brokers**.
   1. Click **Create broker**.
   1. Under **General information**, specify:
      * Broker **name**. For example, `my-broker`.
      * (optional) **Description**: Additional information about the broker.
      * (optional) **Password** that you will use to access the broker. To create a password, you can use the [password generator](https://passwordsgenerator.net/). Don't forget to save your password, you'll need it.
      * (optional) To assign a label to the broker, fill in the **Key** and **Value** fields and click **Add label**.
   1. (optional) Add [certificates](../../operations/certificates/create-certificates.md):
      * To add a file:
         1. Choose the **File** method.
         1. Click **Select file**.
         1. Select the certificate file on your computer and click **Open**.
         1. Click **Add**.
      * To add text:
         1. Choose the **Text** method.
         1. Insert the certificate body in the **Contents** field.
         1. Click **Add**.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Create a broker:

      ```
      yc iot broker create --name my-broker
      ```

      {% include [name-format](../../../_includes/name-format.md) %}

      Result:

      ```
      id: b91ki3851h**********
      folder_id: aoek49ghmk*********
      created_at: "2022-05-28T11:29:42.420Z"
      name: my-broker
      ```

   1. Make sure the broker was created:

      ```
      yc iot broker list
      ```

      Result:
      ```
      +----------------------+-------------+
      |          ID          |    NAME     |
      +----------------------+-------------+
      | b91ki3851h********** |  my-broker  |
      +----------------------+-------------+
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% note info %}

   To add certificates to a broker, [generate](../certificates/create-certificates.md) them in advance.

   {% endnote %}

   To create a broker:

   1. In the configuration file, describe the parameters of the resource to create:

      * `yandex_iot_core_broker`: Broker parameters:
         * `name`: Broker name.
         * `description`: Broker description.
         * `labels`: Broker labels in `key:value` format.
         * `certificates`: List of broker certificates for authorization using [certificates](../../concepts/authorization.md#certs).

      Sample resource structure in the configuration file:

      ```
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        labels = {
          test-label = "label-test"
        }

        certificates = [
          file("<path_to_first_file_with_certificate>"),
          file("<path_to_second_file_with_certificate>")
        ]
      }

      output "yandex_iot_core_broker_my_broker" {
        value = "${yandex_iot_core_broker.my_broker.id}"
      }
      ```

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_broker).

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
         yc iot broker list
         ```

- API

   You can create a broker using the API [create](../../broker/api-ref/Broker/create.md) method.

{% endlist %}
