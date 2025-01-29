---
title: Creating a {{ iot-full-name }} registry
description: Follow this guide to create a {{ iot-name }} registry.
---

# Creating a registry

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a registry in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_registries }}**.
  1. Click **{{ ui-key.yacloud.iot.button_create-registry }}**.
  1. Under **{{ ui-key.yacloud.common.section-base }}**, add:

      * Registry **{{ ui-key.yacloud.common.name }}**, e.g., `my-registry`.
      * (Optional) **{{ ui-key.yacloud.common.description }}** with additional information about the registry.
      * **{{ ui-key.yacloud.common.password }}** that you will use to access the registry. To create a password, you can use the [password generator](https://passwordsgenerator.net/).

          {% include [password-save](../../../_includes/iot-core/password-save.md) %}

      * (Optional) To assign a label to the registry, fill in the **{{ ui-key.yacloud.component.key-values-input.label_key }}** and **{{ ui-key.yacloud.component.key-values-input.label_value }}** fields and click **{{ ui-key.yacloud.iot.button_add-label }}**.

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

  1. Create a registry:

      ```bash
      yc iot registry create --name <registry_name>
      ```

      The registry naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

      Result:

      ```text
      id: b91hafek85**********
      folder_id: aoek49ghmk*********
      created_at: "2019-05-27T13:40:06.923Z"
      name: <registry_name>
      status: ACTIVE
      log_group_id: ckghotead**********
      ```

  1. (Optional) Assign the registry a password for authentication with a [username and password](../../concepts/authorization.md#log-pass):

      ```bash
      yc iot registry password add --registry-name <registry_name>
      ```

      You will be prompted to enter a password. Password requirements:

      * The password must contain numbers, upper-case and lower-case letters, and special characters.
      * It must be at least 14 characters long.

      Result:

      ```text
      registry_id: b91hafek85**********
      id: aoek49ghmk*********
      created_at: "2019-05-27T13:44:06.923Z"
      ```

  1. (Optional) Add to the registry a certificate for authentication with [certificates](../../concepts/authorization.md#certs):

      ```bash
      yc iot registry certificate add \
         --registry-name <registry_name> \
         --certificate-file <certificate>
      ```

      Where:

      * `--registry-name`: Registry name.
      * `--certificate-file`: Path to the public key of the certificate, such as `cert.pem`.

      Result:

      ```text
      registry_id: b91hafek85**********
      fingerprint: 589ce16050****
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIE/jCCAuagAwIBAgIJAPRA...
         -----END CERTIFICATE-----
      created_at: "2019-05-27T13:41:45.295Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
   
  {% note info %}

  To add certificates to a registry, [generate](../certificates/create-certificates.md) them in advance.

  {% endnote %}

  To create a device registry: 
     
  1. In the configuration file, describe the parameters of the resource to create:

     * `yandex_iot_core_registry`: Registry parameters:

        * `name`: Registry name.
        * `description`: Registry description.
        * `labels`: Registry labels in `key:value` format.
        * `passwords`: List of registry passwords for authentication with a [username and password](../../concepts/authorization.md#log-pass).
        * `certificates`: List of registry certificates for authentication with [certificates](../../concepts/authorization.md#certs).

      {% note info %}

      Make sure to use only one of the two authentication methods.

      {% endnote %}

      Here is an example of the resource structure in the configuration file:

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

      For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/iot_core_registry).
      
  1. Make sure the configuration files are correct.
      1. In the command line, go to the folder where you created the configuration file.
      1. Run a check using this command:

          ```
          terraform plan
          ```

      If the configuration is correct, the terminal will display a list of resources to create and their parameters. If the configuration contains any errors, {{ TF }} will point them out. 
         
  1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:
   
          ```
          terraform apply
          ```

      1. Confirm creating the resources.
      
          All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

          ```bash
          yc iot registry list
          ```

- API {#api}

  To create a registry, use the [create](../../api-ref/Registry/create.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Create](../../api-ref/grpc/Registry/create.md) gRPC API call.

{% endlist %}