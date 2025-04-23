---
title: How to create a broker
description: Follow this guide to create a broker.
---

# Creating a broker

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a broker.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
  1. Click **{{ ui-key.yacloud.iot.button_create-broker }}**.
  1. Under **{{ ui-key.yacloud.common.section-base }}**, specify:

      * Broker **{{ ui-key.yacloud.common.name }}**, e.g., `my-broker`.
      * (Optional) **{{ ui-key.yacloud.common.description }}**: Additional information about the broker.
      * (Optional) **{{ ui-key.yacloud.common.password }}** if you are going to use it instead of a certificate to access the broker. To create a password, you can use the [password generator](https://passwordsgenerator.net/).

          {% note info %}

          Make sure to save your password, as you will need it for [authentication](../../concepts/authorization.md).

          {% endnote %}

      * (Optional) To assign a label to the broker, fill in the **{{ ui-key.yacloud.component.key-values-input.label_key }}** and **{{ ui-key.yacloud.component.key-values-input.label_value }}** fields and click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.

  1. (Optional) Add a [certificate](../certificates/create-certificates.md):

      * To add a file:

          1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` method.
          1. Click **Attach file**.
          1. Select the file with the public key of the certificate and click **Open**.
          1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      * To add text:

          1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` method.
          1. Paste the certificate's public key to the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
          1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create a broker:

      ```bash
      yc iot broker create --name <broker_name>
      ```

      The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

      Result:

      ```text
      id: b91ki3851h**********
      folder_id: aoek49ghmk*********
      created_at: "2022-05-28T11:29:42.420Z"
      name: <broker_name>
      status: ACTIVE
      ```

  1. (Optional) Assign the broker a password for authentication with a [username and password](../../concepts/authorization.md#log-pass):

      ```bash
      yc iot broker password add --broker-name <broker_name>
      ```

      You will be prompted to enter a password. Password requirements:

      * The password must contain numbers, upper-case and lower-case letters, and special characters.
      * It must be at least 14 characters long.

      Result:

      ```text
      broker_id: b91ki3851h**********
      id: aoek49ghmk*********
      created_at: "2022-05-28T11:32:42.420Z"
      ```

  1. (Optional) Add to the broker a certificate for authentication with [certificates](../../concepts/authorization.md#certs):

      ```bash
      yc iot broker certificate add \
         --broker-name <broker_name> \
         --certificate-file <certificate>
      ```

      Where:

      * `--broker-name`: Broker name.
      * `--certificate-file`: Path to the public key of the certificate, e.g., `cert.pem`.

      Result:

      ```text
      broker_id: b91ki3851h**********
      fingerprint: 1f21cf6d0183d****
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIEpDCCAow...
         -----END CERTIFICATE-----
      created_at: "2023-07-11T16:20:53.466370019Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note info %}

  To add certificates to a broker, [generate](../certificates/create-certificates.md) them in advance.

  {% endnote %}

  To create a broker:
     
  1. In the configuration file, describe the parameters of the resource to create:

     * `yandex_iot_core_broker`: Broker parameters:
       * `name`: Broker name.
       * `description`: Broker description.
       * `labels`: Broker labels in `key:value` format.
       * `certificates`: List of broker certificates for authentication with [certificates](../certificates/create-certificates.md).

      Here is an example of the resource structure in the configuration file:

      ```
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
        labels = {
          test-label = "label-test"
        }

        certificates = [
          file("<path_to_first_certificate_file>"),
          file("<path_to_second_certificate_file>")
        ]
      }

      output "yandex_iot_core_broker_my_broker" {
        value = "${yandex_iot_core_broker.my_broker.id}"
      }
      ```

      For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iot_core_broker).

  1. Make sure the configuration files are correct.
      1. In the command line, go to the folder where you created the configuration file.
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

      1. Confirm that you want to create the resources.
      
          All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

          ```bash
          yc iot broker list
          ```

- API {#api}

  To create a broker, use the [create](../../broker/api-ref/Broker/create.md) REST API method for the [Broker](../../broker/api-ref/Broker/index.md) resource or the [BrokerService/Create](../../broker/api-ref/grpc/Broker/create.md) gRPC API call.

{% endlist %}
