---
title: "Creating a device"
description: "Follow this guide to create a device."
---

# Creating a device

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder to create a device in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the required registry from the list.
   1. On the left side of the window, select the **{{ ui-key.yacloud.iot.label_devices }}** section.
   1. Click **{{ ui-key.yacloud.iot.button_add-device }}**.
   1. Under **{{ ui-key.yacloud.common.section-base }}**, add:

      * Device **{{ ui-key.yacloud.common.name }}**, e.g., `my-device`.
      * (Optional) **{{ ui-key.yacloud.common.description }}** with additional information about the device.
      * (Optional) **{{ ui-key.yacloud.common.password }}** that you will use to access the device. To create a password, you can use the [password generator](https://passwordsgenerator.net/).

         {% note info %}

         Make sure to save your password, as you will need it for [authentication](../../concepts/authorization.md).

         {% endnote %}

   1. (Optional) Add [aliases](../../concepts/topic/usage.md#aliases):

      1. Click **{{ ui-key.yacloud.iot.button_add-alias }}**.
      1. Fill in the fields by providing an alias, e.g., `events`, and the topic type after `$devices/<deviceID>`, e.g., `events`. You can use the `events` alias instead of the `$devices/<deviceID>/events` topic.

   1. (Optional) Add a [certificate](../../operations/certificates/create-certificates.md):

      * To add a file:

         1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` method.
         1. Click **Attach file**.
         1. Select the file with the public key of the certificate and click **Open**.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      * To add text:

         1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` method.
         1. Paste the public key of the certificate to the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. [Review a list of the registries](../registry/registry-list.md#registry-list) where you can create a device or [create a new registry](../registry/registry-create.md).

   1. Create a device:

      ```bash
      yc iot device create \
         --registry-name <registry name> \
         --name <device name>
      ```

      The device naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

      Result:

      ```text
      id: b9135goeh**********
      registry_id: b91ki3851h**********
      created_at: "2019-05-28T16:08:30.938Z"
      name: <device name>
      status: ACTIVE
      ```

   1. (Optional) Assign the device a password for authentication using a [username and password](../../concepts/authorization.md#log-pass):

      ```bash
      yc iot device password add --device-name <device name>
      ```

      You will be prompted to enter a password. Password requirements:

      * The password must contain numbers, upper-case and lower-case letters, and special characters.
      * It must be at least 14 characters long.

      Result:

      ```text
      device_id: b9135goeh**********
      id: aoek49ghmk*********
      created_at: "2019-05-28T16:12:30.938Z"
      ```

   1. (Optional) Add a certificate to the device for authentication using [certificates](../../concepts/authorization.md#certs):

      ```bash
      yc iot device certificate add \
         --device-name <device name> \
         --certificate-file <certificate>
      ```

      Where:

      * `--device-name`: Device name
      * `--certificate-file`: Path to the public key of the certificate, such as `cert.pem`.

      Result:

      ```text
      device_id: b9135goeh**********
      fingerprint: 589ce16050****
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIE/jCCAuagAwIBAgIJAPRA...
         -----END CERTIFICATE-----
      created_at: "2019-05-28T16:15:30.938Z"
      ```

   1. (Optional) Add [aliases](../../concepts/topic/usage.md#aliases):

      ```bash
      yc iot device add-topic-aliases \
         --name <device name> \
         --topic-aliases <alias>='<topic>'
      ```

      For example:

      ```bash
      yc iot device add-topic-aliases \
         --name my-device \
         --topic-aliases events='$devices/are0ej5kpik15mulb4do/events'
      ```

      Result:

      ```text
      id: aoek49ghmk*********
      registry_id: b91ki3851h**********
      created_at: "2019-05-28T16:17:30.938Z"
      name: <device name>
      topic_aliases:
        <alias>: <topic>
      status: ACTIVE
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   {% note info %}

   To add certificates to a device, [generate](../certificates/create-certificates.md) them in advance.

   {% endnote %}

   To create a device:

   1. [Review a list of the registries](../registry/registry-list.md#registry-list) where you can create a device or [create a new registry](../registry/registry-create.md).

   1. In the configuration file, describe the parameters of the resource to create:

      * `yandex_iot_core_device`: Device parameters:

         * `registry_id`: ID of the registry to create a device in.
         * `name`: Device name
         * `description`: Device description
         * `aliases`: Topic aliases. For more detail, please see [Creating an alias](../device/alias/alias-create.md).
         * `passwords`: List of passwords for authentication using a [username and password](../../concepts/authorization.md#log-pass).
         * `certificates`: List of certificates for authentication using [certificates](../../concepts/authorization.md#certs).

      {% note info %}

      Make sure to use only one of the two authentication methods.

      {% endnote %}

      Here is an example of the resource structure in the configuration file:

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

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
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

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

   To create a device, use the [create](../../api-ref/Device/create.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/Create](../../api-ref/grpc/device_service.md#Create) gRPC API call.

{% endlist %}
