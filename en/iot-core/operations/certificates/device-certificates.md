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
   1. Select **{{ iot-short-name }}**.
   1. Click on the name of the registry.
   1. In the left menu, select **Devices**.
   1. Select the desired device from the list.
   1. On the **Overview** page, go to the **Certificates** section and click **Add certificate**.

      - To add a file:

         1. Choose the **File** method.
         1. Click **Select file**.
         1. Specify the certificate file on your computer and click **Open**.
         1. Click **Add**.

      - To add text:

         1. Choose the **Text** method.
         1. Insert the certificate body in the **Contents** field.
         1. Click **Add**.

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
   device_id: b9135goeh1uc1s2i07nm
   fingerprint: 65e5b050069da5ca5996a4a8a92514098b0a5dd1
   certificate_data: |
     -----BEGIN CERTIFICATE-----
     MIIE/jCCAuagAwI...
     -----END CERTIFICATE-----
   created_at: "2019-05-29T17:14:18.804Z"
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add a certificate to a device created using {{ TF }}:

   1. In the configuration file, describe the parameters of resources that you want to create:

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

      For more information about the `yandex_iot_core_device` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_device).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.
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

   You can add a certificate to a device using the API [addCertificate](../../api-ref/Device/addCertificate.md) method.

{% endlist %}

## Deleting a certificate {#delete-cert}

{% list tabs %}

- Management console

   To delete a device certificate:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the device certificate from.
   1. Select **{{ iot-short-name }}**.
   1. Click on the name of the registry.
   1. In the left menu, select **Devices**.
   1. Select the desired device from the list.
   1. On the **Overview** page, go to the **Certificates** section.
   1. In the row with the certificate in question, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

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

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

      For more information about the `yandex_iot_core_device` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_device).
   1. In the command line, change to the folder where you edited the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.
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

   You can delete a device certificate using the API [deleteCertificate](../../api-ref/Device/deleteCertificate.md) method.

{% endlist %}