---
title: Creating a {{ iot-full-name }} registry
description: Follow this guide to create a {{ iot-name }} registry.
---

# Creating a registry

{% include [iot-sunset-warning](../../../_includes/iot-core/sunset-warning.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your registry.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_registries }}**.
  1. Click **{{ ui-key.yacloud.iot.button_create-registry }}**.
  1. Under **{{ ui-key.yacloud.common.section-base }}**, specify the following:

      * Registry **{{ ui-key.yacloud.common.name }}**, e.g., `my-registry`.
      * Optionally, **{{ ui-key.yacloud.common.description }}** with additional information about the registry.
      * **{{ ui-key.yacloud.common.password }}** to use when accessing the registry. To create a password, you can use [this password generator](https://passwordsgenerator.net/).

          {% include [password-save](../../../_includes/iot-core/password-save.md) %}

      * Optionally, to assign a label to the registry, fill out the **{{ ui-key.yacloud.component.key-values-input.label_key }}** and **{{ ui-key.yacloud.component.key-values-input.label_value }}** fields and click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.

  1. Optionally, add a [certificate](../certificates/create-certificates.md):

      * To add a file:

        1. Select the `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` method.
        1. Click **Attach file**.
        1. Select the file with the certificate’s public key and click **Open**.
        1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      * To add text:

        1. Select the `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` method.
        1. Paste the certificate’s public key into the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
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

  1. Optionally, set a password for the registry for [username and password](../../concepts/authorization.md#log-pass) authentication:

      ```bash
      yc iot registry password add --registry-name <registry_name>
      ```

      You will be prompted to enter a password. Follow these password requirements:

      * The password must contain numbers, uppercase and lowercase letters, and special characters.
      * The password must be at least 14 characters long.

      Result:

      ```text
      registry_id: b91hafek85**********
      id: aoek49ghmk*********
      created_at: "2019-05-27T13:44:06.923Z"
      ```

  1. Optionally, add a certificate to the registry for [certificate](../../concepts/authorization.md#certs)-based authentication:

      ```bash
      yc iot registry certificate add \
         --registry-name <registry_name> \
         --certificate-file <certificate>
      ```

      Where:

      * `--registry-name`: Registry name.
      * `--certificate-file`: Path to the public key of the certificate, e.g., `cert.pem`.

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

  To add certificates to a registry, [create](../certificates/create-certificates.md) them in advance.

  {% endnote %}

  To create a device registry: 
     
  1. In the configuration file, describe the resource you want to create:

     * `yandex_iot_core_registry`: Registry settings:

        * `name`: Registry name.
        * `description`: Registry description.
        * `labels`: Registry labels in `key:value` format.
        * `passwords`: List of registry passwords for [username and password](../../concepts/authorization.md#log-pass) authentication.
        * `certificates`: List of registry certificates for [certificate](../../concepts/authorization.md#certs)-based authentication.

      {% note info %}

      Use only one of the two authentication methods.

      {% endnote %}

      Here is an example of a resource structure in the configuration file:

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

      For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_registry).
      
  1. Make sure the configuration files are correct.
      1. In the terminal, navigate to the directory where you created your configuration file.
      1. Run a check using this command:

          ```
          terraform plan
          ```

      If the configuration is correct, the terminal will display a list of the resources and their settings. {{ TF }} will show any errors detected in the configuration. 
         
  1. Deploy the cloud resources.

      1. If the configuration is correct, run this command:
   
          ```
          terraform apply
          ```

      1. Confirm creating the resources.
      
          This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

          ```bash
          yc iot registry list
          ```

- API {#api}

  To create a registry, use the [create](../../api-ref/Registry/create.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Create](../../api-ref/grpc/Registry/create.md) gRPC API call.

{% endlist %}