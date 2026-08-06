# Managing device certificates

{% include [iot-sunset-warning](../../../_includes/iot-core/sunset-warning.md) %}

To start exchanging data and commands between devices and registries, you need to [authenticate](../../concepts/authorization.md). This section describes how to manage device certificates for the relevant authentication method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Viewing a list of device certificates](device-certificates.md#list-cert)
* [Adding a certificate to a device](device-certificates.md#add-cert)
* [Deleting a device certificate](device-certificates.md#delete-cert)

To access a [device](../../concepts/index.md#device), use its unique ID or name. For information on how to get the unique ID or name of a device, see [{#T}](../device/device-list.md)

## Getting a list of certificates {#device-certificates-list}

{% include [device-certificates-list](../../../_includes/iot-core/device-certificates-list.md) %}

## Adding a certificate {#add-cert}

{% list tabs group=instructions %}

- Management console {#console}

   To add a device certificate:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to add a device certificate.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Click the registry name.
   1. Navigate to **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Select the device from the list.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, navigate to **{{ ui-key.yacloud.iot.label_certificates }}** and click **{{ ui-key.yacloud.component.certificates.button_empty-add }}**.

      - To add a file:

         1. Select the `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` method.
         1. Click **Attach file**.
         1. Specify the certificate file on your computer and click **Open**.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      - To add text:

         1. Select the `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` method.
         1. Paste the certificate body into the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Add a certificate to the device:

  ```bash
  yc iot device certificate add \
    --device-name my-device \ # Device name.
    --certificate-file device-cert.pem # Path to the public part of the certificate.
  ```

  Result:
  ```text
  device_id: b9135goeh1uc********
  fingerprint: 65e5b050069da5ca5996a4a8a9251409********
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAwI...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T17:14:18.804Z"
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To add a certificate to a device created with {{ TF }}:
  
  1. In the configuration file, specify the properties of the resources you want to create:

     * `yandex_iot_core_device`: Device properties:
       * `registry_id`: [ID of the registry](../registry/registry-list.md#registry-list) where you are creating your device.
       * `name`: [Device name](../device/device-list.md#device-list).
       * `description`: Device description.
       * `certificates`: List of certificates for [certificate](../../concepts/authorization.md#certs)-based authentication.

      Here is an example of a device description in the {{ TF }} configuration:

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

      For more information about `yandex_iot_core_device` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_device).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Type `yes` and press **Enter** to confirm the changes.

      You can check device certificates in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device certificate list --device-name <device_name>
      ```

- API {#api}

  To add a certificate to a device, use the [addCertificate](../../api-ref/Device/addCertificate.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/AddCertificate](../../api-ref/grpc/Device/addCertificate.md) gRPC API call.

{% endlist %}

## Deleting a certificate {#delete-cert}

{% list tabs group=instructions %}

- Management console {#console}

   To delete a device certificate:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a device certificate.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Click the registry name.
   1. Navigate to **{{ ui-key.yacloud.iot.label_devices }}**.
   1. Select the device from the list.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, go to the **{{ ui-key.yacloud.iot.label_certificates }}** section.
   1. In the row with the certificate, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}** from the drop-down list.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete a device certificate:

      ```bash
      yc iot device certificate delete --device-name my-device --fingerprint 65...
      ```

  1. Make sure the certificate has been deleted:

      ```bash
      yc iot device certificate list --device-name my-device
	    ```

	    Result:
	  
	    ```text
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a certificate of a device created with {{ TF }}:
  
  1. Open the {{ TF }} configuration file and delete the certificate value from the `certificates` section in the device description. To remove all certificates, delete the entire `certificates` section.

      Here is an example of a device description in the {{ TF }} configuration:

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

      For more information about `yandex_iot_core_device` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_device).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Type `yes` and press **Enter** to confirm the changes.

      You can check device certificates using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot device certificate list --device-name <device_name>
      ```

- API {#api}

  To delete a device certificate, use the [deleteCertificate](../../api-ref/Device/deleteCertificate.md) REST API method for the [Device](../../api-ref/Device/index.md) resource or the [DeviceService/DeleteCertificate](../../api-ref/grpc/Device/deleteCertificate.md) gRPC API call.

{% endlist %}