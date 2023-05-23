# Managing registry certificates

For devices and registries to begin exchanging data and commands, you need to [log in](../../concepts/authorization.md). This section describes how to manage registry certificates for the appropriate authorization method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

- [Viewing a list of registry certificates](registry-certificates.md#list-cert)
- [Adding a certificate to a registry](registry-certificates.md#add-cert)
- [Deleting a registry certificate](registry-certificates.md#delete-cert)

To access a [registry](../../concepts/index.md#registry), use its unique ID or name. For information on retrieving the unique registry ID or name, see [{#T}](../registry/registry-list.md).

## Getting a list of registry certificates {#registry-certificates-list}

{% include [registry-certificates-list](../../../_includes/iot-core/registry-certificates-list.md) %}

## Adding a certificate {#add-cert}

{% list tabs %}

- Management console

   To add a certificate to a registry:

   1. In the [management console]({{ link-console-main }}), select the folder to add the registry certificate to.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
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

   Add a certificate to the registry:

   ```
   yc iot registry certificate add \
     --registry-name my-registry \ # Registry name.
     --certificate-file registry-cert.pem # Path to the public part of the certificate.
   ```

   Result:
   ```
   registry_id: b91ki3851hab9m0l68je
   fingerprint: 589ce1605...
   certificate_data: |
     -----BEGIN CERTIFICATE-----
     MIIE/jCCAuagAw...
     -----END CERTIFICATE-----
   created_at: "2019-05-29T16:40:48.230Z"
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add a certificate to a registry created using {{ TF }}:

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `yandex_iot_core_registry`: Registry parameters:
         * `name`: Registry name.
         * `description`: Registry description.
         * `certificates`: List of registry certificates for authorization using [certificates](../../concepts/authorization.md#certs).

      Example registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        certificates = [
          file("<path_to_first_certificate_file>"),
          file("<path_to_second_certificate_file>")
        ]
      ...
      }
      ```

      For more information about the `yandex_iot_core_registry` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_registry).
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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify registry certificates in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry certificate list --registry-name <registry_name>
      ```

- API

   To add a certificate to a registry, use the [addCertificate](../../api-ref/Registry/addCertificate.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/AddCertificate](../../api-ref/grpc/registry_service.md#AddCertificate) gRPC API call.

{% endlist %}

## Deleting a certificate {#delete-cert}

{% list tabs %}

- Management console

   To delete a registry certificate:

   1. In the [management console]({{ link-console-main }}), select the folder to delete the registry certificate from.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. On the **Overview** page, go to the **Certificates** section.
   1. In the row with the certificate in question, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Delete a registry certificate:

      ```
      yc iot registry certificate delete --registry-name my-registry --fingerprint 0f...
      ```

   1. Make sure the certificate was deleted:

      ```
      yc iot registry certificate list --registry-name my-registry
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

   For more information about {{ TF }}, [see our documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete the certificate of a registry created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the value of the certificate in the `certificates` block, in the fragment with the registry description. To remove all certificates, delete the entire `certificates` block.

      Example registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        certificates = [
          file("<path_to_first_certificate_file>"),
          file("<path_to_second_certificate_file>")
        ]
      ...
      }
      ```

      For more information about the `yandex_iot_core_registry` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iot_core_registry).
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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify registry certificates in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry certificate list --registry-name <registry_name>
      ```

- API

   To delete a registry certificate, use the [deleteCertificate](../../api-ref/Registry/deleteCertificate.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/DeleteCertificate](../../api-ref/grpc/registry_service.md#DeleteCertificate) gRPC API call.

{% endlist %}