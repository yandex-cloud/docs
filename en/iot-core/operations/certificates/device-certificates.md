# Managing device certificates

For devices and registries to begin exchanging data and commands, you need to [log in](../../concepts/authorization.md). This section describes how to manage device certificates for the relevant authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Viewing a list of device certificates](device-certificates.md#list-cert)
* [Adding a certificate to a device](device-certificates.md#add-cert)
* [Deleting a device certificate](device-certificates.md#delete-cert)

To access a [device](../../concepts/index.md#device), use its unique ID or name. For information on retrieving the unique device ID or name, see [{#T}](../device/device-list.md).

## Getting a list of certificates {#device-certificates-list}

{% include [device-certificates-list](../../../_includes/iot-core/device-certificates-list.md) %}

## Adding a certificate {#add-cert}

{% list tabs %}

- Management console

   To add a device certificate:

   1. In the [management console]({{ link-console-main }}), select the folder to add the device certificate to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Click the name of the registry.
   1. Go to **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Select the device from the list.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, go to the **{{ ui-key.yacloud.iot.label_certificates }}** section and click **{{ ui-key.yacloud.component.certificates.button_empty-add }}**.

      - To add a file:

         1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` method.
         1. Click **Attach file**.
         1. Specify the certificate file on your computer and click **Open**.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      - To add text:

         1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` method.
         1. Insert the certificate body in the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Add a certificate to the device:

   ```
   yc iot device certificate add \
     --device-name my-device \ # Device name.
     --certificate-file device-cert.pem # Path to the public part of the certificate.
   ```

   Result:
   ```
   device_id: b9135goeh1uc********
   fingerprint: 65e5b050069da5ca5996a4a8a92514098b0a5dd1
   certificate_data: |
     -----BEGIN CERTIFICATE-----
     MIIE/jCCAuagAwI...
     -----END CERTIFICATE-----
   created_at: "2019-05-29T17:14:18.804Z"
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To add a certificate to a device created using {{ TF }}:

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `yandex_iot_core_device`: Device parameters:
         * `registry_id`: [ID of the registry](../registry/registry-list.md#registry-list) to create a device in.
         * `name`: [Device name](../device/device-list.md#device-list).
         * `description`: Device description.
         * `certificates`: List of certificates for authorization using [certificates](../../concepts/authorization.md#certs).

      Example device description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<registry_ID>"
        name        = "<device_name>"
        description = "test device for terraform provider documentation"
      ...
        certificates = [
          file("<path_to_certificate_file>")
        ]
      ...
      }
      ```

      For more information about the `yandex_iot_core_device` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iot_core_device).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify device certificates in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device certificate list --device-name <device_name>
      ```

- API

   To add a certificate to a device, use the [addCertificate](../../api-ref/Device/addCertificate.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/AddCertificate](../../api-ref/grpc/device_service.md#AddCertificate) gRPC API call.

{% endlist %}

## Deleting a certificate {#delete-cert}

{% list tabs %}

- Management console

   To delete a device certificate:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the device certificate from.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Click the name of the registry.
   1. Go to **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Select the device from the list.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, go to the **{{ ui-key.yacloud.iot.label_certificates }}** section.
   1. In the row with the certificate in question, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}** from the drop-down list.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Delete a device certificate:

      ```
      yc iot device certificate delete --device-name my-device --fingerprint 65...
      ```

   1. Make sure the certificate was deleted:

      ```
      yc iot device certificate list --device-name my-device
      ```

      Result:

      ```
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To delete the certificate of a device created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the value of the certificate in the `certificates` block, in the fragment with the device description. To remove all certificates, delete the entire `certificates` block.

      Example device description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<registry_ID>"
        name        = "<device_name>"
        description = "test device for terraform provider documentation"
      ...
        certificates = [
          file("<path_to_certificate_file>")
        ]
      ...
      }
      ```

      For more information about the `yandex_iot_core_device` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iot_core_device).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify device certificates in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device certificate list --device-name <device_name>
      ```

- API

   To delete a device certificate, use the [deleteCertificate](../../api-ref/Device/deleteCertificate.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/DeleteCertificate](../../api-ref/grpc/device_service.md#DeleteCertificate) gRPC API call.

{% endlist %}